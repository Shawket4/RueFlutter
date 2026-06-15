import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/entrance_focus.dart';

/// EGP amount input: large tabular numerals, decimal-only filtering, currency
/// affix on the correct side for RTL.
///
/// [autofocus] is honoured AFTER the entrance transition settles (see
/// [EntranceFocus]) rather than mid-animation — `autofocus: true` mid-route
/// wedges text input on iPad.
class AmountField extends StatefulWidget {
  final TextEditingController controller;
  final String? hint;
  final String? label;
  final bool enabled;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;

  const AmountField({
    super.key,
    required this.controller,
    this.hint,
    this.label,
    this.enabled = true,
    this.autofocus = false,
    this.onChanged,
    this.focusNode,
  });

  /// Parses the field into piastres (int), or null when empty/invalid.
  static int? parsePiastres(String text) {
    final v = double.tryParse(text.trim());
    if (v == null) return null;
    return (v * 100).round();
  }

  @override
  State<AmountField> createState() => _AmountFieldState();
}

class _AmountFieldState extends State<AmountField>
    with EntranceFocus<AmountField> {
  FocusNode? _ownNode;
  FocusNode get _node => widget.focusNode ?? (_ownNode ??= FocusNode());

  @override
  void initState() {
    super.initState();
    if (widget.autofocus) focusAfterEntrance(_node);
  }

  @override
  void dispose() {
    _ownNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return TextField(
      controller: widget.controller,
      focusNode: _node,
      enabled: widget.enabled,
      // Focus is driven by focusAfterEntrance, never autofocus here.
      onChanged: widget.onChanged,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
      ],
      style: money(size: 22, color: t.textPrimary),
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint ?? '0.00',
        prefixIcon: Padding(
          padding: const EdgeInsetsDirectional.only(start: 14, end: 8, top: 14),
          child: Text('EGP',
              style: ui(size: 13, weight: FontWeight.w700, color: t.textMuted)),
        ),
        prefixIconConstraints:
            const BoxConstraints(minWidth: 0, minHeight: 0),
      ),
    );
  }
}
