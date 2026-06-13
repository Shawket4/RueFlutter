import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/l10n/l10n.dart';
import '../../core/models/branch.dart';
import '../../core/providers/auth_notifier.dart';
import '../../core/storage/storage_service.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/sufrix_logo.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/empty_state.dart';
import '../../shared/widgets/surface_card.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  EPHEMERAL STATE — wizard step/loading/error/branches in one autoDispose
//  provider (resets when the screen unmounts). Text controllers stay in State.
// ─────────────────────────────────────────────────────────────────────────────

class _SetupState {
  final int step;
  final bool loading;
  final String? error;
  final List<Branch> branches;
  final bool obscurePass;

  const _SetupState({
    this.step = 0,
    this.loading = false,
    this.error,
    this.branches = const [],
    this.obscurePass = true,
  });

  _SetupState copyWith({
    int? step,
    bool? loading,
    String? error,
    List<Branch>? branches,
    bool? obscurePass,
  }) =>
      _SetupState(
        step: step ?? this.step,
        loading: loading ?? this.loading,
        error: error,
        branches: branches ?? this.branches,
        obscurePass: obscurePass ?? this.obscurePass,
      );
}

final _setupProvider =
    NotifierProvider.autoDispose<_SetupController, _SetupState>(
        _SetupController.new);

class _SetupController extends AutoDisposeNotifier<_SetupState> {
  bool _disposed = false;

  @override
  _SetupState build() {
    ref.onDispose(() => _disposed = true);
    return const _SetupState();
  }

  void toggleObscure() {
    if (_disposed) return;
    state = state.copyWith(
        obscurePass: !state.obscurePass, error: state.error);
  }

  void setError(String message) {
    if (_disposed) return;
    state = state.copyWith(error: message);
  }

  void start() {
    if (_disposed) return;
    state = state.copyWith(loading: true, error: null);
  }

  void fail(String message) {
    if (_disposed) return;
    state = state.copyWith(loading: false, error: message);
  }

  void branchesLoaded(List<Branch> branches) {
    if (_disposed) return;
    state = state.copyWith(
        loading: false, branches: branches, step: 1, error: null);
  }

  void backToLogin() {
    if (_disposed) return;
    state = state.copyWith(step: 0, error: null);
  }

  void setLoading(bool loading) {
    if (_disposed) return;
    state = state.copyWith(loading: loading, error: state.error);
  }
}

/// One-time device setup: a manager signs in with email + password, picks the
/// branch this till serves, and from then on teller PIN logins carry that
/// branch automatically. The manager token is never kept.
class DeviceSetupScreen extends ConsumerStatefulWidget {
  const DeviceSetupScreen({super.key});

  @override
  ConsumerState<DeviceSetupScreen> createState() => _DeviceSetupScreenState();
}

class _DeviceSetupScreenState extends ConsumerState<DeviceSetupScreen> {
  final _emailCtrl    = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _continue() async {
    final s = l10n(context);
    final ctl = ref.read(_setupProvider.notifier);
    final email = _emailCtrl.text.trim();
    final password = _passwordCtrl.text;
    if (email.isEmpty || password.isEmpty) {
      ctl.setError(s.setupEnterCredentials);
      return;
    }

    ctl.start();
    final result = await ref
        .read(authProvider.notifier)
        .fetchBranchesForSetup(email: email, password: password);
    if (!mounted) return;
    if (result.error != null) {
      ctl.fail(result.error!);
    } else {
      ctl.branchesLoaded(result.branches);
    }
  }

