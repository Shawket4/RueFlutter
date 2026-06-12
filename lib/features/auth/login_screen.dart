import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/l10n/l10n.dart';
import '../../core/providers/auth_notifier.dart';
import '../../core/services/connectivity_service.dart';
import '../../core/storage/storage_service.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/sufrix_logo.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/pin_pad.dart';
import '../../shared/widgets/status_chip.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  EPHEMERAL STATE — autoDispose provider (resets when the screen unmounts).
//  Controllers (name text/focus, shake animation) stay in the State.
// ─────────────────────────────────────────────────────────────────────────────

class _LoginFormState {
  final String pin;
  final bool loading;

  /// Set when an online attempt failed at the network layer — keeps the
  /// "Sign in offline" escape hatch visible even after connectivity flaps.
  final bool offerOffline;

  const _LoginFormState({
    this.pin = '',
    this.loading = false,
    this.offerOffline = false,
  });

  _LoginFormState copyWith({String? pin, bool? loading, bool? offerOffline}) =>
      _LoginFormState(
        pin: pin ?? this.pin,
        loading: loading ?? this.loading,
        offerOffline: offerOffline ?? this.offerOffline,
      );
}

final _loginFormProvider =
    NotifierProvider.autoDispose<_LoginFormController, _LoginFormState>(
        _LoginFormController.new);

class _LoginFormController extends AutoDisposeNotifier<_LoginFormState> {
  bool _disposed = false;

  @override
  _LoginFormState build() {
    ref.onDispose(() => _disposed = true);
    return const _LoginFormState();
  }

  void setPin(String pin) {
    if (_disposed) return;
    state = state.copyWith(pin: pin);
  }

  void setLoading(bool loading) {
    if (_disposed) return;
    state = state.copyWith(loading: loading);
  }

  /// Online submit finished. Network failure isn't the teller's fault: keep
  /// the PIN so "Sign in offline" works in one tap, and offer it. Wrong
  /// name/PIN: clear the PIN for re-entry, keep the name.
  void finishSubmit({required bool connFail, required bool failed}) {
    if (_disposed) return;
    state = state.copyWith(
      loading: false,
      offerOffline: connFail ? true : null,
      pin: (failed && !connFail) ? '' : null,
    );
  }

  /// Offline unlock finished — on failure clear the PIN for re-entry.
  void finishUnlock({required bool failed}) {
    if (_disposed) return;
    state = state.copyWith(loading: false, pin: failed ? '' : null);
  }
}

