import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/l10n/l10n.dart';
import '../../core/providers/auth_notifier.dart';
import '../../core/providers/locale_notifier.dart';
import '../../core/providers/shift_notifier.dart';
import '../../core/providers/theme_mode_notifier.dart';
import '../../core/storage/storage_service.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/app_log.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/sufrix_logo.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_top_bar.dart';
import '../../shared/widgets/confirm_sheet.dart';
import '../../shared/widgets/empty_state.dart';
import '../../shared/widgets/offline_banner.dart';
import '../../shared/widgets/section_header.dart';
import '../../shared/widgets/status_chip.dart';
import '../../shared/widgets/surface_card.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  EPHEMERAL STATE — private autoDispose providers (reset when screen unmounts).
// ─────────────────────────────────────────────────────────────────────────────

final _signingOutProvider = StateProvider.autoDispose<bool>((ref) => false);

/// Settings — rendered inside the persistent navigation shell.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const _appVersion = 'v1.0.0';

  void _copyVersion(BuildContext context) {
    Clipboard.setData(const ClipboardData(text: _appVersion));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n(context).settingsVersionCopied)),
    );
  }

  Future<void> _onSignOut(BuildContext context, WidgetRef ref) async {
    if (ref.read(_signingOutProvider)) return;
    ref.read(_signingOutProvider.notifier).state = true;
    final canLeave = await ref.read(authProvider.notifier).canLogout();
    if (!context.mounted) return;
    ref.read(_signingOutProvider.notifier).state = false;

    final s = l10n(context);
    if (!canLeave) {
      final goClose = await ConfirmSheet.show(
        context,
        title: s.shiftCloseFirstTitle,
        body: s.settingsCloseShiftFirstBody,
        confirmLabel: s.settingsGoCloseShift,
        icon: Icons.schedule_rounded,
      );
      if (goClose && context.mounted) context.goNamed('close-shift');
      return;
    }

    final confirmed = await ConfirmSheet.show(
      context,
      title: s.settingsSignOutTitle,
      body: s.settingsSignOutBody,
      confirmLabel: s.commonSignOut,
      destructive: true,
      icon: Icons.logout_rounded,
    );
    if (!context.mounted || !confirmed) return;
    await ref.read(authProvider.notifier).logout();
  }

  Future<void> _onReconfigureDevice(
      BuildContext context, WidgetRef ref) async {
    final s = l10n(context);

    // A live shift must be closed before the device can switch branches.
    if (ref.read(shiftProvider).hasOpenShift) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(s.settingsReconfigureShiftOpen)),
      );
      return;
    }

    final confirmed = await ConfirmSheet.show(
      context,
      title: s.settingsReconfigureTitle,
      body: s.settingsReconfigureBody,
      confirmLabel: s.settingsReconfigureConfirm,
      destructive: true,
      icon: Icons.settings_input_component_outlined,
    );
    if (!context.mounted || !confirmed) return;

    await ref.read(storageServiceProvider).clearDeviceConfig();
    await ref.read(authProvider.notifier).logout();
    // The router redirect lands on /device-setup now that config is gone.
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final s = l10n(context);
    final user = ref.watch(authProvider.select((a) => a.user));
    final branch = ref.watch(authProvider.select((a) => a.branch));
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeModeProvider);
    final signingOut = ref.watch(_signingOutProvider);

    final pad = context.responsive(phone: AppSpace.lg, tablet: AppSpace.xl);

    return Scaffold(
      backgroundColor: t.bg,
      body: Column(children: [
        AppTopBar(title: s.settings),
        Expanded(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: ListView(
                padding: EdgeInsets.all(pad),
                children: [
                  const OfflineBanner(),

                  // ── Account ────────────────────────────────────────────
                  if (user != null) ...[
                    SectionHeader(
                      title: s.settingsAccount,
                      padding: const EdgeInsetsDirectional.only(
                          start: AppSpace.xs, bottom: AppSpace.sm),
                    ),
                    SurfaceCard(
                      child: Row(children: [
                        _Avatar(name: user.name),
                        const SizedBox(width: AppSpace.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                              if (branch != null) ...[
                                const SizedBox(height: 2),
                                Row(children: [
                                  Icon(Icons.storefront_rounded,
                                      size: 13, color: t.textMuted),
                                  const SizedBox(width: AppSpace.xs),
                                  Flexible(
                                    child: Text(branch.name,
                                        style: ui(
                                            size: 12,
                                            color: t.textSecondary),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ]),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(width: AppSpace.sm),
                        StatusChip(
                          label: user.role.value
                              .replaceAll('_', ' ')
                              .toUpperCase(),
                          tone: ChipTone.info,
                        ),
                      ]),
                    ),
                  ],

                  // ── Appearance ─────────────────────────────────────────
                  SectionHeader(title: s.settingsAppearance),
                  SurfaceCard(
                    child: _SegmentedControl<ThemeMode>(
                      selected: themeMode,
                      options: [
                        _SegOption(ThemeMode.system, s.settingsThemeSystem,
                            Icons.brightness_auto_rounded),
                        _SegOption(ThemeMode.light, s.settingsThemeLight,
                            Icons.light_mode_rounded),
                        _SegOption(ThemeMode.dark, s.settingsThemeDark,
                            Icons.dark_mode_rounded),
                      ],
                      onSelect: (mode) =>
                          ref.read(themeModeProvider.notifier).set(mode),
                    ),
                  ),

                  // ── Language ───────────────────────────────────────────
                  SectionHeader(title: s.settingsLanguage),
                  SurfaceCard(
                    child: _SegmentedControl<String>(
                      selected: locale.languageCode == 'ar' ? 'ar' : 'en',
                      options: const [
                        _SegOption('en', 'English', Icons.language_rounded),
                        _SegOption('ar', 'العربية', Icons.language_rounded),
                      ],
                      onSelect: (code) => ref
                          .read(localeProvider.notifier)
                          .setLocale(Locale(code)),
                    ),
                  ),

                  // ── Diagnostics ────────────────────────────────────────
                  SectionHeader(title: s.settingsDiagnostics),
                  const _DiagnosticsCard(),

                  // ── About ──────────────────────────────────────────────
                  SectionHeader(title: s.settingsAbout),
                  SurfaceCard(
                    child: Row(children: [
                      const SufrixLogo(size: 44),
                      const SizedBox(width: AppSpace.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(s.appTitle,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium),
                            Text(s.commonCopyright(2026),
                                style: ui(size: 12, color: t.textMuted)),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpace.sm),
                      StatusChip(
                        label: _appVersion,
                        icon: Icons.copy_rounded,
                        onTap: () => _copyVersion(context),
                      ),
                    ]),
                  ),

                  // ── Device ─────────────────────────────────────────────
                  SectionHeader(title: s.settingsDeviceSection),
                  SurfaceCard(
                    onTap: () => _onReconfigureDevice(context, ref),
                    child: Row(children: [
                      Icon(Icons.settings_input_component_outlined,
                          color: t.textSecondary, size: 22),
                      const SizedBox(width: AppSpace.lg),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(s.settingsReconfigureDevice,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium),
                            Text(
                                ref
                                        .watch(storageServiceProvider)
                                        .deviceBranchName ??
                                    '',
                                style: ui(size: 12, color: t.textSecondary)),
                          ],
                        ),
                      ),
                      Icon(Icons.chevron_right_rounded,
                          color: t.textMuted, size: 22),
                    ]),
                  ),

                  // ── Sign out ───────────────────────────────────────────
                  const SizedBox(height: AppSpace.xxl),
                  AppButton(
                    label: s.commonSignOut,
                    icon: Icons.logout_rounded,
                    variant: BtnVariant.danger,
                    loading: signingOut,
                    onTap: () => _onSignOut(context, ref),
                  ),
                  const SizedBox(height: AppSpace.xl),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Avatar — initials on a navy-tinted square.
// ─────────────────────────────────────────────────────────────────────────────

class _Avatar extends StatelessWidget {
  final String name;
  const _Avatar({required this.name});

  String get _initials {
    final parts =
        name.trim().split(' ').where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0].substring(0, parts[0].length.clamp(0, 2)).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: t.navyBg,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      alignment: Alignment.center,
      child: Text(_initials,
          style: ui(size: 16, weight: FontWeight.w700, color: t.navy)),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Segmented control — token-aware, RTL-safe, equal-width segments.
// ─────────────────────────────────────────────────────────────────────────────

class _SegOption<T> {
  final T value;
  final String label;
  final IconData? icon;
  const _SegOption(this.value, this.label, [this.icon]);
}

class _SegmentedControl<T> extends StatelessWidget {
  final List<_SegOption<T>> options;
  final T selected;
  final ValueChanged<T> onSelect;

  const _SegmentedControl({
    required this.options,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
      padding: const EdgeInsets.all(AppSpace.xs),
      decoration: BoxDecoration(
        color: t.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: t.borderLight),
      ),
      child: Row(children: [
        for (final (i, option) in options.indexed) ...[
          if (i > 0) const SizedBox(width: AppSpace.xs),
          Expanded(child: _segment(context, t, option)),
        ],
      ]),
    );
  }

  Widget _segment(BuildContext context, AppTokens t, _SegOption<T> option) {
    final isSelected = option.value == selected;
    return AnimatedPressScale(
      onTap: () => onSelect(option.value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: AppSpace.sm),
        decoration: BoxDecoration(
          color: isSelected ? t.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.xs),
          border: Border.all(
              color: isSelected ? t.border : Colors.transparent),
          boxShadow: isSelected ? AppShadows.of(t) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (option.icon != null) ...[
              Icon(option.icon,
                  size: 16, color: isSelected ? t.accent : t.textMuted),
              const SizedBox(width: 6),
            ],
            Flexible(
              child: Text(option.label,
                  style: ui(
                      size: 13,
                      weight:
                          isSelected ? FontWeight.w700 : FontWeight.w600,
                      color:
                          isSelected ? t.textPrimary : t.textSecondary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Diagnostics — expandable warnings log (AppLog ring buffer).
// ─────────────────────────────────────────────────────────────────────────────

final _diagExpandedProvider = StateProvider.autoDispose<bool>((ref) => false);

/// Bumped after AppLog mutations so the card re-reads the static ring buffer.
final _logRevisionProvider = StateProvider.autoDispose<int>((ref) => 0);

class _DiagnosticsCard extends ConsumerWidget {
  const _DiagnosticsCard();

  void _copyAll(BuildContext context) {
    final text =
        AppLog.entries.reversed.map((e) => e.toString()).join('\n');
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n(context).settingsDiagnosticsCopied)),
    );
  }

  void _clear(WidgetRef ref) {
    AppLog.clear();
    ref.read(_logRevisionProvider.notifier).state++;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final s = l10n(context);
    final expanded = ref.watch(_diagExpandedProvider);
    ref.watch(_logRevisionProvider); // rebuild after clearing the log
    final entries = AppLog.entries.reversed.toList(); // newest first

    return SurfaceCard(
      padding: EdgeInsets.zero,
      child: Column(children: [
        AnimatedPressScale(
          onTap: () =>
              ref.read(_diagExpandedProvider.notifier).state = !expanded,
          child: Padding(
            padding: const EdgeInsets.all(AppSpace.lg),
            child: Row(children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: t.surfaceAlt,
                  borderRadius: BorderRadius.circular(AppRadius.xs),
                ),
                alignment: Alignment.center,
                child: Icon(Icons.terminal_rounded,
                    size: 18, color: t.textSecondary),
              ),
              const SizedBox(width: AppSpace.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s.settingsWarningsLog,
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 1),
                    Text(
                      entries.isEmpty
                          ? s.settingsNoWarnings
                          : s.settingsEntriesCount(entries.length),
                      style: ui(size: 12, color: t.textSecondary),
                    ),
                  ],
                ),
              ),
              if (entries.isNotEmpty) ...[
                StatusChip(
                    label: '${entries.length}', tone: ChipTone.warning),
                const SizedBox(width: AppSpace.sm),
              ],
              AnimatedRotation(
                turns: expanded ? 0.5 : 0,
                duration: const Duration(milliseconds: 200),
                child:
                    Icon(Icons.expand_more_rounded, color: t.textMuted),
              ),
            ]),
          ),
        ),
        if (expanded) ...[
          Divider(height: 1, color: t.borderLight),
          if (entries.isEmpty)
            EmptyState(
              icon: Icons.check_circle_outline_rounded,
              title: s.settingsNoWarnings,
              body: s.settingsWarningsBody,
            )
          else
            Padding(
              padding: const EdgeInsets.all(AppSpace.lg),
              child: Column(children: [
                Row(children: [
                  Expanded(
                    child: AppButton(
                      label: s.commonCopyAll,
                      icon: Icons.copy_rounded,
                      variant: BtnVariant.outline,
                      height: 42,
                      onTap: () => _copyAll(context),
                    ),
                  ),
                  const SizedBox(width: AppSpace.md),
                  Expanded(
                    child: AppButton(
                      label: s.commonClear,
                      icon: Icons.delete_outline_rounded,
                      variant: BtnVariant.ghost,
                      height: 42,
                      onTap: () => _clear(ref),
                    ),
                  ),
                ]),
                const SizedBox(height: AppSpace.sm),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 320),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: entries.length,
                    separatorBuilder: (_, __) =>
                        Divider(height: 1, color: t.borderLight),
                    itemBuilder: (_, i) => _LogRow(entry: entries[i]),
                  ),
                ),
              ]),
            ),
        ],
      ]),
    );
  }
}

class _LogRow extends StatelessWidget {
  final AppLogEntry entry;
  const _LogRow({required this.entry});

  String get _stamp {
    String two(int v) => v.toString().padLeft(2, '0');
    final at = entry.at;
    return '${at.year}-${two(at.month)}-${two(at.day)} '
        '${two(at.hour)}:${two(at.minute)}:${two(at.second)}';
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpace.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text(_stamp,
                style: ui(
                        size: 11,
                        weight: FontWeight.w600,
                        color: t.textMuted,
                        letterSpacing: 0.3)
                    .copyWith(fontFeatures: kTabularFigures)),
            const SizedBox(width: AppSpace.sm),
            Flexible(
              child: Text(entry.tag.toUpperCase(),
                  style: ui(
                      size: 11,
                      weight: FontWeight.w700,
                      color: t.warning,
                      letterSpacing: 0.4),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ),
          ]),
          const SizedBox(height: 2),
          Text(entry.message,
              style: ui(size: 12, color: t.textSecondary, height: 1.45)
                  .copyWith(fontFeatures: kTabularFigures)),
        ],
      ),
    );
  }
}
