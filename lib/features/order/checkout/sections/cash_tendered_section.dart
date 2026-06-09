import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatting.dart';
import '../../widgets/shared_widgets.dart';

class CashTenderedSection extends StatelessWidget {
  final TextEditingController tenderedCtrl;
  final int cartTotal;
  final VoidCallback onChanged;
  final int? cashTip;

  const CashTenderedSection({
    super.key,
    required this.tenderedCtrl,
    required this.cartTotal,
    required this.onChanged,
    this.cashTip,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FieldLabel('CASH TENDERED'),
          const SizedBox(height: 8),
          TextField(
            controller: tenderedCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => onChanged(),
            style: cairo(fontSize: 22, fontWeight: FontWeight.w700),
            decoration: InputDecoration(
              prefixText: 'EGP  ',
              prefixStyle: cairo(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500),
              hintText: '0',
              hintStyle: cairo(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.border),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              isDense: true,
            ),
          ),
          Builder(builder: (_) {
            final tendered = double.tryParse(tenderedCtrl.text);
            if (tendered == null || tendered == 0) {
              return const SizedBox.shrink();
            }
            final tenderedP = (tendered * 100).round();
            final change = tenderedP - cartTotal - (cashTip ?? 0);
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: change >= 0
                    ? AppColors.success.withOpacity(0.07)
                    : AppColors.danger.withOpacity(0.07),
                borderRadius: BorderRadius.circular(AppRadius.xs),
                border: Border.all(
                    color: change >= 0
                        ? AppColors.success.withOpacity(0.25)
                        : AppColors.danger.withOpacity(0.25)),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(change >= 0 ? 'Change due:' : 'Insufficient:',
                        style: cairo(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: change >= 0
                                ? AppColors.success
                                : AppColors.danger)),
                    Text(egp(change.abs()),
                        style: cairo(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: change >= 0
                                ? AppColors.success
                                : AppColors.danger)),
                  ]),
            );
          }),
        ],
      );
}
