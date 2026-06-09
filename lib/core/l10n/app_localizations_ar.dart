// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Sufrix POS';

  @override
  String get loginTitle => 'تسجيل الدخول إلى حسابك';

  @override
  String get loginButton => 'تسجيل الدخول';

  @override
  String get loginEmailHint => 'البريد الإلكتروني';

  @override
  String get loginPasswordHint => 'كلمة المرور';

  @override
  String get errorSessionExpired => 'انتهت الجلسة — يرجى تسجيل الدخول مرة أخرى';

  @override
  String get errorNoConnection => 'لا يوجد اتصال بالإنترنت';

  @override
  String get errorGeneric => 'حدث خطأ — يرجى المحاولة مرة أخرى';

  @override
  String get shiftOpen => 'فتح وردية';

  @override
  String get shiftClose => 'إغلاق الوردية';

  @override
  String get shiftOpeningCash => 'النقد الافتتاحي';

  @override
  String get shiftClosingCash => 'النقد الختامي';

  @override
  String get orderCheckout => 'الدفع';

  @override
  String get orderPlaceOrder => 'تأكيد الطلب';

  @override
  String get orderCartEmpty => 'السلة فارغة';

  @override
  String get orderCustomerName => 'اسم العميل (اختياري)';

  @override
  String get orderPaymentMethod => 'طريقة الدفع';

  @override
  String get orderDiscount => 'خصم';

  @override
  String get orderTotal => 'الإجمالي';

  @override
  String get orderSubtotal => 'المجموع الفرعي';

  @override
  String get orderTax => 'الضريبة';

  @override
  String get offlineBannerText => 'غير متصل — سيتم مزامنة الطلب عند الاتصال';

  @override
  String get pendingSyncTitle => 'في انتظار المزامنة';

  @override
  String get syncNow => 'مزامنة الآن';

  @override
  String get allSynced => 'تمت المزامنة';

  @override
  String get discardAction => 'تجاهل';

  @override
  String get retryAction => 'إعادة المحاولة';

  @override
  String get cancelAction => 'إلغاء';

  @override
  String get cashIn => 'إيداع نقدي';

  @override
  String get cashOut => 'سحب نقدي';

  @override
  String get cashMovementOfflineError => 'حركات النقد تتطلب اتصالاً بالإنترنت';

  @override
  String get printReceipt => 'طباعة الإيصال';

  @override
  String get noPrinterConfigured => 'لم يتم تكوين طابعة';

  @override
  String get home => 'الرئيسية';

  @override
  String get settings => 'الإعدادات';
}