  Future<void> _selectBranch(Branch branch) async {
    if (ref.read(_setupProvider).loading) return;
    ref.read(_setupProvider.notifier).setLoading(true);
    await ref.read(authProvider.notifier).confirmBranch(branch);
    if (!mounted) return;
    // The redirect only re-evaluates on navigation/auth events — go explicitly.
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final setup = ref.watch(_setupProvider);
    return Scaffold(
      backgroundColor: t.bg,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpace.xl),
              child: setup.step == 0
                  ? _buildLoginStep(setup)
                  : _buildBranchStep(setup),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginStep(_SetupState setup) {
    final t = context.tokens;
    final s = l10n(context);
    // Reachable from the login screen's "Reconfigure device" link — an
    // already-configured device needs a way back out.
    final alreadyConfigured =
        ref.read(storageServiceProvider).isDeviceConfigured;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (alreadyConfigured)
          Row(children: [
            IconButton(
              onPressed: setup.loading ? null : () => context.go('/login'),
              icon: Icon(Icons.arrow_back_rounded,
                  color: t.textPrimary, size: 22),
            ),
            const Spacer(),
          ]),
        const Center(child: SufrixLongLogo(height: 44)),
        const SizedBox(height: AppSpace.xxl),
        Text(s.setupConnectDevice,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center),
        const SizedBox(height: AppSpace.sm),
        Text(s.setupConnectSubtitle,
            style: ui(size: 14, color: t.textSecondary, height: 1.5),
            textAlign: TextAlign.center),
        const SizedBox(height: AppSpace.xl),
        SurfaceCard(
          child: Column(children: [
            TextField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              enabled: !setup.loading,
              decoration: InputDecoration(
                labelText: s.setupEmail,
                prefixIcon: const Icon(Icons.mail_outline_rounded, size: 20),
              ),
            ),
            const SizedBox(height: AppSpace.lg),
            TextField(
              controller: _passwordCtrl,
              obscureText: setup.obscurePass,
              enabled: !setup.loading,
              onSubmitted: (_) => _continue(),
              decoration: InputDecoration(
                labelText: s.setupPassword,
                prefixIcon: const Icon(Icons.lock_outline_rounded, size: 20),
                suffixIcon: IconButton(
                  icon: Icon(
                      setup.obscurePass
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 20),
                  onPressed: () =>
                      ref.read(_setupProvider.notifier).toggleObscure(),
                ),
              ),
            ),
          ]),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 150),
          child: setup.error == null
              ? const SizedBox.shrink()
              : _SetupErrorBanner(
                  message: setup.error!,
                  isConnection: _isConnectionError(setup.error!),
                  margin: const EdgeInsets.only(top: AppSpace.md),
                ),
        ),
        const SizedBox(height: AppSpace.xl),
        AppButton(
          label: s.setupContinue,
          loading: setup.loading,
          onTap: setup.loading ? null : _continue,
        ),
      ],
    );
  }

  bool _isConnectionError(String msg) =>
      msg == 'No internet connection' ||
      msg == 'Request timed out — check your connection';

  Widget _buildBranchStep(_SetupState setup) {
    final t = context.tokens;
    final s = l10n(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(children: [
          IconButton(
            onPressed: setup.loading
                ? null
                : () => ref.read(_setupProvider.notifier).backToLogin(),
            icon: Icon(Icons.arrow_back_rounded,
                color: t.textPrimary, size: 22),
          ),
          const Spacer(),
        ]),
        Text(s.setupSelectBranch,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center),
        const SizedBox(height: AppSpace.sm),
        Text(s.setupSelectBranchSubtitle,
            style: ui(size: 14, color: t.textSecondary, height: 1.5),
            textAlign: TextAlign.center),
        const SizedBox(height: AppSpace.xl),
        if (setup.branches.isEmpty)
          EmptyState(
            icon: Icons.storefront_outlined,
            title: s.setupNoBranches,
            actionLabel: s.retryAction,
            onAction: () => ref.read(_setupProvider.notifier).backToLogin(),
          )
        else
          ...setup.branches.map((b) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpace.md),
                child: SurfaceCard(
                  onTap: setup.loading ? null : () => _selectBranch(b),
                  child: Row(children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: t.navyBg,
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Icon(Icons.storefront_rounded,
                          color: t.navy, size: 22),
                    ),
                    const SizedBox(width: AppSpace.lg),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(b.name,
                              style:
                                  Theme.of(context).textTheme.titleMedium),
                          if ((b.address ?? '').isNotEmpty)
                            Text(b.address!,
                                style:
                                    ui(size: 12, color: t.textSecondary),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right_rounded,
                        color: t.textMuted, size: 22),
                  ]),
                ),
              )),
      ],
    );
  }
}

class _SetupErrorBanner extends StatelessWidget {
  final String message;
  final bool isConnection;
  final EdgeInsetsGeometry margin;

  const _SetupErrorBanner({
    required this.message,
    required this.isConnection,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final fg = isConnection ? t.warning : t.danger;
    final bg = isConnection ? t.warningBg : t.dangerBg;
    final icon = isConnection
        ? Icons.wifi_off_rounded
        : Icons.error_outline_rounded;

    return Container(
      width: double.infinity,
      margin: margin,
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 12),
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
            message,
            style: ui(size: 13, weight: FontWeight.w500, color: fg, height: 1.4),
          ),
        ),
      ]),
    );
  }
}