/// Full-screen brand moment (outside the navigation shell): split layout on
/// wide screens (brand panel + form), single column on phones.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _nameCtrl = TextEditingController();
  final _nameFocus = FocusNode();

  static const _max = 6;

  late final AnimationController _shakeCtrl;
  late final Animation<double> _shakeAnim;

  @override
  void initState() {
    super.initState();
    _shakeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _shakeAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -8.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: -6.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -6.0, end: 6.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 6.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _shakeCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _nameFocus.dispose();
    _shakeCtrl.dispose();
    super.dispose();
  }

  /// `friendlyError` produces exactly these two messages for network-layer
  /// failures; everything else is a server response (wrong name/PIN, etc.).
  bool _isConnectionError(String msg) =>
      msg == 'No internet connection' ||
      msg == 'Request timed out — check your connection';

  void _clearAuthError() {
    if (ref.read(authProvider).error != null) {
      ref.read(authProvider.notifier).clearError();
    }
  }

  void _digit(String d) {
    final form = ref.read(_loginFormProvider);
    if (form.loading || form.pin.length >= _max) return;
    // Keep focus predictable: dismiss the name keyboard once PIN entry starts.
    if (form.pin.isEmpty && _nameFocus.hasFocus) _nameFocus.unfocus();
    final pin = form.pin + d;
    ref.read(_loginFormProvider.notifier).setPin(pin);
    _clearAuthError();
    if (pin.length == _max) {
      // Auto-submit at 6 digits; route straight to the offline unlock when
      // the device knows it has no connection.
      ref.read(isOnlineProvider) ? _submit() : _offlineUnlock();
    }
  }

  void _back() {
    final form = ref.read(_loginFormProvider);
    if (form.loading || form.pin.isEmpty) return;
    ref
        .read(_loginFormProvider.notifier)
        .setPin(form.pin.substring(0, form.pin.length - 1));
  }

  bool _validateInputs() {
    final s = l10n(context);
    if (_nameCtrl.text.trim().isEmpty) {
      _shakeCtrl.forward(from: 0);
      ref.read(_loginFormProvider.notifier).setPin('');
      ref.read(authProvider.notifier).setError(s.loginErrorEnterName);
      return false;
    }
    if (ref.read(_loginFormProvider).pin.length < 4) {
      _shakeCtrl.forward(from: 0);
      ref.read(authProvider.notifier).setError(s.loginErrorEnterPin);
      return false;
    }
    return true;
  }

  Future<void> _submit() async {
    if (ref.read(_loginFormProvider).loading || !_validateInputs()) return;

    final ctl = ref.read(_loginFormProvider.notifier);
    ctl.setLoading(true);
    final err = await ref.read(authProvider.notifier).login(
        name: _nameCtrl.text.trim(), pin: ref.read(_loginFormProvider).pin);
    if (!mounted) return;

    final connFail = err != null && _isConnectionError(err);
    ctl.finishSubmit(connFail: connFail, failed: err != null);
    if (err != null && !connFail) _shakeCtrl.forward(from: 0);
  }

  Future<void> _offlineUnlock() async {
    if (ref.read(_loginFormProvider).loading || !_validateInputs()) return;

    final ctl = ref.read(_loginFormProvider.notifier);
    ctl.setLoading(true);
    final err = await ref.read(authProvider.notifier).offlineUnlock(
        name: _nameCtrl.text.trim(), pin: ref.read(_loginFormProvider).pin);
    if (!mounted) return;

    ctl.finishUnlock(failed: err != null);
    if (err != null) _shakeCtrl.forward(from: 0);
    // On success the router redirects automatically.
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final expiry = ref.watch(authProvider.select((s) => s.sessionExpiry));
    final blockedBy = ref.watch(authProvider.select((s) => s.blockedByName));
    final authError = ref.watch(authProvider.select((s) => s.error));
    final isOnline = ref.watch(isOnlineProvider);
    final formState = ref.watch(_loginFormProvider);

    final wide = !context.isPhone && MediaQuery.sizeOf(context).width >= 900;

    // The blocked banner already explains the failure — don't repeat it.
    final displayError =
        expiry == SessionExpiry.blockedByOtherShift ? null : authError;

    final form = _buildForm(
      wide: wide,
      isOnline: isOnline,
      expiry: expiry,
      blockedBy: blockedBy,
      displayError: displayError,
      formState: formState,
    );

    // SafeArea lives INSIDE each pane: the brand panel and scaffold color
    // must paint edge-to-edge (under status bar / home indicator), or the
    // system-inset strips show through in a different color.
    return Scaffold(
      backgroundColor: wide ? t.surface : t.bg,
      body: wide
          ? Row(children: [
              const Expanded(flex: 55, child: _BrandPanel()),
              Expanded(flex: 45, child: SafeArea(child: form)),
            ])
          : SafeArea(child: form),
    );
  }

  Widget _buildForm({
    required bool wide,
    required bool isOnline,
    required SessionExpiry expiry,
    required String? blockedBy,
    required String? displayError,
    required _LoginFormState formState,
  }) {
    final t = context.tokens;
    final s = l10n(context);
    final connError =
        displayError != null && _isConnectionError(displayError);

    Widget shaken(Widget child) => AnimatedBuilder(
          animation: _shakeAnim,
          builder: (_, c) =>
              Transform.translate(offset: Offset(_shakeAnim.value, 0), child: c),
          child: child,
        );

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpace.xxl, vertical: 48),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            if (!wide) ...[
              const SufrixLogo(size: 64),
              const SizedBox(height: AppSpace.xxl),
            ],
            Text(
              s.loginWelcome,
              style: ui(size: 24, weight: FontWeight.w800, color: t.textPrimary),
            ),
            const SizedBox(height: AppSpace.xs),
            Text(
              s.loginSubtitle,
              textAlign: TextAlign.center,
              style: ui(size: 14, color: t.textSecondary, height: 1.45),
            ),
            // Which branch this till is bound to (from device setup) — with a
            // quiet path back to setup. (Settings also offers reconfigure,
            // but a signed-out device bound to the wrong branch can't reach
            // Settings at all.)
            Consumer(builder: (context, ref, _) {
              final name =
                  ref.watch(storageServiceProvider).deviceBranchName;
              if (name == null || name.isEmpty) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: const EdgeInsets.only(top: AppSpace.sm),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  StatusChip(
                    label: name,
                    tone: ChipTone.info,
                    icon: Icons.storefront_rounded,
                  ),
                  TextButton(
                    onPressed: () => context.go('/device-setup'),
                    child: Text(
                      s.settingsReconfigureDevice,
                      style: ui(size: 12, color: t.textMuted),
                    ),
                  ),
                ]),
              );
            }),
            const SizedBox(height: AppSpace.xxl),

            if (expiry == SessionExpiry.expired)
              _NoticeBanner(
                icon: Icons.lock_clock_outlined,
                text: s.loginSessionExpiredBanner,
                fg: t.warning,
                bg: t.warningBg,
              ),

            if (expiry == SessionExpiry.blockedByOtherShift &&
                blockedBy != null)
              _NoticeBanner(
                icon: Icons.block_rounded,
                text: s.loginBlockedBanner(blockedBy),
                fg: t.danger,
                bg: t.dangerBg,
                bold: true,
              ),

            if (!isOnline)
              _NoticeBanner(
                icon: Icons.wifi_off_rounded,
                text: s.loginOfflineBanner,
                fg: t.warning,
                bg: t.warningBg,
              ),

            shaken(TextField(
              controller: _nameCtrl,
              focusNode: _nameFocus,
              enabled: !formState.loading,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.done,
              onChanged: (_) => _clearAuthError(),
              style: ui(size: 15, color: t.textPrimary),
              decoration: InputDecoration(
                hintText: s.loginNameHint,
                prefixIcon: const Icon(Icons.person_outline_rounded, size: 18),
              ),
            )),
            const SizedBox(height: AppSpace.xl),

            shaken(PinPad(
              pin: formState.pin,
              maxLength: _max,
              onDigit: _digit,
              onBackspace: _back,
            )),

            // Error lives directly under the PIN pad: connection problems get
            // a warning tone + wifi-off icon, credential problems get danger.
            AnimatedSize(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              child: displayError != null
                  ? Padding(
                      padding:
                          const EdgeInsetsDirectional.only(top: AppSpace.sm),
                      child: _NoticeBanner(
                        icon: connError
                            ? Icons.wifi_off_rounded
                            : Icons.error_outline_rounded,
                        text: displayError,
                        fg: connError ? t.warning : t.danger,
                        bg: connError ? t.warningBg : t.dangerBg,
                        margin: EdgeInsetsDirectional.zero,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            const SizedBox(height: AppSpace.xl),

            AppButton(
              label: isOnline ? s.loginSignIn : s.loginSignInOffline,
              icon: isOnline ? null : Icons.wifi_off_rounded,
              loading: formState.loading,
              width: double.infinity,
              height: 52,
              onTap: isOnline ? _submit : _offlineUnlock,
            ),
            const SizedBox(height: AppSpace.sm),
            Text(
              s.loginAutoSubmitHint,
              textAlign: TextAlign.center,
              style: ui(size: 12, color: t.textMuted),
            ),

            if (isOnline && formState.offerOffline) ...[
              const SizedBox(height: AppSpace.lg),
              AppButton(
                label: s.loginSignInOffline,
                icon: Icons.wifi_off_rounded,
                variant: BtnVariant.outline,
                width: double.infinity,
                onTap: formState.loading ? null : _offlineUnlock,
              ),
              const SizedBox(height: AppSpace.sm),
              Text(
                s.loginOfflineExplain,
                textAlign: TextAlign.center,
                style: ui(size: 12, color: t.textMuted, height: 1.4),
              ),
            ],

            if (!wide) ...[
              const SizedBox(height: AppSpace.xxl),
              Text(
                s.commonCopyright(DateTime.now().year),
                textAlign: TextAlign.center,
                style: ui(size: 12, color: t.textMuted),
              ),
            ],
          ]),
        ),
      ),
    );
  }
}

