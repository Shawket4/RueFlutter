import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// The one top bar. Back button (when the stack can pop), title, optional
/// subtitle, and trailing actions. RTL-safe by construction.
class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final List<Widget> actions;
  final Widget? leading;
  final VoidCallback? onBack;
  final bool showBack;

  const AppTopBar({
    super.key,
    required this.title,
    this.subtitle,
    this.actions = const [],
    this.leading,
    this.onBack,
    this.showBack = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final canPop = showBack && (onBack != null || Navigator.of(context).canPop());

    return Container(
      height: preferredSize.height + MediaQuery.paddingOf(context).top,
      padding: EdgeInsetsDirectional.only(
        top: MediaQuery.paddingOf(context).top,
        start: AppSpace.sm,
        end: AppSpace.lg,
      ),
      decoration: BoxDecoration(
        color: t.surface,
        border: Border(bottom: BorderSide(color: t.border)),
      ),
      child: Row(children: [
        if (leading != null)
          leading!
        else if (canPop)
          IconButton(
            onPressed: onBack ?? () => Navigator.of(context).maybePop(),
            icon: Icon(Icons.arrow_back_rounded,
                color: t.textPrimary, size: 22),
            tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          )
        else
          const SizedBox(width: AppSpace.sm),
        const SizedBox(width: AppSpace.xs),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: Theme.of(context).textTheme.titleLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
              if (subtitle != null)
                Text(subtitle!,
                    style: ui(size: 12, color: t.textSecondary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
        ...actions,
      ]),
    );
  }
}
