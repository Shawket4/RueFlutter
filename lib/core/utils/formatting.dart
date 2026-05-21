import 'package:intl/intl.dart';

String egp(int piastres) {
  final v = piastres / 100;
  return 'EGP ${v == v.truncateToDouble() ? v.toInt() : v.toStringAsFixed(2)}';
}

String egpD(double p) => egp(p.round());
String timeShort(DateTime dt) => DateFormat('hh:mm a').format(dt.toLocal());
String dateShort(DateTime dt) => DateFormat('MMM d').format(dt.toLocal());
String dateTime(DateTime dt)  => DateFormat('MMM d, hh:mm a').format(dt.toLocal());

String normaliseName(String s) => s
    .split(' ')
    .map((w) => w.isEmpty ? '' : w[0].toUpperCase() + w.substring(1).toLowerCase())
    .join(' ');

/// Combo / bundle label strings.
const String kComboLabelEn = 'Combo';
const String kComboLabelAr = 'كومبو';

String comboLabel({bool useArabic = false}) =>
    useArabic ? kComboLabelAr : kComboLabelEn;

String bundleItemCountLabel(int count, {bool useArabic = false}) =>
    useArabic ? '$count أصناف' : '$count items';

String bundleOutOfStockHint(String itemName, {bool useArabic = false}) =>
    useArabic ? '$itemName غير متوفر' : '$itemName is out of stock';

String bundleSaveLabel(int piastres, {bool useArabic = false}) {
  final amount = egp(piastres);
  return useArabic ? 'وفر $amount' : 'Save $amount';
}