/// Inline tinted notice — used for session/connection banners and the
/// PIN-pad error so tone (warning vs danger) is obvious at a glance.
class _NoticeBanner extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color fg;
  final Color bg;
  final bool bold;
  final EdgeInsetsGeometry margin;

  const _NoticeBanner({
    required this.icon,
    required this.text,
    required this.fg,
    required this.bg,
    this.bold = false,
    this.margin = const EdgeInsetsDirectional.only(bottom: AppSpace.lg),
  });

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        margin: margin,
        padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: fg.withOpacity(0.25)),
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, size: 16, color: fg),
          const SizedBox(width: AppSpace.sm + 2),
          Expanded(
            child: Text(
              text,
              style: ui(
                size: 13,
                weight: bold ? FontWeight.w700 : FontWeight.w500,
                color: fg,
                height: 1.4,
              ),
            ),
          ),
        ]),
      );
}

/// Brand side of the split layout (wide screens only).
class _BrandPanel extends StatelessWidget {
  const _BrandPanel();

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final s = l10n(context);
    final xwide = MediaQuery.sizeOf(context).width >= 1280;

    return ColoredBox(
      color: t.surfaceAlt,
      child: SafeArea(
        child: Padding(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: xwide ? 80 : 56,
          vertical: 56,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SufrixLongLogo(
              height: 40,
              textColor: t.textPrimary,
              crossColor: t.textPrimary,
              centerColor: t.accent,
            ),
            const Spacer(),
            Text(
              s.loginWelcomeBack,
              style: ui(
                size: xwide ? 48 : 36,
                weight: FontWeight.w800,
                color: t.textPrimary,
                height: 1.15,
              ),
            ),
            const SizedBox(height: AppSpace.lg),
            Text(
              s.loginBrandTagline,
              style: ui(size: 16, color: t.textSecondary, height: 1.65),
            ),
            const Spacer(),
            Row(children: [
              Container(
                width: 6,
                height: 6,
                decoration:
                    BoxDecoration(color: t.accent, shape: BoxShape.circle),
              ),
              const SizedBox(width: AppSpace.sm),
              Text(
                s.commonCopyright(DateTime.now().year),
                style: ui(size: 12, color: t.textMuted),
              ),
            ]),
          ],
        ),
        ),
      ),
    );
  }
}
