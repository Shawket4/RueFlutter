import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/haptics.dart';

class AppToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const AppToggle({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return GestureDetector(
      onTap: () {
        Haptics.selection();
        onChanged(!value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: 46,
        height: 26,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: value ? t.accent : t.border,
        ),
        alignment: value
            ? AlignmentDirectional.centerEnd
            : AlignmentDirectional.centerStart,
        child: Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: t.surface,
            boxShadow: [
              BoxShadow(
                color: t.shadow,
                blurRadius: 4,
                offset: const Offset(0, 1),
              )
            ],
          ),
        ),
      ),
    );
  }
}
