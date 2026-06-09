import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class TopBar extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final VoidCallback? onRefresh;
  final Widget? trailing;

  const TopBar({
    super.key,
    required this.title,
    required this.onBack,
    this.onRefresh,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16, top + 10, 16, 12),
      child: Row(children: [
        _IconBtn(icon: Icons.arrow_back_rounded, onTap: onBack),
        const SizedBox(width: 14),
        Text(title, style: cairo(fontSize: 18, fontWeight: FontWeight.w700)),
        const Spacer(),
        if (trailing != null) trailing!,
        if (trailing == null && onRefresh != null)
          _IconBtn(icon: Icons.refresh_rounded, onTap: onRefresh!),
      ]),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.bg,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(color: AppColors.border),
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 18, color: AppColors.textPrimary),
        ),
      );
}
