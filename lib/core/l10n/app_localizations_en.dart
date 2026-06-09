// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Sufrix POS';

  @override
  String get loginTitle => 'Sign in to your account';

  @override
  String get loginButton => 'Sign In';

  @override
  String get loginEmailHint => 'Email address';

  @override
  String get loginPasswordHint => 'Password';

  @override
  String get errorSessionExpired => 'Session expired — please sign in again';

  @override
  String get errorNoConnection => 'No internet connection';

  @override
  String get errorGeneric => 'Something went wrong — please try again';

  @override
  String get shiftOpen => 'Open Shift';

  @override
  String get shiftClose => 'Close Shift';

  @override
  String get shiftOpeningCash => 'Opening Cash';

  @override
  String get shiftClosingCash => 'Closing Cash';

  @override
  String get orderCheckout => 'Checkout';

  @override
  String get orderPlaceOrder => 'Place Order';

  @override
  String get orderCartEmpty => 'Cart is empty';

  @override
  String get orderCustomerName => 'Customer Name (optional)';

  @override
  String get orderPaymentMethod => 'Payment';

  @override
  String get orderDiscount => 'Discount';

  @override
  String get orderTotal => 'Total';

  @override
  String get orderSubtotal => 'Subtotal';

  @override
  String get orderTax => 'Tax';

  @override
  String get offlineBannerText => 'Offline — order will sync when reconnected';

  @override
  String get pendingSyncTitle => 'Pending Sync';

  @override
  String get syncNow => 'Sync Now';

  @override
  String get allSynced => 'All synced';

  @override
  String get discardAction => 'Discard';

  @override
  String get retryAction => 'Retry';

  @override
  String get cancelAction => 'Cancel';

  @override
  String get cashIn => 'Cash In';

  @override
  String get cashOut => 'Cash Out';

  @override
  String get cashMovementOfflineError =>
      'Cash movements require an internet connection';

  @override
  String get printReceipt => 'Print Receipt';

  @override
  String get noPrinterConfigured => 'No Printer Configured';

  @override
  String get home => 'Home';

  @override
  String get settings => 'Settings';
}
