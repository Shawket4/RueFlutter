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

  @override
  String get commonSave => 'حفظ';

  @override
  String get commonDelete => 'حذف';

  @override
  String get commonRemove => 'إزالة';

  @override
  String get commonEdit => 'تعديل';

  @override
  String get commonClear => 'مسح';

  @override
  String get commonCopyAll => 'نسخ الكل';

  @override
  String get commonContinue => 'متابعة';

  @override
  String get commonLoading => 'جارٍ التحميل…';

  @override
  String get commonRefresh => 'تحديث';

  @override
  String get commonUndo => 'تراجع';

  @override
  String get commonOffline => 'غير متصل';

  @override
  String get commonSomethingWentWrong => 'حدث خطأ ما';

  @override
  String get commonNoDataAvailable => 'لا توجد بيانات';

  @override
  String get commonSignOut => 'تسجيل الخروج';

  @override
  String get commonPrint => 'طباعة';

  @override
  String get commonPrintReport => 'طباعة التقرير';

  @override
  String get commonRetryPrint => 'إعادة الطباعة';

  @override
  String get commonNoPrinterForBranch => 'لا توجد طابعة مهيأة لهذا الفرع';

  @override
  String commonFailedLoadReport(Object error) {
    return 'تعذر تحميل التقرير: $error';
  }

  @override
  String get commonVoided => 'ملغي';

  @override
  String get commonPendingSync => 'بانتظار المزامنة';

  @override
  String get commonTeller => 'الكاشير';

  @override
  String commonOrdersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count طلب',
      many: '$count طلبًا',
      few: '$count طلبات',
      two: 'طلبان',
      one: 'طلب واحد',
      zero: 'لا طلبات',
    );
    return '$_temp0';
  }

  @override
  String commonItemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count صنف',
      many: '$count صنفًا',
      few: '$count أصناف',
      two: 'صنفان',
      one: 'صنف واحد',
      zero: 'لا أصناف',
    );
    return '$_temp0';
  }

  @override
  String commonCopyright(Object year) {
    return '© $year Sufrix';
  }

  @override
  String get commonCashOfflineHint =>
      'يتطلب اتصالاً — لا يمكن وضع المبالغ النقدية في قائمة الانتظار بأمان';

  @override
  String get commonRequiresConnection => 'يتطلب اتصالاً بالإنترنت';

  @override
  String get loginWelcome => 'أهلاً بك';

  @override
  String get loginWelcomeBack => 'أهلاً\nبعودتك.';

  @override
  String get loginSubtitle => 'سجّل الدخول لبدء ورديتك وإدارة الطلبات.';

  @override
  String get loginBrandTagline => 'سجّل الدخول لبدء ورديتك\nوإدارة الطلبات.';

  @override
  String get loginSessionExpiredBanner =>
      'انتهت جلستك — يرجى تسجيل الدخول مرة أخرى.';

  @override
  String loginBlockedBanner(Object name) {
    return 'يوجد وردية مفتوحة في الفرع باسم \"$name\". يجب إغلاقها أولاً قبل أن تتمكن من تسجيل الدخول.';
  }

  @override
  String get loginOfflineBanner =>
      'أنت غير متصل بالإنترنت. لا يزال بإمكانك تسجيل الدخول دون اتصال — ستُحفظ المبيعات على هذا الجهاز حتى تسجّل الدخول وأنت متصل.';

  @override
  String get loginNameHint => 'اسمك';

  @override
  String get loginSignIn => 'تسجيل الدخول';

  @override
  String get loginSignInOffline => 'تسجيل الدخول دون اتصال';

  @override
  String get loginAutoSubmitHint =>
      'إدخال الأرقام الستة كاملة يسجّل دخولك تلقائيًا.';

  @override
  String get loginOfflineExplain =>
      'تسجيل الدخول دون اتصال يستخدم الحساب المحفوظ على هذا الجهاز. ستبقى المبيعات في قائمة الانتظار حتى تسجّل الدخول وأنت متصل.';

  @override
  String get loginErrorEnterName => 'من فضلك أدخل اسمك';

  @override
  String get loginErrorEnterPin => 'أدخل رقمك السري المكوّن من 6 أرقام';

  @override
  String shellGreetingMorning(Object name) {
    return 'صباح الخير يا $name';
  }

  @override
  String shellGreetingAfternoon(Object name) {
    return 'طاب يومك يا $name';
  }

  @override
  String shellGreetingEvening(Object name) {
    return 'مساء الخير يا $name';
  }

  @override
  String get shellPastOrders => 'الطلبات السابقة';

  @override
  String get shellSync => 'مزامنة';

  @override
  String get shellCashInOut => 'إيداع / سحب نقدي';

  @override
  String get shellPastShifts => 'الورديات السابقة';

  @override
  String get shellMore => 'المزيد';

  @override
  String get shellSearchMenu => 'ابحث في القائمة…';

  @override
  String get shellRefreshMenu => 'تحديث القائمة';

  @override
  String get shellShiftActions => 'إجراءات الوردية';

  @override
  String get shellDefaultOrderName => 'طلب 1';

  @override
  String get shellBrowse => 'تصفح';

  @override
  String get shellCashAndShift => 'النقدية والوردية';

  @override
  String shellShiftOpenedAt(Object time, Object cash) {
    return 'فُتحت $time · افتتاحي $cash';
  }

  @override
  String shellShiftOpenedOffline(Object time) {
    return 'فُتحت $time · وضع عدم الاتصال';
  }

  @override
  String get shiftNoOpenShift => 'لا توجد وردية مفتوحة';

  @override
  String get shiftOpenPrompt => 'افتح وردية لبدء استقبال الطلبات.';

  @override
  String get shiftStatusOpen => 'مفتوحة';

  @override
  String get shiftStatusClosed => 'مغلقة';

  @override
  String get shiftStatusForceClosed => 'أُغلقت إجباريًا';

  @override
  String get shiftSuggestedOpeningCash => 'النقد الافتتاحي المقترح';

  @override
  String get shiftCarriedOver => 'مُرحّل من آخر إغلاق';

  @override
  String get shiftCloseFirstTitle => 'أغلق الوردية أولاً';

  @override
  String get shiftCloseFirstBody =>
      'لديك وردية مفتوحة. يجب إغلاقها قبل تسجيل الخروج.';

  @override
  String get shiftOpenSubtitle => 'ابدأ جلسة بيع جديدة';

  @override
  String get shiftOpenCardTitle => 'فتح وردية جديدة';

  @override
  String get shiftOpenCardBody => 'عُدّ النقدية في الدرج قبل البدء.';

  @override
  String get shiftSuggestedFromLastClose => 'مقترح — مُرحّل من آخر إغلاق';

  @override
  String get shiftErrorValidCash => 'أدخل مبلغًا نقديًا صالحًا';

  @override
  String get shiftErrorNoBranch => 'لا يوجد فرع مرتبط بحسابك';

  @override
  String shiftOpenConfirmBody(Object amount) {
    return 'فتح الوردية وفي الدرج $amount؟';
  }

  @override
  String get shiftOpenOfflineNote =>
      'أنت غير متصل — ستُفتح الوردية على هذا الجهاز وستتم مزامنتها عند عودة الاتصال.';

  @override
  String get shiftOpenFailed => 'تعذر فتح الوردية';

  @override
  String get shiftOpenedOfflineFooter =>
      'غير متصل — تُفتح الوردية على هذا الجهاز وتُزامن لاحقًا.';

  @override
  String get shiftCloseConfirmTitle => 'إغلاق الوردية؟';

  @override
  String get shiftCloseConfirmBodyOnline =>
      'ستقوم بجرد النقدية والمخزون في الشاشة التالية.';

  @override
  String get shiftCloseConfirmBodyOffline =>
      'أنت غير متصل — سيُحفظ الإغلاق على هذا الجهاز ويُزامن عند عودة الاتصال. ستقوم بجرد النقدية والمخزون في الشاشة التالية.';

  @override
  String get shiftCloseWillSync => 'إغلاق الوردية (ستتم المزامنة)';

  @override
  String get shiftCloseQueueConfirm => 'إغلاق (ستتم المزامنة)';

  @override
  String get shiftErrorValidClosingCash => 'أدخل مبلغ النقد الختامي صحيحًا';

  @override
  String get shiftZeroStockTitle => 'تحذير: مخزون صفري';

  @override
  String shiftZeroStockBody(Object items) {
    return 'هذه الأصناف مسجلة بعدد 0:\n\n$items\n\nهل أنت متأكد من الإرسال؟';
  }

  @override
  String get shiftSubmitAnyway => 'إرسال على أي حال';

  @override
  String get shiftCloseFailed => 'تعذر إغلاق الوردية';

  @override
  String get shiftNothingToClose => 'لا يوجد ما يمكن إغلاقه الآن.';

  @override
  String get shiftSummary => 'ملخص الوردية';

  @override
  String get shiftOpenedAtLabel => 'وقت الفتح';

  @override
  String get shiftCashCount => 'جرد النقدية';

  @override
  String get shiftSystemCash => 'نقدية النظام';

  @override
  String get shiftSystemCashExplain => 'الافتتاحي + الطلبات النقدية + الحركات';

  @override
  String get shiftActualCash => 'النقدية الفعلية في الدرج';

  @override
  String get shiftCashNoteOptional => 'ملاحظة على النقدية (اختياري)';

  @override
  String get shiftInventoryCount => 'جرد المخزون';

  @override
  String get shiftUseSystemCounts => 'استخدام أرقام النظام';

  @override
  String get shiftNoInventory => 'لا توجد أصناف مخزون';

  @override
  String shiftSystemStock(Object stock, Object unit) {
    return 'النظام: $stock $unit';
  }

  @override
  String get shiftZeroConfirmHint => 'القيمة 0 — تأكد أن ذلك صحيح';

  @override
  String get shiftCloseOfflineNote =>
      'أنت غير متصل — ستُغلق الوردية على هذا الجهاز الآن وتُزامن تلقائيًا';

  @override
  String get shiftDrawerMatches => 'الدرج مطابق';

  @override
  String shiftDrawerOver(Object amount) {
    return 'الدرج زائد بمقدار $amount';
  }

  @override
  String shiftDrawerShort(Object amount) {
    return 'الدرج ناقص بمقدار $amount';
  }

  @override
  String shiftSystemAmount(Object amount) {
    return 'النظام: $amount';
  }

  @override
  String get shiftHistoryTitle => 'الورديات';

  @override
  String get shiftHistorySubtitle => 'الورديات السابقة لهذا الفرع';

  @override
  String get shiftErrorNoBranchAssigned => 'لا يوجد فرع مرتبط';

  @override
  String get shiftNoShiftsYet => 'لا توجد ورديات بعد';

  @override
  String get shiftShiftsAppearHere => 'ستظهر هنا الورديات المفتوحة والمغلقة.';

  @override
  String get shiftColOpened => 'الفتح';

  @override
  String get shiftColClosed => 'الإغلاق';

  @override
  String get shiftDeclaredCash => 'النقد المُعلن';

  @override
  String shiftOpeningChip(Object amount) {
    return 'افتتاحي $amount';
  }

  @override
  String get shiftOrdersInShift => 'طلبات هذه الوردية';

  @override
  String get shiftNoOrdersInShift => 'لا توجد طلبات في هذه الوردية';

  @override
  String shiftOpenedOn(Object date) {
    return 'فُتحت $date';
  }

  @override
  String get shiftReportTitle => 'تقرير الوردية';

  @override
  String get shiftReportOpenChip => 'وردية مفتوحة';

  @override
  String get shiftReportDetails => 'تفاصيل الوردية';

  @override
  String get shiftExpectedCash => 'النقد المتوقع';

  @override
  String get shiftPaymentBreakdown => 'تفصيل المدفوعات';

  @override
  String get shiftNoPayments => 'لا توجد مدفوعات مسجلة';

  @override
  String get shiftTotalPayments => 'إجمالي المدفوعات';

  @override
  String get shiftVoidedOrders => 'الطلبات الملغاة';

  @override
  String get shiftNetPayments => 'صافي المدفوعات';

  @override
  String get shiftCashMovementsHeader => 'حركات النقدية';

  @override
  String get shiftNoCashMovements => 'لا توجد حركات نقدية';

  @override
  String get shiftPayIn => 'إجمالي الإيداعات';

  @override
  String get shiftPayOut => 'إجمالي السحوبات';

  @override
  String shiftReportGenerated(Object time) {
    return 'أُنشئ التقرير $time';
  }

  @override
  String get shiftReportPrinted => 'تمت طباعة التقرير';

  @override
  String get shiftCashMovement => 'حركة نقدية';

  @override
  String get shiftErrorValidAmount => 'أدخل مبلغًا صالحًا';

  @override
  String get shiftErrorNoteRequired => 'الملاحظة مطلوبة';

  @override
  String get shiftCashOfflineBanner =>
      'أنت غير متصل. يتطلب اتصالاً — لا يمكن وضع المبالغ النقدية في قائمة الانتظار بأمان.';

  @override
  String get shiftAmount => 'المبلغ';

  @override
  String get shiftNoteRequired => 'ملاحظة (مطلوبة)';

  @override
  String get shiftNoteHint => 'مثال: إيداع في الخزنة، تعزيز الدرج…';

  @override
  String get shiftRecordCashIn => 'تسجيل إيداع نقدي';

  @override
  String get shiftRecordCashOut => 'تسجيل سحب نقدي';

  @override
  String shiftCashInRecorded(Object amount) {
    return 'تم تسجيل إيداع نقدي — $amount';
  }

  @override
  String shiftCashOutRecorded(Object amount) {
    return 'تم تسجيل سحب نقدي — $amount';
  }

  @override
  String get orderCartTitle => 'الطلب';

  @override
  String get orderTapToAdd => 'اضغط على أي صنف لإضافته.';

  @override
  String orderHeldOrders(int count) {
    return 'طلبات معلّقة ($count)';
  }

  @override
  String get orderAddItemsBeforeHold => 'أضف أصنافًا قبل تعليق هذا الطلب';

  @override
  String get orderDeleteHeldTitle => 'حذف الطلب المعلّق؟';

  @override
  String orderDeleteHeldBody(Object name) {
    return 'حذف \"$name\"؟ ستُحذف كل أصنافه نهائيًا.';
  }

  @override
  String get orderDeleteActiveTitle => 'حذف الطلب الحالي؟';

  @override
  String get orderDeleteActiveBody =>
      'حذف تبويب الطلب الحالي؟ ستُحذف كل أصنافه نهائيًا.';

  @override
  String get orderDeleteTab => 'حذف التبويب';

  @override
  String get orderRenameOrder => 'إعادة تسمية الطلب';

  @override
  String get orderRenameHeldOrder => 'إعادة تسمية الطلب المعلّق';

  @override
  String get orderRenameHint => 'سمِّ هذا الطلب ليسهل العثور عليه لاحقًا.';

  @override
  String get orderRenamePlaceholder => 'مثال: طاولة 5، سارة، تيك أواي';

  @override
  String get orderRemoveItemTitle => 'إزالة الصنف؟';

  @override
  String orderRemoveItemBody(Object name) {
    return 'إزالة \"$name\" من السلة؟';
  }

  @override
  String orderItemRemoved(Object name) {
    return 'تمت إزالة $name';
  }

  @override
  String get orderRemoveComboTitle => 'إزالة الكومبو؟';

  @override
  String orderRemoveComboBody(Object name) {
    return 'سيُزال الكومبو \"$name\" بالكامل.';
  }

  @override
  String get orderNoItemsCategory => 'لا توجد أصناف في هذا التصنيف';

  @override
  String get orderPickAnotherCategory => 'اختر تصنيفًا آخر أو حدّث القائمة.';

  @override
  String orderNoResultsFor(Object query) {
    return 'لا توجد نتائج لـ \"$query\"';
  }

  @override
  String get orderTryShorterName => 'جرّب اسمًا أقصر أو تحقق من الإملاء.';

  @override
  String get orderCombos => 'كومبو';

  @override
  String get orderCombo => 'كومبو';

  @override
  String orderComboSave(Object amount) {
    return 'وفر $amount';
  }

  @override
  String orderItemOutOfStock(Object name) {
    return '$name غير متوفر';
  }

  @override
  String get orderOutOfStock => 'غير متوفر';

  @override
  String get orderSizeHeader => 'الحجم';

  @override
  String get orderRecipe => 'الوصفة';

  @override
  String get orderRecipeRetry => 'الوصفة · إعادة المحاولة';

  @override
  String get orderUpdateItem => 'تحديث الصنف';

  @override
  String get orderAddToCart => 'إضافة إلى السلة';

  @override
  String orderSelectOptions(Object name) {
    return 'اختر $name';
  }

  @override
  String get orderRequiredOptions => 'الخيارات المطلوبة';

  @override
  String get orderOptionalHeader => 'إضافات اختيارية';

  @override
  String get orderRequiredChip => 'مطلوب';

  @override
  String orderMaxSelections(int max) {
    return 'حد أقصى $max';
  }

  @override
  String orderMaxHint(int max, Object title) {
    return 'الحد الأقصى $max اختيارات لـ $title';
  }

  @override
  String get orderSearchOptions => 'ابحث في الخيارات…';

  @override
  String orderNoMatchFor(Object query) {
    return 'لا توجد نتائج لـ \"$query\"';
  }

  @override
  String orderRecipeSizeLabel(Object size) {
    return 'الحجم: $size';
  }

  @override
  String get orderRecipeLoadError =>
      'تعذر تحميل الوصفة. تحقق من الاتصال وحاول مرة أخرى.';

  @override
  String get orderNoIngredients => 'لا توجد مكونات مسجلة';

  @override
  String get orderNoRecipeYet => 'لا توجد وصفة لهذا الصنف بعد.';

  @override
  String orderConfiguredProgress(int done, int total) {
    return 'تم تجهيز $done من $total';
  }

  @override
  String get orderReady => 'جاهز';

  @override
  String get orderDefaultOptions => 'الخيارات الافتراضية';

  @override
  String get orderConfigure => 'تجهيز';

  @override
  String orderConfigureItem(Object name) {
    return 'تجهيز $name';
  }

  @override
  String get orderConfigureItems => 'تجهيز الأصناف';

  @override
  String get orderItemUnavailable => 'الصنف غير متاح';

  @override
  String get orderItemFallback => 'صنف';

  @override
  String get orderTapToChooseOptions => 'اضغط لاختيار الخيارات';

  @override
  String get orderNoOptionsToConfigure => 'لا توجد خيارات للتجهيز';

  @override
  String get orderHistoryTitle => 'الطلبات';

  @override
  String get orderCurrentShift => 'الوردية الحالية';

  @override
  String get orderFilterAll => 'الكل';

  @override
  String get orderFilterSynced => 'مُزامن';

  @override
  String get orderNoOrdersYet => 'لا توجد طلبات بعد';

  @override
  String get orderOrdersAppearHere =>
      'ستظهر هنا الطلبات المكتملة خلال هذه الوردية.';

  @override
  String get orderOpenShiftToSell =>
      'افتح وردية لبدء البيع — ستظهر طلباتها هنا.';

  @override
  String get orderNothingHere => 'لا يوجد شيء هنا';

  @override
  String orderNoFilterMatch(Object filter) {
    return 'لا توجد طلبات تطابق فلتر \"$filter\".';
  }

  @override
  String get orderStatOrders => 'الطلبات';

  @override
  String get orderMixed => 'مختلط';

  @override
  String get orderColTime => 'الوقت';

  @override
  String get orderColAmount => 'المبلغ';

  @override
  String get orderNoItemDetails => 'لا توجد تفاصيل للأصناف';

  @override
  String get orderTax14 => 'ضريبة (14%)';

  @override
  String get orderVoid => 'إلغاء الطلب';

  @override
  String get orderIngredients => 'المكونات';

  @override
  String get orderIngredientUse => 'استهلاك المكونات';

  @override
  String get orderNoDeductions => 'لا توجد خصومات مخزون مسجلة';

  @override
  String get orderNoDeductionsBody => 'لا توجد خصومات مكونات لهذا البند.';

  @override
  String get orderSourceBase => 'أساسي';

  @override
  String get orderSourceComboItem => 'صنف كومبو';

  @override
  String get orderSourceAddon => 'إضافة';

  @override
  String orderVoidTitle(int number) {
    return 'إلغاء الطلب رقم $number';
  }

  @override
  String get orderVoidCannotUndo => 'لا يمكن التراجع عن هذا الإجراء';

  @override
  String get orderVoidOfflineQueued =>
      'غير متصل — سيُحفظ الإلغاء ويُطبّق عند عودة الاتصال';

  @override
  String get orderVoidReasonHeader => 'السبب';

  @override
  String get orderVoidReasonCustomerRequest => 'طلب العميل';

  @override
  String get orderVoidReasonWrongOrder => 'طلب خاطئ';

  @override
  String get orderVoidReasonQualityIssue => 'مشكلة في الجودة';

  @override
  String get orderVoidReasonOther => 'سبب آخر';

  @override
  String get orderVoidSelectReason => 'من فضلك اختر سببًا';

  @override
  String get orderVoidSpecifyReason => 'من فضلك حدد السبب الآخر';

  @override
  String get orderVoidDescribeHint => 'اشرح السبب…';

  @override
  String orderVoidConfirmTitle(int number) {
    return 'إلغاء الطلب رقم $number؟';
  }

  @override
  String get orderVoidConfirmBodyOnline =>
      'سيُلغى الطلب نهائيًا ولا يمكن التراجع عن ذلك.';

  @override
  String get orderVoidConfirmBodyOffline =>
      'أنت غير متصل — سيُحفظ الإلغاء ويُطبّق عند عودة الاتصال.';

  @override
  String get orderVoidConfirmAction => 'إلغاء الطلب';

  @override
  String get orderVoidRestoreTitle => 'إرجاع الأصناف إلى المخزون';

  @override
  String get orderVoidRestoreBody => 'تعود المكونات إلى المخزون';

  @override
  String get orderVoidAction => 'إلغاء الطلب';

  @override
  String get orderQueueVoid => 'حفظ الإلغاء للمزامنة';

  @override
  String get orderPlaced => 'تم تأكيد الطلب!';

  @override
  String get orderQueuedSyncs => 'في قائمة الانتظار — سيُزامن تلقائيًا';

  @override
  String orderNumber(int number) {
    return 'طلب رقم $number';
  }

  @override
  String get orderReceiptTip => 'إكرامية';

  @override
  String get orderReceiptCustomer => 'العميل';

  @override
  String get orderReceiptTime => 'الوقت';

  @override
  String get orderChangeGiven => 'الباقي المُسلّم';

  @override
  String get orderNewOrder => 'طلب جديد';

  @override
  String get orderPrintingReceipt => 'جارٍ طباعة الإيصال…';

  @override
  String get orderReceiptFailed => 'لم تتم طباعة الإيصال';

  @override
  String get orderReceiptPrinted => 'تمت طباعة الإيصال';

  @override
  String get orderReprint => 'إعادة الطباعة';

  @override
  String get orderReceiptPreview => 'معاينة الإيصال';

  @override
  String get orderDraftReceiptPreview => 'معاينة إيصال مبدئي';

  @override
  String get orderReceiptPrintedOk => 'تمت طباعة الإيصال بنجاح';

  @override
  String get checkoutDiscountOptional => 'الخصم (اختياري)';

  @override
  String get checkoutCustomerOptional => 'اسم العميل (اختياري)';

  @override
  String get checkoutNameHint => 'مثال: أحمد';

  @override
  String get checkoutPaymentHeader => 'طريقة الدفع';

  @override
  String get checkoutSplitPayment => 'دفع مقسّم';

  @override
  String get checkoutLoadingMethods => 'جارٍ تحميل طرق الدفع…';

  @override
  String get checkoutNoMethodsConfigured =>
      'لا توجد طرق دفع مهيأة لهذه المنشأة. أضفها من لوحة التحكم ثم حاول مرة أخرى.';

  @override
  String get checkoutMethodsLoadFailed => 'تعذر تحميل طرق الدفع';

  @override
  String get checkoutMethodsNeeded =>
      'الطلبات تحتاج طريقة دفع — تحقق من الاتصال وأعد المحاولة.';

  @override
  String get checkoutPreview => 'معاينة';

  @override
  String get checkoutSelectMethod => 'اختر طريقة دفع';

  @override
  String get checkoutNoDiscount => 'بدون';

  @override
  String get checkoutTipOptional => 'إكرامية (اختياري)';

  @override
  String get checkoutTipAmount => 'مبلغ الإكرامية';

  @override
  String get checkoutCashTendered => 'المبلغ المستلم';

  @override
  String get checkoutExact => 'بالظبط';

  @override
  String get checkoutChangeDue => 'الباقي للعميل';

  @override
  String get checkoutShortBy => 'ناقص';

  @override
  String get checkoutSelectSplitMethods => 'اختر الطرق التي سيدفع بها العميل.';

  @override
  String checkoutRemaining(Object amount) {
    return 'متبقي $amount';
  }

  @override
  String checkoutOver(Object amount) {
    return 'زيادة $amount';
  }

  @override
  String get checkoutBalanced => 'المبلغ مظبوط';

  @override
  String get syncCenterTitle => 'مركز المزامنة';

  @override
  String get syncPausedSubtitle => 'متوقفة — سجّل الدخول للمتابعة';

  @override
  String syncOfflineQueued(int count) {
    return 'غير متصل — $count في الانتظار';
  }

  @override
  String get syncSyncing => 'جارٍ المزامنة…';

  @override
  String syncNeedAttention(int count) {
    return '$count بحاجة لمراجعة';
  }

  @override
  String syncWaitingCount(int count) {
    return '$count في انتظار المزامنة';
  }

  @override
  String get syncAllSyncedBody =>
      'كل المبيعات والورديات والإلغاءات على هذا الجهاز وصلت إلى الخادم. اسحب للأسفل للتحقق مرة أخرى.';

  @override
  String get syncNeedsAttentionHeader => 'بحاجة لمراجعة';

  @override
  String get syncWaitingHeader => 'في انتظار المزامنة';

  @override
  String get syncPausedTitle => 'انتهت الجلسة — سجّل الدخول لاستئناف المزامنة';

  @override
  String syncPausedBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count عنصر في الانتظار محفوظ بأمان على هذا الجهاز. المزامنة متوقفة حتى تسجّل الدخول مرة أخرى — سينقلك التطبيق إلى شاشة تسجيل الدخول عند الحاجة، وتُستأنف المزامنة تلقائيًا.',
      many:
          '$count عنصرًا في الانتظار محفوظة بأمان على هذا الجهاز. المزامنة متوقفة حتى تسجّل الدخول مرة أخرى — سينقلك التطبيق إلى شاشة تسجيل الدخول عند الحاجة، وتُستأنف المزامنة تلقائيًا.',
      few:
          '$count عناصر في الانتظار محفوظة بأمان على هذا الجهاز. المزامنة متوقفة حتى تسجّل الدخول مرة أخرى — سينقلك التطبيق إلى شاشة تسجيل الدخول عند الحاجة، وتُستأنف المزامنة تلقائيًا.',
      two:
          'عنصران في الانتظار محفوظان بأمان على هذا الجهاز. المزامنة متوقفة حتى تسجّل الدخول مرة أخرى — سينقلك التطبيق إلى شاشة تسجيل الدخول عند الحاجة، وتُستأنف المزامنة تلقائيًا.',
      one:
          'عنصر واحد في الانتظار محفوظ بأمان على هذا الجهاز. المزامنة متوقفة حتى تسجّل الدخول مرة أخرى — سينقلك التطبيق إلى شاشة تسجيل الدخول عند الحاجة، وتُستأنف المزامنة تلقائيًا.',
    );
    return '$_temp0';
  }

  @override
  String syncOfflineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count عنصر في الانتظار. كل شيء يعمل كالمعتاد وسيُزامن تلقائيًا عند عودة الاتصال.',
      many:
          '$count عنصرًا في الانتظار. كل شيء يعمل كالمعتاد وسيُزامن تلقائيًا عند عودة الاتصال.',
      few:
          '$count عناصر في الانتظار. كل شيء يعمل كالمعتاد وسيُزامن تلقائيًا عند عودة الاتصال.',
      two:
          'عنصران في الانتظار. كل شيء يعمل كالمعتاد وسيُزامن تلقائيًا عند عودة الاتصال.',
      one:
          'عنصر واحد في الانتظار. كل شيء يعمل كالمعتاد وسيُزامن تلقائيًا عند عودة الاتصال.',
    );
    return '$_temp0';
  }

  @override
  String syncSyncingBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count عنصر متبقٍ.',
      many: '$count عنصرًا متبقيًا.',
      few: '$count عناصر متبقية.',
      two: 'عنصران متبقيان.',
      one: 'عنصر واحد متبقٍ.',
    );
    return '$_temp0';
  }

  @override
  String syncStuckTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count عنصر بحاجة لمراجعة',
      many: '$count عنصرًا بحاجة لمراجعة',
      few: '$count عناصر بحاجة لمراجعة',
      two: 'عنصران بحاجة لمراجعة',
      one: 'عنصر واحد بحاجة لمراجعة',
    );
    return '$_temp0';
  }

  @override
  String get syncStuckBody =>
      'توقفت هذه العناصر عن المزامنة بعد محاولات فاشلة متكررة. أعد المحاولة أو تجاهلها أدناه.';

  @override
  String get syncWaitingTitle => 'في انتظار المزامنة';

  @override
  String syncWaitingBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'سيُزامن $count عنصر قريبًا.',
      many: 'سيُزامن $count عنصرًا قريبًا.',
      few: 'ستُزامن $count عناصر قريبًا.',
      two: 'سيُزامن عنصران قريبًا.',
      one: 'سيُزامن عنصر واحد قريبًا.',
    );
    return '$_temp0';
  }

  @override
  String syncShiftOpenChip(int count) {
    return '$count فتح وردية';
  }

  @override
  String syncShiftCloseChip(int count) {
    return '$count إغلاق وردية';
  }

  @override
  String syncVoidsChip(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count إلغاء',
      many: '$count إلغاءً',
      few: '$count إلغاءات',
      two: 'إلغاءان',
      one: 'إلغاء واحد',
    );
    return '$_temp0';
  }

  @override
  String syncCashChip(int count) {
    return '$count حركة نقدية';
  }

  @override
  String syncStuckChip(int count) {
    return '$count متعثر';
  }

  @override
  String get syncFromAnotherSession => 'من جلسة أخرى';

  @override
  String syncOtherSessionBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count عنصر — يُزامن عندما يسجّل ذلك المستخدم دخوله على هذا الجهاز',
      many:
          '$count عنصرًا — تُزامن عندما يسجّل ذلك المستخدم دخوله على هذا الجهاز',
      few:
          '$count عناصر — تُزامن عندما يسجّل ذلك المستخدم دخوله على هذا الجهاز',
      two: 'عنصران — يُزامنان عندما يسجّل ذلك المستخدم دخوله على هذا الجهاز',
      one: 'عنصر واحد — يُزامن عندما يسجّل ذلك المستخدم دخوله على هذا الجهاز',
    );
    return '$_temp0';
  }

  @override
  String get syncSyncingChip => 'جارٍ المزامنة';

  @override
  String get syncWalkIn => 'عميل مباشر';

  @override
  String syncOpeningCashDetail(Object amount) {
    return 'نقد افتتاحي $amount';
  }

  @override
  String syncClosingCashDetail(Object amount) {
    return 'نقد ختامي $amount';
  }

  @override
  String syncReason(Object reason) {
    return 'السبب: $reason';
  }

  @override
  String syncWaitingFor(Object label) {
    return 'في انتظار: $label';
  }

  @override
  String get syncAfterAllOrders => 'يُزامن بعد كل الطلبات';

  @override
  String syncFailedAttempts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count محاولة فاشلة — ستُعاد المحاولة تلقائيًا',
      many: '$count محاولة فاشلة — ستُعاد المحاولة تلقائيًا',
      few: '$count محاولات فاشلة — ستُعاد المحاولة تلقائيًا',
      two: 'محاولتان فاشلتان — ستُعاد المحاولة تلقائيًا',
      one: 'محاولة فاشلة واحدة — ستُعاد المحاولة تلقائيًا',
    );
    return '$_temp0';
  }

  @override
  String get syncStoppedAfterFailures => 'توقف بعد محاولات فاشلة متكررة';

  @override
  String syncDiscardConfirmTitle(Object label) {
    return 'تجاهل $label؟';
  }

  @override
  String get syncDiscardConfirmBody =>
      'سيُحذف نهائيًا من قائمة المزامنة ولن يصل إلى الخادم أبدًا.';

  @override
  String get syncTypeOrder => 'طلب';

  @override
  String get syncTypeVoidOrder => 'إلغاء طلب';

  @override
  String get syncTypeCashMovement => 'حركة نقدية';

  @override
  String get syncTypeUnknown => 'غير معروف';

  @override
  String get syncPendingOrder => 'طلب في الانتظار';

  @override
  String get syncJustNow => 'الآن';

  @override
  String syncMinutesAgo(int minutes) {
    return 'منذ $minutes د';
  }

  @override
  String syncHoursAgo(int hours) {
    return 'منذ $hours س';
  }

  @override
  String syncDaysAgo(int days) {
    return 'منذ $days يوم';
  }

  @override
  String syncSignInToSync(int count) {
    return 'سجّل الدخول لمزامنة $count';
  }

  @override
  String syncSyncingCount(int count) {
    return 'جارٍ مزامنة $count…';
  }

  @override
  String get syncOfflineSessionBanner =>
      'جلسة دون اتصال — تُحفظ المبيعات على هذا الجهاز. سجّل الدخول عند الاتصال للمزامنة.';

  @override
  String get syncOfflineBanner =>
      'غير متصل — كل شيء يعمل كالمعتاد ويُزامن عند عودة الاتصال.';

  @override
  String syncSessionExpiredBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'انتهت الجلسة — سجّل الدخول لاستئناف مزامنة $count عنصر في الانتظار.',
      many:
          'انتهت الجلسة — سجّل الدخول لاستئناف مزامنة $count عنصرًا في الانتظار.',
      few:
          'انتهت الجلسة — سجّل الدخول لاستئناف مزامنة $count عناصر في الانتظار.',
      two: 'انتهت الجلسة — سجّل الدخول لاستئناف مزامنة عنصرين في الانتظار.',
      one: 'انتهت الجلسة — سجّل الدخول لاستئناف مزامنة عنصر واحد في الانتظار.',
    );
    return '$_temp0';
  }

  @override
  String get settingsVersionCopied => 'تم نسخ رقم الإصدار';

  @override
  String get settingsSignOutTitle => 'تسجيل الخروج؟';

  @override
  String get settingsSignOutBody =>
      'ستحتاج إلى اسمك ورقمك السري لتسجيل الدخول مرة أخرى.';

  @override
  String get settingsCloseShiftFirstBody =>
      'ورديتك لا تزال مفتوحة. أغلقها وقم بجرد الدرج قبل تسجيل الخروج.';

  @override
  String get settingsGoCloseShift => 'الذهاب لإغلاق الوردية';

  @override
  String get settingsAccount => 'الحساب';

  @override
  String get settingsAppearance => 'المظهر';

  @override
  String get settingsThemeSystem => 'النظام';

  @override
  String get settingsThemeLight => 'فاتح';

  @override
  String get settingsThemeDark => 'داكن';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsDiagnostics => 'التشخيص';

  @override
  String get settingsAbout => 'حول التطبيق';

  @override
  String get settingsWarningsLog => 'سجل التحذيرات';

  @override
  String get settingsNoWarnings => 'لا توجد تحذيرات مسجلة';

  @override
  String settingsEntriesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count سجل',
      many: '$count سجلًا',
      few: '$count سجلات',
      two: 'سجلان',
      one: 'سجل واحد',
    );
    return '$_temp0';
  }

  @override
  String get settingsWarningsBody =>
      'ستظهر هنا تحذيرات التخزين المؤقت والمزامنة عند حدوثها.';

  @override
  String get settingsDiagnosticsCopied => 'تم نسخ بيانات التشخيص';

  @override
  String get setupConnectDevice => 'ربط الجهاز';

  @override
  String get setupConnectSubtitle =>
      'سجّل الدخول بحساب المدير لربط هذا الجهاز بالفرع.';

  @override
  String get setupEmail => 'البريد الإلكتروني';

  @override
  String get setupPassword => 'كلمة المرور';

  @override
  String get setupContinue => 'متابعة';

  @override
  String get setupEnterCredentials => 'أدخل البريد الإلكتروني وكلمة المرور';

  @override
  String get setupSelectBranch => 'اختر الفرع';

  @override
  String get setupSelectBranchSubtitle => 'اختر الفرع الذي سيخدمه هذا الجهاز.';

  @override
  String get setupNoBranches => 'لا توجد فروع نشطة.';

  @override
  String get settingsDeviceSection => 'الجهاز';

  @override
  String get settingsReconfigureDevice => 'إعادة ضبط الجهاز';

  @override
  String get settingsReconfigureShiftOpen =>
      'أغلق الوردية الحالية قبل إعادة ضبط الجهاز.';

  @override
  String get settingsReconfigureTitle => 'إعادة ضبط الجهاز؟';

  @override
  String get settingsReconfigureBody =>
      'سيتم تسجيل خروجك وستحتاج إلى تسجيل دخول المدير لإعادة الاتصال.';

  @override
  String get settingsReconfigureConfirm => 'إعادة الضبط';
}
