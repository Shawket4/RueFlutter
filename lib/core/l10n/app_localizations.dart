import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'Sufrix POS'**
  String get appTitle;

  /// Login screen heading
  ///
  /// In en, this message translates to:
  /// **'Sign in to your account'**
  String get loginTitle;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get loginButton;

  /// No description provided for @loginEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get loginEmailHint;

  /// No description provided for @loginPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPasswordHint;

  /// No description provided for @errorSessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Session expired — please sign in again'**
  String get errorSessionExpired;

  /// No description provided for @errorNoConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get errorNoConnection;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong — please try again'**
  String get errorGeneric;

  /// No description provided for @shiftOpen.
  ///
  /// In en, this message translates to:
  /// **'Open Shift'**
  String get shiftOpen;

  /// No description provided for @shiftClose.
  ///
  /// In en, this message translates to:
  /// **'Close Shift'**
  String get shiftClose;

  /// No description provided for @shiftOpeningCash.
  ///
  /// In en, this message translates to:
  /// **'Opening Cash'**
  String get shiftOpeningCash;

  /// No description provided for @shiftClosingCash.
  ///
  /// In en, this message translates to:
  /// **'Closing Cash'**
  String get shiftClosingCash;

  /// No description provided for @orderCheckout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get orderCheckout;

  /// No description provided for @orderPlaceOrder.
  ///
  /// In en, this message translates to:
  /// **'Place Order'**
  String get orderPlaceOrder;

  /// No description provided for @orderCartEmpty.
  ///
  /// In en, this message translates to:
  /// **'Cart is empty'**
  String get orderCartEmpty;

  /// No description provided for @orderCustomerName.
  ///
  /// In en, this message translates to:
  /// **'Customer Name (optional)'**
  String get orderCustomerName;

  /// No description provided for @orderPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get orderPaymentMethod;

  /// No description provided for @orderDiscount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get orderDiscount;

  /// No description provided for @orderTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get orderTotal;

  /// No description provided for @orderSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get orderSubtotal;

  /// No description provided for @orderTax.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get orderTax;

  /// No description provided for @offlineBannerText.
  ///
  /// In en, this message translates to:
  /// **'Offline — order will sync when reconnected'**
  String get offlineBannerText;

  /// No description provided for @pendingSyncTitle.
  ///
  /// In en, this message translates to:
  /// **'Pending Sync'**
  String get pendingSyncTitle;

  /// No description provided for @syncNow.
  ///
  /// In en, this message translates to:
  /// **'Sync Now'**
  String get syncNow;

  /// No description provided for @allSynced.
  ///
  /// In en, this message translates to:
  /// **'All synced'**
  String get allSynced;

  /// No description provided for @discardAction.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discardAction;

  /// No description provided for @retryAction.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryAction;

  /// No description provided for @cancelAction.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelAction;

  /// No description provided for @cashIn.
  ///
  /// In en, this message translates to:
  /// **'Cash In'**
  String get cashIn;

  /// No description provided for @cashOut.
  ///
  /// In en, this message translates to:
  /// **'Cash Out'**
  String get cashOut;

  /// No description provided for @cashMovementOfflineError.
  ///
  /// In en, this message translates to:
  /// **'Cash movements require an internet connection'**
  String get cashMovementOfflineError;

  /// No description provided for @printReceipt.
  ///
  /// In en, this message translates to:
  /// **'Print Receipt'**
  String get printReceipt;

  /// No description provided for @noPrinterConfigured.
  ///
  /// In en, this message translates to:
  /// **'No Printer Configured'**
  String get noPrinterConfigured;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get commonRemove;

  /// No description provided for @commonEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get commonEdit;

  /// No description provided for @commonClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get commonClear;

  /// No description provided for @commonCopyAll.
  ///
  /// In en, this message translates to:
  /// **'Copy all'**
  String get commonCopyAll;

  /// No description provided for @commonContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// No description provided for @commonLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get commonLoading;

  /// No description provided for @commonRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get commonRefresh;

  /// No description provided for @commonUndo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get commonUndo;

  /// No description provided for @commonOffline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get commonOffline;

  /// No description provided for @commonSomethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get commonSomethingWentWrong;

  /// No description provided for @commonNoDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get commonNoDataAvailable;

  /// No description provided for @commonSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get commonSignOut;

  /// No description provided for @commonPrint.
  ///
  /// In en, this message translates to:
  /// **'Print'**
  String get commonPrint;

  /// No description provided for @commonPrintReport.
  ///
  /// In en, this message translates to:
  /// **'Print Report'**
  String get commonPrintReport;

  /// No description provided for @commonRetryPrint.
  ///
  /// In en, this message translates to:
  /// **'Retry Print'**
  String get commonRetryPrint;

  /// No description provided for @commonNoPrinterForBranch.
  ///
  /// In en, this message translates to:
  /// **'No printer configured for this branch'**
  String get commonNoPrinterForBranch;

  /// No description provided for @commonFailedLoadReport.
  ///
  /// In en, this message translates to:
  /// **'Failed to load report: {error}'**
  String commonFailedLoadReport(Object error);

  /// No description provided for @commonVoided.
  ///
  /// In en, this message translates to:
  /// **'Voided'**
  String get commonVoided;

  /// No description provided for @commonPendingSync.
  ///
  /// In en, this message translates to:
  /// **'Pending sync'**
  String get commonPendingSync;

  /// No description provided for @commonTeller.
  ///
  /// In en, this message translates to:
  /// **'Teller'**
  String get commonTeller;

  /// No description provided for @commonOrdersCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 order} other{{count} orders}}'**
  String commonOrdersCount(int count);

  /// No description provided for @commonItemsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 item} other{{count} items}}'**
  String commonItemsCount(int count);

  /// No description provided for @commonCopyright.
  ///
  /// In en, this message translates to:
  /// **'© {year} Sufrix'**
  String commonCopyright(Object year);

  /// No description provided for @commonCashOfflineHint.
  ///
  /// In en, this message translates to:
  /// **'Requires connection — cash amounts can\'t be queued safely'**
  String get commonCashOfflineHint;

  /// No description provided for @commonRequiresConnection.
  ///
  /// In en, this message translates to:
  /// **'Requires connection'**
  String get commonRequiresConnection;

  /// No description provided for @loginWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get loginWelcome;

  /// No description provided for @loginWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome\nback.'**
  String get loginWelcomeBack;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to start your shift and manage orders.'**
  String get loginSubtitle;

  /// No description provided for @loginBrandTagline.
  ///
  /// In en, this message translates to:
  /// **'Sign in to start your shift\nand manage orders.'**
  String get loginBrandTagline;

  /// No description provided for @loginSessionExpiredBanner.
  ///
  /// In en, this message translates to:
  /// **'Your session expired — please sign in again.'**
  String get loginSessionExpiredBanner;

  /// No description provided for @loginBlockedBanner.
  ///
  /// In en, this message translates to:
  /// **'Branch has an open shift belonging to \"{name}\". They must close it before you can sign in.'**
  String loginBlockedBanner(Object name);

  /// No description provided for @loginOfflineBanner.
  ///
  /// In en, this message translates to:
  /// **'You\'re offline. You can still sign in offline — sales will queue on this device until you sign in online.'**
  String get loginOfflineBanner;

  /// No description provided for @loginNameHint.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get loginNameHint;

  /// No description provided for @loginSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get loginSignIn;

  /// No description provided for @loginSignInOffline.
  ///
  /// In en, this message translates to:
  /// **'Sign in offline'**
  String get loginSignInOffline;

  /// No description provided for @loginAutoSubmitHint.
  ///
  /// In en, this message translates to:
  /// **'Entering all 6 digits signs you in automatically.'**
  String get loginAutoSubmitHint;

  /// No description provided for @loginOfflineExplain.
  ///
  /// In en, this message translates to:
  /// **'Offline sign-in uses this device\'s cached account. Sales will queue until you sign in online.'**
  String get loginOfflineExplain;

  /// No description provided for @loginErrorEnterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get loginErrorEnterName;

  /// No description provided for @loginErrorEnterPin.
  ///
  /// In en, this message translates to:
  /// **'Enter your 6-digit PIN'**
  String get loginErrorEnterPin;

  /// No description provided for @shellGreetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning, {name}'**
  String shellGreetingMorning(Object name);

  /// No description provided for @shellGreetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon, {name}'**
  String shellGreetingAfternoon(Object name);

  /// No description provided for @shellGreetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening, {name}'**
  String shellGreetingEvening(Object name);

  /// No description provided for @shellPastOrders.
  ///
  /// In en, this message translates to:
  /// **'Past Orders'**
  String get shellPastOrders;

  /// No description provided for @shellSync.
  ///
  /// In en, this message translates to:
  /// **'Sync'**
  String get shellSync;

  /// No description provided for @shellCashInOut.
  ///
  /// In en, this message translates to:
  /// **'Cash In / Out'**
  String get shellCashInOut;

  /// No description provided for @shellPastShifts.
  ///
  /// In en, this message translates to:
  /// **'Past Shifts'**
  String get shellPastShifts;

  /// No description provided for @shellMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get shellMore;

  /// No description provided for @shellSearchMenu.
  ///
  /// In en, this message translates to:
  /// **'Search menu…'**
  String get shellSearchMenu;

  /// No description provided for @shellRefreshMenu.
  ///
  /// In en, this message translates to:
  /// **'Refresh menu'**
  String get shellRefreshMenu;

  /// No description provided for @shellShiftActions.
  ///
  /// In en, this message translates to:
  /// **'Shift actions'**
  String get shellShiftActions;

  /// No description provided for @shellDefaultOrderName.
  ///
  /// In en, this message translates to:
  /// **'Order 1'**
  String get shellDefaultOrderName;

  /// No description provided for @shellBrowse.
  ///
  /// In en, this message translates to:
  /// **'Browse'**
  String get shellBrowse;

  /// No description provided for @shellCashAndShift.
  ///
  /// In en, this message translates to:
  /// **'Cash & shift'**
  String get shellCashAndShift;

  /// No description provided for @shellShiftOpenedAt.
  ///
  /// In en, this message translates to:
  /// **'Opened {time} · Opening {cash}'**
  String shellShiftOpenedAt(Object time, Object cash);

  /// No description provided for @shellShiftOpenedOffline.
  ///
  /// In en, this message translates to:
  /// **'Opened {time} · Offline mode'**
  String shellShiftOpenedOffline(Object time);

  /// No description provided for @shiftNoOpenShift.
  ///
  /// In en, this message translates to:
  /// **'No open shift'**
  String get shiftNoOpenShift;

  /// No description provided for @shiftOpenPrompt.
  ///
  /// In en, this message translates to:
  /// **'Open a shift to start taking orders.'**
  String get shiftOpenPrompt;

  /// No description provided for @shiftStatusOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get shiftStatusOpen;

  /// No description provided for @shiftStatusClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get shiftStatusClosed;

  /// No description provided for @shiftStatusForceClosed.
  ///
  /// In en, this message translates to:
  /// **'Force closed'**
  String get shiftStatusForceClosed;

  /// No description provided for @shiftSuggestedOpeningCash.
  ///
  /// In en, this message translates to:
  /// **'Suggested opening cash'**
  String get shiftSuggestedOpeningCash;

  /// No description provided for @shiftCarriedOver.
  ///
  /// In en, this message translates to:
  /// **'Carried over from the last close'**
  String get shiftCarriedOver;

  /// No description provided for @shiftCloseFirstTitle.
  ///
  /// In en, this message translates to:
  /// **'Close shift first'**
  String get shiftCloseFirstTitle;

  /// No description provided for @shiftCloseFirstBody.
  ///
  /// In en, this message translates to:
  /// **'You have an open shift. You must close it before signing out.'**
  String get shiftCloseFirstBody;

  /// No description provided for @shiftOpenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start a new selling session'**
  String get shiftOpenSubtitle;

  /// No description provided for @shiftOpenCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Open a new shift'**
  String get shiftOpenCardTitle;

  /// No description provided for @shiftOpenCardBody.
  ///
  /// In en, this message translates to:
  /// **'Count the cash in the drawer before you start.'**
  String get shiftOpenCardBody;

  /// No description provided for @shiftSuggestedFromLastClose.
  ///
  /// In en, this message translates to:
  /// **'Suggested — carried over from the last close'**
  String get shiftSuggestedFromLastClose;

  /// No description provided for @shiftErrorValidCash.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid cash amount'**
  String get shiftErrorValidCash;

  /// No description provided for @shiftErrorNoBranch.
  ///
  /// In en, this message translates to:
  /// **'No branch assigned to your account'**
  String get shiftErrorNoBranch;

  /// No description provided for @shiftOpenConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Open shift with {amount} in the drawer?'**
  String shiftOpenConfirmBody(Object amount);

  /// No description provided for @shiftOpenOfflineNote.
  ///
  /// In en, this message translates to:
  /// **'You are offline — the shift will open on this device and sync when you reconnect.'**
  String get shiftOpenOfflineNote;

  /// No description provided for @shiftOpenFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to open shift'**
  String get shiftOpenFailed;

  /// No description provided for @shiftOpenedOfflineFooter.
  ///
  /// In en, this message translates to:
  /// **'Offline — the shift opens on this device and syncs later.'**
  String get shiftOpenedOfflineFooter;

  /// No description provided for @shiftCloseConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Close shift?'**
  String get shiftCloseConfirmTitle;

  /// No description provided for @shiftCloseConfirmBodyOnline.
  ///
  /// In en, this message translates to:
  /// **'You will count cash and inventory on the next screen.'**
  String get shiftCloseConfirmBodyOnline;

  /// No description provided for @shiftCloseConfirmBodyOffline.
  ///
  /// In en, this message translates to:
  /// **'You\'re offline — the close will be queued on this device and synced when you reconnect. You will count cash and inventory on the next screen.'**
  String get shiftCloseConfirmBodyOffline;

  /// No description provided for @shiftCloseWillSync.
  ///
  /// In en, this message translates to:
  /// **'Close shift (will sync)'**
  String get shiftCloseWillSync;

  /// No description provided for @shiftCloseQueueConfirm.
  ///
  /// In en, this message translates to:
  /// **'Close (will sync)'**
  String get shiftCloseQueueConfirm;

  /// No description provided for @shiftErrorValidClosingCash.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid closing cash amount'**
  String get shiftErrorValidClosingCash;

  /// No description provided for @shiftZeroStockTitle.
  ///
  /// In en, this message translates to:
  /// **'Zero stock warning'**
  String get shiftZeroStockTitle;

  /// No description provided for @shiftZeroStockBody.
  ///
  /// In en, this message translates to:
  /// **'These items are counted as 0:\n\n{items}\n\nAre you sure you want to submit?'**
  String shiftZeroStockBody(Object items);

  /// No description provided for @shiftSubmitAnyway.
  ///
  /// In en, this message translates to:
  /// **'Submit anyway'**
  String get shiftSubmitAnyway;

  /// No description provided for @shiftCloseFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to close shift'**
  String get shiftCloseFailed;

  /// No description provided for @shiftNothingToClose.
  ///
  /// In en, this message translates to:
  /// **'There is nothing to close right now.'**
  String get shiftNothingToClose;

  /// No description provided for @shiftSummary.
  ///
  /// In en, this message translates to:
  /// **'Shift Summary'**
  String get shiftSummary;

  /// No description provided for @shiftOpenedAtLabel.
  ///
  /// In en, this message translates to:
  /// **'Opened at'**
  String get shiftOpenedAtLabel;

  /// No description provided for @shiftCashCount.
  ///
  /// In en, this message translates to:
  /// **'Cash Count'**
  String get shiftCashCount;

  /// No description provided for @shiftSystemCash.
  ///
  /// In en, this message translates to:
  /// **'System cash'**
  String get shiftSystemCash;

  /// No description provided for @shiftSystemCashExplain.
  ///
  /// In en, this message translates to:
  /// **'Opening + cash orders + movements'**
  String get shiftSystemCashExplain;

  /// No description provided for @shiftActualCash.
  ///
  /// In en, this message translates to:
  /// **'Actual cash in drawer'**
  String get shiftActualCash;

  /// No description provided for @shiftCashNoteOptional.
  ///
  /// In en, this message translates to:
  /// **'Cash note (optional)'**
  String get shiftCashNoteOptional;

  /// No description provided for @shiftInventoryCount.
  ///
  /// In en, this message translates to:
  /// **'Inventory Count'**
  String get shiftInventoryCount;

  /// No description provided for @shiftUseSystemCounts.
  ///
  /// In en, this message translates to:
  /// **'Use system counts'**
  String get shiftUseSystemCounts;

  /// No description provided for @shiftNoInventory.
  ///
  /// In en, this message translates to:
  /// **'No inventory items'**
  String get shiftNoInventory;

  /// No description provided for @shiftSystemStock.
  ///
  /// In en, this message translates to:
  /// **'System: {stock} {unit}'**
  String shiftSystemStock(Object stock, Object unit);

  /// No description provided for @shiftZeroConfirmHint.
  ///
  /// In en, this message translates to:
  /// **'Value is 0 — confirm this is correct'**
  String get shiftZeroConfirmHint;

  /// No description provided for @shiftCloseOfflineNote.
  ///
  /// In en, this message translates to:
  /// **'You\'re offline — the shift will close on this device now and sync automatically'**
  String get shiftCloseOfflineNote;

  /// No description provided for @shiftDrawerMatches.
  ///
  /// In en, this message translates to:
  /// **'Drawer matches'**
  String get shiftDrawerMatches;

  /// No description provided for @shiftDrawerOver.
  ///
  /// In en, this message translates to:
  /// **'Drawer is over by {amount}'**
  String shiftDrawerOver(Object amount);

  /// No description provided for @shiftDrawerShort.
  ///
  /// In en, this message translates to:
  /// **'Drawer is short by {amount}'**
  String shiftDrawerShort(Object amount);

  /// No description provided for @shiftSystemAmount.
  ///
  /// In en, this message translates to:
  /// **'System: {amount}'**
  String shiftSystemAmount(Object amount);

  /// No description provided for @shiftHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Shifts'**
  String get shiftHistoryTitle;

  /// No description provided for @shiftHistorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Past shifts for this branch'**
  String get shiftHistorySubtitle;

  /// No description provided for @shiftErrorNoBranchAssigned.
  ///
  /// In en, this message translates to:
  /// **'No branch assigned'**
  String get shiftErrorNoBranchAssigned;

  /// No description provided for @shiftNoShiftsYet.
  ///
  /// In en, this message translates to:
  /// **'No shifts yet'**
  String get shiftNoShiftsYet;

  /// No description provided for @shiftShiftsAppearHere.
  ///
  /// In en, this message translates to:
  /// **'Opened and closed shifts will show up here.'**
  String get shiftShiftsAppearHere;

  /// No description provided for @shiftColOpened.
  ///
  /// In en, this message translates to:
  /// **'Opened'**
  String get shiftColOpened;

  /// No description provided for @shiftColClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get shiftColClosed;

  /// No description provided for @shiftDeclaredCash.
  ///
  /// In en, this message translates to:
  /// **'Declared cash'**
  String get shiftDeclaredCash;

  /// No description provided for @shiftOpeningChip.
  ///
  /// In en, this message translates to:
  /// **'Opening {amount}'**
  String shiftOpeningChip(Object amount);

  /// No description provided for @shiftOrdersInShift.
  ///
  /// In en, this message translates to:
  /// **'ORDERS IN THIS SHIFT'**
  String get shiftOrdersInShift;

  /// No description provided for @shiftNoOrdersInShift.
  ///
  /// In en, this message translates to:
  /// **'No orders in this shift'**
  String get shiftNoOrdersInShift;

  /// No description provided for @shiftOpenedOn.
  ///
  /// In en, this message translates to:
  /// **'Opened {date}'**
  String shiftOpenedOn(Object date);

  /// No description provided for @shiftReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Shift Report'**
  String get shiftReportTitle;

  /// No description provided for @shiftReportOpenChip.
  ///
  /// In en, this message translates to:
  /// **'Open shift'**
  String get shiftReportOpenChip;

  /// No description provided for @shiftReportDetails.
  ///
  /// In en, this message translates to:
  /// **'SHIFT DETAILS'**
  String get shiftReportDetails;

  /// No description provided for @shiftExpectedCash.
  ///
  /// In en, this message translates to:
  /// **'Expected Cash'**
  String get shiftExpectedCash;

  /// No description provided for @shiftPaymentBreakdown.
  ///
  /// In en, this message translates to:
  /// **'PAYMENT BREAKDOWN'**
  String get shiftPaymentBreakdown;

  /// No description provided for @shiftNoPayments.
  ///
  /// In en, this message translates to:
  /// **'No payments recorded'**
  String get shiftNoPayments;

  /// No description provided for @shiftTotalPayments.
  ///
  /// In en, this message translates to:
  /// **'Total Payments'**
  String get shiftTotalPayments;

  /// No description provided for @shiftVoidedOrders.
  ///
  /// In en, this message translates to:
  /// **'Voided Orders'**
  String get shiftVoidedOrders;

  /// No description provided for @shiftNetPayments.
  ///
  /// In en, this message translates to:
  /// **'Net Payments'**
  String get shiftNetPayments;

  /// No description provided for @shiftCashMovementsHeader.
  ///
  /// In en, this message translates to:
  /// **'CASH MOVEMENTS'**
  String get shiftCashMovementsHeader;

  /// No description provided for @shiftNoCashMovements.
  ///
  /// In en, this message translates to:
  /// **'No cash movements'**
  String get shiftNoCashMovements;

  /// No description provided for @shiftPayIn.
  ///
  /// In en, this message translates to:
  /// **'Pay In'**
  String get shiftPayIn;

  /// No description provided for @shiftPayOut.
  ///
  /// In en, this message translates to:
  /// **'Pay Out'**
  String get shiftPayOut;

  /// No description provided for @shiftReportGenerated.
  ///
  /// In en, this message translates to:
  /// **'Report generated {time}'**
  String shiftReportGenerated(Object time);

  /// No description provided for @shiftReportPrinted.
  ///
  /// In en, this message translates to:
  /// **'Report printed'**
  String get shiftReportPrinted;

  /// No description provided for @shiftCashMovement.
  ///
  /// In en, this message translates to:
  /// **'Cash Movement'**
  String get shiftCashMovement;

  /// No description provided for @shiftErrorValidAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid amount'**
  String get shiftErrorValidAmount;

  /// No description provided for @shiftErrorNoteRequired.
  ///
  /// In en, this message translates to:
  /// **'Note is required'**
  String get shiftErrorNoteRequired;

  /// No description provided for @shiftCashOfflineBanner.
  ///
  /// In en, this message translates to:
  /// **'You\'re offline. Requires connection — cash amounts can\'t be queued safely.'**
  String get shiftCashOfflineBanner;

  /// No description provided for @shiftAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get shiftAmount;

  /// No description provided for @shiftNoteRequired.
  ///
  /// In en, this message translates to:
  /// **'Note (required)'**
  String get shiftNoteRequired;

  /// No description provided for @shiftNoteHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Safe drop, float top-up…'**
  String get shiftNoteHint;

  /// No description provided for @shiftRecordCashIn.
  ///
  /// In en, this message translates to:
  /// **'Record Cash In'**
  String get shiftRecordCashIn;

  /// No description provided for @shiftRecordCashOut.
  ///
  /// In en, this message translates to:
  /// **'Record Cash Out'**
  String get shiftRecordCashOut;

  /// No description provided for @shiftCashInRecorded.
  ///
  /// In en, this message translates to:
  /// **'Cash in recorded — {amount}'**
  String shiftCashInRecorded(Object amount);

  /// No description provided for @shiftCashOutRecorded.
  ///
  /// In en, this message translates to:
  /// **'Cash out recorded — {amount}'**
  String shiftCashOutRecorded(Object amount);

  /// No description provided for @orderCartTitle.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get orderCartTitle;

  /// No description provided for @orderTapToAdd.
  ///
  /// In en, this message translates to:
  /// **'Tap any item to add it.'**
  String get orderTapToAdd;

  /// No description provided for @orderHeldOrders.
  ///
  /// In en, this message translates to:
  /// **'Held orders ({count})'**
  String orderHeldOrders(int count);

  /// No description provided for @orderAddItemsBeforeHold.
  ///
  /// In en, this message translates to:
  /// **'Add items before holding this order'**
  String get orderAddItemsBeforeHold;

  /// No description provided for @orderDeleteHeldTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete held order?'**
  String get orderDeleteHeldTitle;

  /// No description provided for @orderDeleteHeldBody.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{name}\"? All its items will be permanently removed.'**
  String orderDeleteHeldBody(Object name);

  /// No description provided for @orderDeleteActiveTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete active order?'**
  String get orderDeleteActiveTitle;

  /// No description provided for @orderDeleteActiveBody.
  ///
  /// In en, this message translates to:
  /// **'Delete this active order tab? All its items will be permanently removed.'**
  String get orderDeleteActiveBody;

  /// No description provided for @orderDeleteTab.
  ///
  /// In en, this message translates to:
  /// **'Delete tab'**
  String get orderDeleteTab;

  /// No description provided for @orderRenameOrder.
  ///
  /// In en, this message translates to:
  /// **'Rename order'**
  String get orderRenameOrder;

  /// No description provided for @orderRenameHeldOrder.
  ///
  /// In en, this message translates to:
  /// **'Rename held order'**
  String get orderRenameHeldOrder;

  /// No description provided for @orderRenameHint.
  ///
  /// In en, this message translates to:
  /// **'Name this order so it\'s easy to find later.'**
  String get orderRenameHint;

  /// No description provided for @orderRenamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'e.g. Table 5, Sarah, Takeaway'**
  String get orderRenamePlaceholder;

  /// No description provided for @orderRemoveItemTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove item?'**
  String get orderRemoveItemTitle;

  /// No description provided for @orderRemoveItemBody.
  ///
  /// In en, this message translates to:
  /// **'Remove \"{name}\" from the cart?'**
  String orderRemoveItemBody(Object name);

  /// No description provided for @orderItemRemoved.
  ///
  /// In en, this message translates to:
  /// **'{name} removed'**
  String orderItemRemoved(Object name);

  /// No description provided for @orderRemoveComboTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove combo?'**
  String get orderRemoveComboTitle;

  /// No description provided for @orderRemoveComboBody.
  ///
  /// In en, this message translates to:
  /// **'The whole combo \"{name}\" will be removed.'**
  String orderRemoveComboBody(Object name);

  /// No description provided for @orderNoItemsCategory.
  ///
  /// In en, this message translates to:
  /// **'No items in this category'**
  String get orderNoItemsCategory;

  /// No description provided for @orderPickAnotherCategory.
  ///
  /// In en, this message translates to:
  /// **'Pick another category or pull a fresh menu sync.'**
  String get orderPickAnotherCategory;

  /// No description provided for @orderNoResultsFor.
  ///
  /// In en, this message translates to:
  /// **'No results for \"{query}\"'**
  String orderNoResultsFor(Object query);

  /// No description provided for @orderTryShorterName.
  ///
  /// In en, this message translates to:
  /// **'Try a shorter name or check the spelling.'**
  String get orderTryShorterName;

  /// No description provided for @orderCombos.
  ///
  /// In en, this message translates to:
  /// **'Combos'**
  String get orderCombos;

  /// No description provided for @orderCombo.
  ///
  /// In en, this message translates to:
  /// **'Combo'**
  String get orderCombo;

  /// No description provided for @orderComboSave.
  ///
  /// In en, this message translates to:
  /// **'Save {amount}'**
  String orderComboSave(Object amount);

  /// No description provided for @orderItemOutOfStock.
  ///
  /// In en, this message translates to:
  /// **'{name} is out of stock'**
  String orderItemOutOfStock(Object name);

  /// No description provided for @orderOutOfStock.
  ///
  /// In en, this message translates to:
  /// **'Out of stock'**
  String get orderOutOfStock;

  /// No description provided for @orderSizeHeader.
  ///
  /// In en, this message translates to:
  /// **'SIZE'**
  String get orderSizeHeader;

  /// No description provided for @orderRecipe.
  ///
  /// In en, this message translates to:
  /// **'Recipe'**
  String get orderRecipe;

  /// No description provided for @orderRecipeRetry.
  ///
  /// In en, this message translates to:
  /// **'Recipe · Retry'**
  String get orderRecipeRetry;

  /// No description provided for @orderUpdateItem.
  ///
  /// In en, this message translates to:
  /// **'Update Item'**
  String get orderUpdateItem;

  /// No description provided for @orderAddToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get orderAddToCart;

  /// No description provided for @orderSelectOptions.
  ///
  /// In en, this message translates to:
  /// **'Select {name}'**
  String orderSelectOptions(Object name);

  /// No description provided for @orderRequiredOptions.
  ///
  /// In en, this message translates to:
  /// **'required options'**
  String get orderRequiredOptions;

  /// No description provided for @orderOptionalHeader.
  ///
  /// In en, this message translates to:
  /// **'OPTIONAL'**
  String get orderOptionalHeader;

  /// No description provided for @orderRequiredChip.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get orderRequiredChip;

  /// No description provided for @orderMaxSelections.
  ///
  /// In en, this message translates to:
  /// **'Max {max}'**
  String orderMaxSelections(int max);

  /// No description provided for @orderMaxHint.
  ///
  /// In en, this message translates to:
  /// **'Maximum {max} selections for {title}'**
  String orderMaxHint(int max, Object title);

  /// No description provided for @orderSearchOptions.
  ///
  /// In en, this message translates to:
  /// **'Search options…'**
  String get orderSearchOptions;

  /// No description provided for @orderNoMatchFor.
  ///
  /// In en, this message translates to:
  /// **'No match for \"{query}\"'**
  String orderNoMatchFor(Object query);

  /// No description provided for @orderRecipeSizeLabel.
  ///
  /// In en, this message translates to:
  /// **'Size: {size}'**
  String orderRecipeSizeLabel(Object size);

  /// No description provided for @orderRecipeLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load the recipe. Check your connection and try again.'**
  String get orderRecipeLoadError;

  /// No description provided for @orderNoIngredients.
  ///
  /// In en, this message translates to:
  /// **'No ingredients mapped'**
  String get orderNoIngredients;

  /// No description provided for @orderNoRecipeYet.
  ///
  /// In en, this message translates to:
  /// **'This item has no recipe composition yet.'**
  String get orderNoRecipeYet;

  /// No description provided for @orderConfiguredProgress.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} configured'**
  String orderConfiguredProgress(int done, int total);

  /// No description provided for @orderReady.
  ///
  /// In en, this message translates to:
  /// **'Ready'**
  String get orderReady;

  /// No description provided for @orderDefaultOptions.
  ///
  /// In en, this message translates to:
  /// **'Default options'**
  String get orderDefaultOptions;

  /// No description provided for @orderConfigure.
  ///
  /// In en, this message translates to:
  /// **'Configure'**
  String get orderConfigure;

  /// No description provided for @orderConfigureItem.
  ///
  /// In en, this message translates to:
  /// **'Configure {name}'**
  String orderConfigureItem(Object name);

  /// No description provided for @orderConfigureItems.
  ///
  /// In en, this message translates to:
  /// **'Configure items'**
  String get orderConfigureItems;

  /// No description provided for @orderItemUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Item unavailable'**
  String get orderItemUnavailable;

  /// No description provided for @orderItemFallback.
  ///
  /// In en, this message translates to:
  /// **'Item'**
  String get orderItemFallback;

  /// No description provided for @orderTapToChooseOptions.
  ///
  /// In en, this message translates to:
  /// **'Tap to choose options'**
  String get orderTapToChooseOptions;

  /// No description provided for @orderNoOptionsToConfigure.
  ///
  /// In en, this message translates to:
  /// **'No options to configure'**
  String get orderNoOptionsToConfigure;

  /// No description provided for @orderHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orderHistoryTitle;

  /// No description provided for @orderCurrentShift.
  ///
  /// In en, this message translates to:
  /// **'Current shift'**
  String get orderCurrentShift;

  /// No description provided for @orderFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get orderFilterAll;

  /// No description provided for @orderFilterSynced.
  ///
  /// In en, this message translates to:
  /// **'Synced'**
  String get orderFilterSynced;

  /// No description provided for @orderNoOrdersYet.
  ///
  /// In en, this message translates to:
  /// **'No orders yet'**
  String get orderNoOrdersYet;

  /// No description provided for @orderOrdersAppearHere.
  ///
  /// In en, this message translates to:
  /// **'Orders completed during this shift will appear here.'**
  String get orderOrdersAppearHere;

  /// No description provided for @orderOpenShiftToSell.
  ///
  /// In en, this message translates to:
  /// **'Open a shift to start selling — its orders will appear here.'**
  String get orderOpenShiftToSell;

  /// No description provided for @orderNothingHere.
  ///
  /// In en, this message translates to:
  /// **'Nothing here'**
  String get orderNothingHere;

  /// No description provided for @orderNoFilterMatch.
  ///
  /// In en, this message translates to:
  /// **'No orders match the \"{filter}\" filter.'**
  String orderNoFilterMatch(Object filter);

  /// No description provided for @orderStatOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orderStatOrders;

  /// No description provided for @orderMixed.
  ///
  /// In en, this message translates to:
  /// **'Mixed'**
  String get orderMixed;

  /// No description provided for @orderColTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get orderColTime;

  /// No description provided for @orderColAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get orderColAmount;

  /// No description provided for @orderNoItemDetails.
  ///
  /// In en, this message translates to:
  /// **'No item details available'**
  String get orderNoItemDetails;

  /// No description provided for @orderTax14.
  ///
  /// In en, this message translates to:
  /// **'Tax (14%)'**
  String get orderTax14;

  /// No description provided for @orderVoid.
  ///
  /// In en, this message translates to:
  /// **'Void'**
  String get orderVoid;

  /// No description provided for @orderIngredients.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get orderIngredients;

  /// No description provided for @orderIngredientUse.
  ///
  /// In en, this message translates to:
  /// **'Ingredient Use'**
  String get orderIngredientUse;

  /// No description provided for @orderNoDeductions.
  ///
  /// In en, this message translates to:
  /// **'No deductions recorded'**
  String get orderNoDeductions;

  /// No description provided for @orderNoDeductionsBody.
  ///
  /// In en, this message translates to:
  /// **'This order line has no ingredient deductions.'**
  String get orderNoDeductionsBody;

  /// No description provided for @orderSourceBase.
  ///
  /// In en, this message translates to:
  /// **'Base'**
  String get orderSourceBase;

  /// No description provided for @orderSourceComboItem.
  ///
  /// In en, this message translates to:
  /// **'Combo item'**
  String get orderSourceComboItem;

  /// No description provided for @orderSourceAddon.
  ///
  /// In en, this message translates to:
  /// **'Addon'**
  String get orderSourceAddon;

  /// No description provided for @orderVoidTitle.
  ///
  /// In en, this message translates to:
  /// **'Void Order #{number}'**
  String orderVoidTitle(int number);

  /// No description provided for @orderVoidCannotUndo.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone'**
  String get orderVoidCannotUndo;

  /// No description provided for @orderVoidOfflineQueued.
  ///
  /// In en, this message translates to:
  /// **'Offline — void will be queued and applied when reconnected'**
  String get orderVoidOfflineQueued;

  /// No description provided for @orderVoidReasonHeader.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get orderVoidReasonHeader;

  /// No description provided for @orderVoidReasonCustomerRequest.
  ///
  /// In en, this message translates to:
  /// **'Customer request'**
  String get orderVoidReasonCustomerRequest;

  /// No description provided for @orderVoidReasonWrongOrder.
  ///
  /// In en, this message translates to:
  /// **'Wrong order'**
  String get orderVoidReasonWrongOrder;

  /// No description provided for @orderVoidReasonQualityIssue.
  ///
  /// In en, this message translates to:
  /// **'Quality issue'**
  String get orderVoidReasonQualityIssue;

  /// No description provided for @orderVoidReasonOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get orderVoidReasonOther;

  /// No description provided for @orderVoidSelectReason.
  ///
  /// In en, this message translates to:
  /// **'Please select a reason'**
  String get orderVoidSelectReason;

  /// No description provided for @orderVoidSpecifyReason.
  ///
  /// In en, this message translates to:
  /// **'Please specify the other reason'**
  String get orderVoidSpecifyReason;

  /// No description provided for @orderVoidDescribeHint.
  ///
  /// In en, this message translates to:
  /// **'Describe the reason…'**
  String get orderVoidDescribeHint;

  /// No description provided for @orderVoidConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Void order #{number}?'**
  String orderVoidConfirmTitle(int number);

  /// No description provided for @orderVoidConfirmBodyOnline.
  ///
  /// In en, this message translates to:
  /// **'This permanently voids the order and cannot be undone.'**
  String get orderVoidConfirmBodyOnline;

  /// No description provided for @orderVoidConfirmBodyOffline.
  ///
  /// In en, this message translates to:
  /// **'You are offline — the void will be queued and applied when you reconnect.'**
  String get orderVoidConfirmBodyOffline;

  /// No description provided for @orderVoidConfirmAction.
  ///
  /// In en, this message translates to:
  /// **'Void order'**
  String get orderVoidConfirmAction;

  /// No description provided for @orderVoidRestoreTitle.
  ///
  /// In en, this message translates to:
  /// **'Return items to inventory'**
  String get orderVoidRestoreTitle;

  /// No description provided for @orderVoidRestoreBody.
  ///
  /// In en, this message translates to:
  /// **'Ingredients go back into stock'**
  String get orderVoidRestoreBody;

  /// No description provided for @orderVoidAction.
  ///
  /// In en, this message translates to:
  /// **'Void Order'**
  String get orderVoidAction;

  /// No description provided for @orderQueueVoid.
  ///
  /// In en, this message translates to:
  /// **'Queue Void'**
  String get orderQueueVoid;

  /// No description provided for @orderPlaced.
  ///
  /// In en, this message translates to:
  /// **'Order Placed!'**
  String get orderPlaced;

  /// No description provided for @orderQueuedSyncs.
  ///
  /// In en, this message translates to:
  /// **'Queued — syncs automatically'**
  String get orderQueuedSyncs;

  /// No description provided for @orderNumber.
  ///
  /// In en, this message translates to:
  /// **'Order #{number}'**
  String orderNumber(int number);

  /// No description provided for @orderReceiptTip.
  ///
  /// In en, this message translates to:
  /// **'Tip'**
  String get orderReceiptTip;

  /// No description provided for @orderReceiptCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get orderReceiptCustomer;

  /// No description provided for @orderReceiptTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get orderReceiptTime;

  /// No description provided for @orderChangeGiven.
  ///
  /// In en, this message translates to:
  /// **'Change Given'**
  String get orderChangeGiven;

  /// No description provided for @orderNewOrder.
  ///
  /// In en, this message translates to:
  /// **'New Order'**
  String get orderNewOrder;

  /// No description provided for @orderPrintingReceipt.
  ///
  /// In en, this message translates to:
  /// **'Printing receipt…'**
  String get orderPrintingReceipt;

  /// No description provided for @orderReceiptFailed.
  ///
  /// In en, this message translates to:
  /// **'Receipt didn\'t print'**
  String get orderReceiptFailed;

  /// No description provided for @orderReceiptPrinted.
  ///
  /// In en, this message translates to:
  /// **'Receipt printed'**
  String get orderReceiptPrinted;

  /// No description provided for @orderReprint.
  ///
  /// In en, this message translates to:
  /// **'Reprint'**
  String get orderReprint;

  /// No description provided for @orderReceiptPreview.
  ///
  /// In en, this message translates to:
  /// **'Receipt Preview'**
  String get orderReceiptPreview;

  /// No description provided for @orderDraftReceiptPreview.
  ///
  /// In en, this message translates to:
  /// **'Draft Receipt Preview'**
  String get orderDraftReceiptPreview;

  /// No description provided for @orderReceiptPrintedOk.
  ///
  /// In en, this message translates to:
  /// **'Receipt printed successfully'**
  String get orderReceiptPrintedOk;

  /// No description provided for @checkoutDiscountOptional.
  ///
  /// In en, this message translates to:
  /// **'DISCOUNT (OPTIONAL)'**
  String get checkoutDiscountOptional;

  /// No description provided for @checkoutCustomerOptional.
  ///
  /// In en, this message translates to:
  /// **'CUSTOMER NAME (OPTIONAL)'**
  String get checkoutCustomerOptional;

  /// No description provided for @checkoutNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Ahmed'**
  String get checkoutNameHint;

  /// No description provided for @checkoutPaymentHeader.
  ///
  /// In en, this message translates to:
  /// **'PAYMENT'**
  String get checkoutPaymentHeader;

  /// No description provided for @checkoutSplitPayment.
  ///
  /// In en, this message translates to:
  /// **'Split payment'**
  String get checkoutSplitPayment;

  /// No description provided for @checkoutLoadingMethods.
  ///
  /// In en, this message translates to:
  /// **'Loading payment methods…'**
  String get checkoutLoadingMethods;

  /// No description provided for @checkoutNoMethodsConfigured.
  ///
  /// In en, this message translates to:
  /// **'No payment methods are configured for this organization. Add them from the dashboard, then try again.'**
  String get checkoutNoMethodsConfigured;

  /// No description provided for @checkoutMethodsLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load payment methods'**
  String get checkoutMethodsLoadFailed;

  /// No description provided for @checkoutMethodsNeeded.
  ///
  /// In en, this message translates to:
  /// **'Orders need a payment method — check your connection and retry.'**
  String get checkoutMethodsNeeded;

  /// No description provided for @checkoutPreview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get checkoutPreview;

  /// No description provided for @checkoutSelectMethod.
  ///
  /// In en, this message translates to:
  /// **'Select a payment method'**
  String get checkoutSelectMethod;

  /// No description provided for @checkoutNoDiscount.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get checkoutNoDiscount;

  /// No description provided for @checkoutTipOptional.
  ///
  /// In en, this message translates to:
  /// **'TIP (OPTIONAL)'**
  String get checkoutTipOptional;

  /// No description provided for @checkoutTipAmount.
  ///
  /// In en, this message translates to:
  /// **'Tip amount'**
  String get checkoutTipAmount;

  /// No description provided for @checkoutCashTendered.
  ///
  /// In en, this message translates to:
  /// **'Cash tendered'**
  String get checkoutCashTendered;

  /// No description provided for @checkoutExact.
  ///
  /// In en, this message translates to:
  /// **'Exact'**
  String get checkoutExact;

  /// No description provided for @checkoutChangeDue.
  ///
  /// In en, this message translates to:
  /// **'Change due'**
  String get checkoutChangeDue;

  /// No description provided for @checkoutShortBy.
  ///
  /// In en, this message translates to:
  /// **'Short by'**
  String get checkoutShortBy;

  /// No description provided for @checkoutSelectSplitMethods.
  ///
  /// In en, this message translates to:
  /// **'Select the methods the customer is paying with.'**
  String get checkoutSelectSplitMethods;

  /// No description provided for @checkoutRemaining.
  ///
  /// In en, this message translates to:
  /// **'{amount} remaining'**
  String checkoutRemaining(Object amount);

  /// No description provided for @checkoutOver.
  ///
  /// In en, this message translates to:
  /// **'{amount} over'**
  String checkoutOver(Object amount);

  /// No description provided for @checkoutBalanced.
  ///
  /// In en, this message translates to:
  /// **'Balanced'**
  String get checkoutBalanced;

  /// No description provided for @syncCenterTitle.
  ///
  /// In en, this message translates to:
  /// **'Sync Center'**
  String get syncCenterTitle;

  /// No description provided for @syncPausedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Paused — sign in to resume'**
  String get syncPausedSubtitle;

  /// No description provided for @syncOfflineQueued.
  ///
  /// In en, this message translates to:
  /// **'Offline — {count} queued'**
  String syncOfflineQueued(int count);

  /// No description provided for @syncSyncing.
  ///
  /// In en, this message translates to:
  /// **'Syncing…'**
  String get syncSyncing;

  /// No description provided for @syncNeedAttention.
  ///
  /// In en, this message translates to:
  /// **'{count} need attention'**
  String syncNeedAttention(int count);

  /// No description provided for @syncWaitingCount.
  ///
  /// In en, this message translates to:
  /// **'{count} waiting to sync'**
  String syncWaitingCount(int count);

  /// No description provided for @syncAllSyncedBody.
  ///
  /// In en, this message translates to:
  /// **'Every sale, shift and void on this device has reached the server. Pull down to check again.'**
  String get syncAllSyncedBody;

  /// No description provided for @syncNeedsAttentionHeader.
  ///
  /// In en, this message translates to:
  /// **'NEEDS ATTENTION'**
  String get syncNeedsAttentionHeader;

  /// No description provided for @syncWaitingHeader.
  ///
  /// In en, this message translates to:
  /// **'WAITING TO SYNC'**
  String get syncWaitingHeader;

  /// No description provided for @syncPausedTitle.
  ///
  /// In en, this message translates to:
  /// **'Session expired — sign in to resume syncing'**
  String get syncPausedTitle;

  /// No description provided for @syncPausedBody.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 queued item is safe on this device. Syncing is paused until you sign in again — the app will take you to the sign-in screen when needed, and the queue resumes automatically.} other{{count} queued items are safe on this device. Syncing is paused until you sign in again — the app will take you to the sign-in screen when needed, and the queue resumes automatically.}}'**
  String syncPausedBody(int count);

  /// No description provided for @syncOfflineBody.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 item queued. Everything keeps working and syncs automatically when you reconnect.} other{{count} items queued. Everything keeps working and syncs automatically when you reconnect.}}'**
  String syncOfflineBody(int count);

  /// No description provided for @syncSyncingBody.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 item remaining.} other{{count} items remaining.}}'**
  String syncSyncingBody(int count);

  /// No description provided for @syncStuckTitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 item needs attention} other{{count} items need attention}}'**
  String syncStuckTitle(int count);

  /// No description provided for @syncStuckBody.
  ///
  /// In en, this message translates to:
  /// **'These stopped syncing after repeated failures. Retry or discard them below.'**
  String get syncStuckBody;

  /// No description provided for @syncWaitingTitle.
  ///
  /// In en, this message translates to:
  /// **'Waiting to sync'**
  String get syncWaitingTitle;

  /// No description provided for @syncWaitingBody.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 item will sync shortly.} other{{count} items will sync shortly.}}'**
  String syncWaitingBody(int count);

  /// No description provided for @syncShiftOpenChip.
  ///
  /// In en, this message translates to:
  /// **'{count} shift open'**
  String syncShiftOpenChip(int count);

  /// No description provided for @syncShiftCloseChip.
  ///
  /// In en, this message translates to:
  /// **'{count} shift close'**
  String syncShiftCloseChip(int count);

  /// No description provided for @syncVoidsChip.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 void} other{{count} voids}}'**
  String syncVoidsChip(int count);

  /// No description provided for @syncCashChip.
  ///
  /// In en, this message translates to:
  /// **'{count} cash'**
  String syncCashChip(int count);

  /// No description provided for @syncStuckChip.
  ///
  /// In en, this message translates to:
  /// **'{count} stuck'**
  String syncStuckChip(int count);

  /// No description provided for @syncFromAnotherSession.
  ///
  /// In en, this message translates to:
  /// **'From another session'**
  String get syncFromAnotherSession;

  /// No description provided for @syncOtherSessionBody.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 item — syncs when that user signs in on this device} other{{count} items — sync when that user signs in on this device}}'**
  String syncOtherSessionBody(int count);

  /// No description provided for @syncSyncingChip.
  ///
  /// In en, this message translates to:
  /// **'Syncing'**
  String get syncSyncingChip;

  /// No description provided for @syncWalkIn.
  ///
  /// In en, this message translates to:
  /// **'Walk-in'**
  String get syncWalkIn;

  /// No description provided for @syncOpeningCashDetail.
  ///
  /// In en, this message translates to:
  /// **'Opening cash {amount}'**
  String syncOpeningCashDetail(Object amount);

  /// No description provided for @syncClosingCashDetail.
  ///
  /// In en, this message translates to:
  /// **'Closing cash {amount}'**
  String syncClosingCashDetail(Object amount);

  /// No description provided for @syncReason.
  ///
  /// In en, this message translates to:
  /// **'Reason: {reason}'**
  String syncReason(Object reason);

  /// No description provided for @syncWaitingFor.
  ///
  /// In en, this message translates to:
  /// **'Waiting for: {label}'**
  String syncWaitingFor(Object label);

  /// No description provided for @syncAfterAllOrders.
  ///
  /// In en, this message translates to:
  /// **'Syncs after all orders'**
  String get syncAfterAllOrders;

  /// No description provided for @syncFailedAttempts.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 failed attempt — will retry automatically} other{{count} failed attempts — will retry automatically}}'**
  String syncFailedAttempts(int count);

  /// No description provided for @syncStoppedAfterFailures.
  ///
  /// In en, this message translates to:
  /// **'Stopped after repeated failures'**
  String get syncStoppedAfterFailures;

  /// No description provided for @syncDiscardConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Discard this {label}?'**
  String syncDiscardConfirmTitle(Object label);

  /// No description provided for @syncDiscardConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'It will be permanently removed from the sync queue and will never reach the server.'**
  String get syncDiscardConfirmBody;

  /// No description provided for @syncTypeOrder.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get syncTypeOrder;

  /// No description provided for @syncTypeVoidOrder.
  ///
  /// In en, this message translates to:
  /// **'Void Order'**
  String get syncTypeVoidOrder;

  /// No description provided for @syncTypeCashMovement.
  ///
  /// In en, this message translates to:
  /// **'Cash Movement'**
  String get syncTypeCashMovement;

  /// No description provided for @syncTypeUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get syncTypeUnknown;

  /// No description provided for @syncPendingOrder.
  ///
  /// In en, this message translates to:
  /// **'Pending Order'**
  String get syncPendingOrder;

  /// No description provided for @syncJustNow.
  ///
  /// In en, this message translates to:
  /// **'just now'**
  String get syncJustNow;

  /// No description provided for @syncMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m ago'**
  String syncMinutesAgo(int minutes);

  /// No description provided for @syncHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours}h ago'**
  String syncHoursAgo(int hours);

  /// No description provided for @syncDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days}d ago'**
  String syncDaysAgo(int days);

  /// No description provided for @syncSignInToSync.
  ///
  /// In en, this message translates to:
  /// **'Sign in to sync {count}'**
  String syncSignInToSync(int count);

  /// No description provided for @syncSyncingCount.
  ///
  /// In en, this message translates to:
  /// **'Syncing {count}…'**
  String syncSyncingCount(int count);

  /// No description provided for @syncOfflineSessionBanner.
  ///
  /// In en, this message translates to:
  /// **'Offline session — sales queue on this device. Sign in when online to sync.'**
  String get syncOfflineSessionBanner;

  /// No description provided for @syncOfflineBanner.
  ///
  /// In en, this message translates to:
  /// **'Offline — everything keeps working and syncs when you reconnect.'**
  String get syncOfflineBanner;

  /// No description provided for @syncSessionExpiredBanner.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Session expired — sign in to resume syncing 1 queued item.} other{Session expired — sign in to resume syncing {count} queued items.}}'**
  String syncSessionExpiredBanner(int count);

  /// No description provided for @settingsVersionCopied.
  ///
  /// In en, this message translates to:
  /// **'Version copied to clipboard'**
  String get settingsVersionCopied;

  /// No description provided for @settingsSignOutTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign out?'**
  String get settingsSignOutTitle;

  /// No description provided for @settingsSignOutBody.
  ///
  /// In en, this message translates to:
  /// **'You will need your name and PIN to sign back in.'**
  String get settingsSignOutBody;

  /// No description provided for @settingsCloseShiftFirstBody.
  ///
  /// In en, this message translates to:
  /// **'Your shift is still open. Close it and count the drawer before signing out.'**
  String get settingsCloseShiftFirstBody;

  /// No description provided for @settingsGoCloseShift.
  ///
  /// In en, this message translates to:
  /// **'Go to close shift'**
  String get settingsGoCloseShift;

  /// No description provided for @settingsAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingsAccount;

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsThemeSystem;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsDiagnostics.
  ///
  /// In en, this message translates to:
  /// **'Diagnostics'**
  String get settingsDiagnostics;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAbout;

  /// No description provided for @settingsWarningsLog.
  ///
  /// In en, this message translates to:
  /// **'Warnings log'**
  String get settingsWarningsLog;

  /// No description provided for @settingsNoWarnings.
  ///
  /// In en, this message translates to:
  /// **'No warnings recorded'**
  String get settingsNoWarnings;

  /// No description provided for @settingsEntriesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 entry} other{{count} entries}}'**
  String settingsEntriesCount(int count);

  /// No description provided for @settingsWarningsBody.
  ///
  /// In en, this message translates to:
  /// **'Cache and sync warnings will show up here when they happen.'**
  String get settingsWarningsBody;

  /// No description provided for @settingsDiagnosticsCopied.
  ///
  /// In en, this message translates to:
  /// **'Diagnostics copied to clipboard'**
  String get settingsDiagnosticsCopied;

  /// No description provided for @setupConnectDevice.
  ///
  /// In en, this message translates to:
  /// **'Connect Device'**
  String get setupConnectDevice;

  /// No description provided for @setupConnectSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with your manager account to link this device to your branch.'**
  String get setupConnectSubtitle;

  /// No description provided for @setupEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get setupEmail;

  /// No description provided for @setupPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get setupPassword;

  /// No description provided for @setupContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get setupContinue;

  /// No description provided for @setupEnterCredentials.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and password'**
  String get setupEnterCredentials;

  /// No description provided for @setupSelectBranch.
  ///
  /// In en, this message translates to:
  /// **'Select Branch'**
  String get setupSelectBranch;

  /// No description provided for @setupSelectBranchSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the branch this device will serve.'**
  String get setupSelectBranchSubtitle;

  /// No description provided for @setupNoBranches.
  ///
  /// In en, this message translates to:
  /// **'No active branches found.'**
  String get setupNoBranches;

  /// No description provided for @settingsDeviceSection.
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get settingsDeviceSection;

  /// No description provided for @settingsReconfigureDevice.
  ///
  /// In en, this message translates to:
  /// **'Reconfigure Device'**
  String get settingsReconfigureDevice;

  /// No description provided for @settingsReconfigureShiftOpen.
  ///
  /// In en, this message translates to:
  /// **'Close the current shift before reconfiguring the device.'**
  String get settingsReconfigureShiftOpen;

  /// No description provided for @settingsReconfigureTitle.
  ///
  /// In en, this message translates to:
  /// **'Reconfigure Device?'**
  String get settingsReconfigureTitle;

  /// No description provided for @settingsReconfigureBody.
  ///
  /// In en, this message translates to:
  /// **'This will sign you out and require a manager login to reconnect.'**
  String get settingsReconfigureBody;

  /// No description provided for @settingsReconfigureConfirm.
  ///
  /// In en, this message translates to:
  /// **'Reconfigure'**
  String get settingsReconfigureConfirm;

  /// No description provided for @receiptOrderLabel.
  ///
  /// In en, this message translates to:
  /// **'Order #'**
  String get receiptOrderLabel;

  /// No description provided for @receiptDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get receiptDate;

  /// No description provided for @receiptItems.
  ///
  /// In en, this message translates to:
  /// **'ITEMS'**
  String get receiptItems;

  /// No description provided for @receiptNoItems.
  ///
  /// In en, this message translates to:
  /// **'No items in cart'**
  String get receiptNoItems;

  /// No description provided for @receiptVoidedStamp.
  ///
  /// In en, this message translates to:
  /// **'*** VOIDED ***'**
  String get receiptVoidedStamp;

  /// No description provided for @receiptThankYou.
  ///
  /// In en, this message translates to:
  /// **'Thank you for visiting!'**
  String get receiptThankYou;

  /// No description provided for @receiptDraft.
  ///
  /// In en, this message translates to:
  /// **'DRAFT'**
  String get receiptDraft;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
