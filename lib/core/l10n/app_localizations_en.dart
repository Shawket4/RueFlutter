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

  @override
  String get commonSave => 'Save';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonRemove => 'Remove';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonClear => 'Clear';

  @override
  String get commonCopyAll => 'Copy all';

  @override
  String get commonContinue => 'Continue';

  @override
  String get commonLoading => 'Loading…';

  @override
  String get commonRefresh => 'Refresh';

  @override
  String get commonUndo => 'Undo';

  @override
  String get commonOffline => 'Offline';

  @override
  String get commonSomethingWentWrong => 'Something went wrong';

  @override
  String get commonNoDataAvailable => 'No data available';

  @override
  String get commonSignOut => 'Sign out';

  @override
  String get commonPrint => 'Print';

  @override
  String get commonPrintReport => 'Print Report';

  @override
  String get commonRetryPrint => 'Retry Print';

  @override
  String get commonNoPrinterForBranch =>
      'No printer configured for this branch';

  @override
  String commonFailedLoadReport(Object error) {
    return 'Failed to load report: $error';
  }

  @override
  String get commonVoided => 'Voided';

  @override
  String get commonPendingSync => 'Pending sync';

  @override
  String get commonTeller => 'Teller';

  @override
  String commonOrdersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count orders',
      one: '1 order',
    );
    return '$_temp0';
  }

  @override
  String commonItemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
    );
    return '$_temp0';
  }

  @override
  String commonCopyright(Object year) {
    return '© $year Sufrix';
  }

  @override
  String get commonCashOfflineHint =>
      'Requires connection — cash amounts can\'t be queued safely';

  @override
  String get commonRequiresConnection => 'Requires connection';

  @override
  String get loginWelcome => 'Welcome';

  @override
  String get loginWelcomeBack => 'Welcome\nback.';

  @override
  String get loginSubtitle => 'Sign in to start your shift and manage orders.';

  @override
  String get loginBrandTagline =>
      'Sign in to start your shift\nand manage orders.';

  @override
  String get loginSessionExpiredBanner =>
      'Your session expired — please sign in again.';

  @override
  String loginBlockedBanner(Object name) {
    return 'Branch has an open shift belonging to \"$name\". They must close it before you can sign in.';
  }

  @override
  String get loginOfflineBanner =>
      'You\'re offline. You can still sign in offline — sales will queue on this device until you sign in online.';

  @override
  String get loginNameHint => 'Your name';

  @override
  String get loginSignIn => 'Sign in';

  @override
  String get loginSignInOffline => 'Sign in offline';

  @override
  String get loginAutoSubmitHint =>
      'Entering all 6 digits signs you in automatically.';

  @override
  String get loginOfflineExplain =>
      'Offline sign-in uses this device\'s cached account. Sales will queue until you sign in online.';

  @override
  String get loginErrorEnterName => 'Please enter your name';

  @override
  String get loginErrorEnterPin => 'Enter your 6-digit PIN';

  @override
  String shellGreetingMorning(Object name) {
    return 'Good Morning, $name';
  }

  @override
  String shellGreetingAfternoon(Object name) {
    return 'Good Afternoon, $name';
  }

  @override
  String shellGreetingEvening(Object name) {
    return 'Good Evening, $name';
  }

  @override
  String get shellPastOrders => 'Past Orders';

  @override
  String get shellSync => 'Sync';

  @override
  String get shellCashInOut => 'Cash In / Out';

  @override
  String get shellPastShifts => 'Past Shifts';

  @override
  String get shellMore => 'More';

  @override
  String get shellSearchMenu => 'Search menu…';

  @override
  String get shellRefreshMenu => 'Refresh menu';

  @override
  String get shellShiftActions => 'Shift actions';

  @override
  String get shellDefaultOrderName => 'Order 1';

  @override
  String get shellBrowse => 'Browse';

  @override
  String get shellCashAndShift => 'Cash & shift';

  @override
  String shellShiftOpenedAt(Object time, Object cash) {
    return 'Opened $time · Opening $cash';
  }

  @override
  String shellShiftOpenedOffline(Object time) {
    return 'Opened $time · Offline mode';
  }

  @override
  String get shiftNoOpenShift => 'No open shift';

  @override
  String get shiftOpenPrompt => 'Open a shift to start taking orders.';

  @override
  String get shiftStatusOpen => 'Open';

  @override
  String get shiftStatusClosed => 'Closed';

  @override
  String get shiftStatusForceClosed => 'Force closed';

  @override
  String get shiftSuggestedOpeningCash => 'Suggested opening cash';

  @override
  String get shiftCarriedOver => 'Carried over from the last close';

  @override
  String get shiftCloseFirstTitle => 'Close shift first';

  @override
  String get shiftCloseFirstBody =>
      'You have an open shift. You must close it before signing out.';

  @override
  String get shiftOpenSubtitle => 'Start a new selling session';

  @override
  String get shiftOpenCardTitle => 'Open a new shift';

  @override
  String get shiftOpenCardBody =>
      'Count the cash in the drawer before you start.';

  @override
  String get shiftSuggestedFromLastClose =>
      'Suggested — carried over from the last close';

  @override
  String get shiftErrorValidCash => 'Enter a valid cash amount';

  @override
  String get shiftErrorNoBranch => 'No branch assigned to your account';

  @override
  String shiftOpenConfirmBody(Object amount) {
    return 'Open shift with $amount in the drawer?';
  }

  @override
  String get shiftOpenOfflineNote =>
      'You are offline — the shift will open on this device and sync when you reconnect.';

  @override
  String get shiftOpenFailed => 'Failed to open shift';

  @override
  String get shiftOpenedOfflineFooter =>
      'Offline — the shift opens on this device and syncs later.';

  @override
  String get shiftCloseConfirmTitle => 'Close shift?';

  @override
  String get shiftCloseConfirmBodyOnline =>
      'You will count cash and inventory on the next screen.';

  @override
  String get shiftCloseConfirmBodyOffline =>
      'You\'re offline — the close will be queued on this device and synced when you reconnect. You will count cash and inventory on the next screen.';

  @override
  String get shiftCloseWillSync => 'Close shift (will sync)';

  @override
  String get shiftCloseQueueConfirm => 'Close (will sync)';

  @override
  String get shiftErrorValidClosingCash => 'Enter a valid closing cash amount';

  @override
  String get shiftZeroStockTitle => 'Zero stock warning';

  @override
  String shiftZeroStockBody(Object items) {
    return 'These items are counted as 0:\n\n$items\n\nAre you sure you want to submit?';
  }

  @override
  String get shiftSubmitAnyway => 'Submit anyway';

  @override
  String get shiftCloseFailed => 'Failed to close shift';

  @override
  String get shiftNothingToClose => 'There is nothing to close right now.';

  @override
  String get shiftSummary => 'Shift Summary';

  @override
  String get shiftOpenedAtLabel => 'Opened at';

  @override
  String get shiftCashCount => 'Cash Count';

  @override
  String get shiftSystemCash => 'System cash';

  @override
  String get shiftSystemCashExplain => 'Opening + cash orders + movements';

  @override
  String get shiftActualCash => 'Actual cash in drawer';

  @override
  String get shiftCashNoteOptional => 'Cash note (optional)';

  @override
  String get shiftInventoryCount => 'Inventory Count';

  @override
  String get shiftUseSystemCounts => 'Use system counts';

  @override
  String get shiftNoInventory => 'No inventory items';

  @override
  String shiftSystemStock(Object stock, Object unit) {
    return 'System: $stock $unit';
  }

  @override
  String get shiftZeroConfirmHint => 'Value is 0 — confirm this is correct';

  @override
  String get shiftCloseOfflineNote =>
      'You\'re offline — the shift will close on this device now and sync automatically';

  @override
  String get shiftDrawerMatches => 'Drawer matches';

  @override
  String shiftDrawerOver(Object amount) {
    return 'Drawer is over by $amount';
  }

  @override
  String shiftDrawerShort(Object amount) {
    return 'Drawer is short by $amount';
  }

  @override
  String shiftSystemAmount(Object amount) {
    return 'System: $amount';
  }

  @override
  String get shiftHistoryTitle => 'Shifts';

  @override
  String get shiftHistorySubtitle => 'Past shifts for this branch';

  @override
  String get shiftErrorNoBranchAssigned => 'No branch assigned';

  @override
  String get shiftNoShiftsYet => 'No shifts yet';

  @override
  String get shiftShiftsAppearHere =>
      'Opened and closed shifts will show up here.';

  @override
  String get shiftColOpened => 'Opened';

  @override
  String get shiftColClosed => 'Closed';

  @override
  String get shiftDeclaredCash => 'Declared cash';

  @override
  String shiftOpeningChip(Object amount) {
    return 'Opening $amount';
  }

  @override
  String get shiftOrdersInShift => 'ORDERS IN THIS SHIFT';

  @override
  String get shiftNoOrdersInShift => 'No orders in this shift';

  @override
  String shiftOpenedOn(Object date) {
    return 'Opened $date';
  }

  @override
  String get shiftReportTitle => 'Shift Report';

  @override
  String get shiftReportOpenChip => 'Open shift';

  @override
  String get shiftReportDetails => 'SHIFT DETAILS';

  @override
  String get shiftExpectedCash => 'Expected Cash';

  @override
  String get shiftPaymentBreakdown => 'PAYMENT BREAKDOWN';

  @override
  String get shiftNoPayments => 'No payments recorded';

  @override
  String get shiftTotalPayments => 'Total Payments';

  @override
  String get shiftVoidedOrders => 'Voided Orders';

  @override
  String get shiftNetPayments => 'Net Payments';

  @override
  String get shiftCashMovementsHeader => 'CASH MOVEMENTS';

  @override
  String get shiftNoCashMovements => 'No cash movements';

  @override
  String get shiftPayIn => 'Pay In';

  @override
  String get shiftPayOut => 'Pay Out';

  @override
  String shiftReportGenerated(Object time) {
    return 'Report generated $time';
  }

  @override
  String get shiftReportPrinted => 'Report printed';

  @override
  String get shiftCashMovement => 'Cash Movement';

  @override
  String get shiftErrorValidAmount => 'Enter a valid amount';

  @override
  String get shiftErrorNoteRequired => 'Note is required';

  @override
  String get shiftCashOfflineBanner =>
      'You\'re offline. Requires connection — cash amounts can\'t be queued safely.';

  @override
  String get shiftAmount => 'Amount';

  @override
  String get shiftNoteRequired => 'Note (required)';

  @override
  String get shiftNoteHint => 'e.g. Safe drop, float top-up…';

  @override
  String get shiftRecordCashIn => 'Record Cash In';

  @override
  String get shiftRecordCashOut => 'Record Cash Out';

  @override
  String shiftCashInRecorded(Object amount) {
    return 'Cash in recorded — $amount';
  }

  @override
  String shiftCashOutRecorded(Object amount) {
    return 'Cash out recorded — $amount';
  }

  @override
  String get orderCartTitle => 'Order';

  @override
  String get orderTapToAdd => 'Tap any item to add it.';

  @override
  String orderHeldOrders(int count) {
    return 'Held orders ($count)';
  }

  @override
  String get orderAddItemsBeforeHold => 'Add items before holding this order';

  @override
  String get orderDeleteHeldTitle => 'Delete held order?';

  @override
  String orderDeleteHeldBody(Object name) {
    return 'Delete \"$name\"? All its items will be permanently removed.';
  }

  @override
  String get orderDeleteActiveTitle => 'Delete active order?';

  @override
  String get orderDeleteActiveBody =>
      'Delete this active order tab? All its items will be permanently removed.';

  @override
  String get orderDeleteTab => 'Delete tab';

  @override
  String get orderRenameOrder => 'Rename order';

  @override
  String get orderRenameHeldOrder => 'Rename held order';

  @override
  String get orderRenameHint => 'Name this order so it\'s easy to find later.';

  @override
  String get orderRenamePlaceholder => 'e.g. Table 5, Sarah, Takeaway';

  @override
  String get orderRemoveItemTitle => 'Remove item?';

  @override
  String orderRemoveItemBody(Object name) {
    return 'Remove \"$name\" from the cart?';
  }

  @override
  String orderItemRemoved(Object name) {
    return '$name removed';
  }

  @override
  String get orderRemoveComboTitle => 'Remove combo?';

  @override
  String orderRemoveComboBody(Object name) {
    return 'The whole combo \"$name\" will be removed.';
  }

  @override
  String get orderNoItemsCategory => 'No items in this category';

  @override
  String get orderPickAnotherCategory =>
      'Pick another category or pull a fresh menu sync.';

  @override
  String orderNoResultsFor(Object query) {
    return 'No results for \"$query\"';
  }

  @override
  String get orderTryShorterName => 'Try a shorter name or check the spelling.';

  @override
  String get orderCombos => 'Combos';

  @override
  String get orderCombo => 'Combo';

  @override
  String orderComboSave(Object amount) {
    return 'Save $amount';
  }

  @override
  String orderItemOutOfStock(Object name) {
    return '$name is out of stock';
  }

  @override
  String get orderOutOfStock => 'Out of stock';

  @override
  String get orderSizeHeader => 'SIZE';

  @override
  String get orderRecipe => 'Recipe';

  @override
  String get orderRecipeRetry => 'Recipe · Retry';

  @override
  String get orderUpdateItem => 'Update Item';

  @override
  String get orderAddToCart => 'Add to Cart';

  @override
  String orderSelectOptions(Object name) {
    return 'Select $name';
  }

  @override
  String get orderRequiredOptions => 'required options';

  @override
  String get orderOptionalHeader => 'OPTIONAL';

  @override
  String get orderRequiredChip => 'Required';

  @override
  String orderMaxSelections(int max) {
    return 'Max $max';
  }

  @override
  String orderMaxHint(int max, Object title) {
    return 'Maximum $max selections for $title';
  }

  @override
  String get orderSearchOptions => 'Search options…';

  @override
  String orderNoMatchFor(Object query) {
    return 'No match for \"$query\"';
  }

  @override
  String orderRecipeSizeLabel(Object size) {
    return 'Size: $size';
  }

  @override
  String get orderRecipeLoadError =>
      'Could not load the recipe. Check your connection and try again.';

  @override
  String get orderNoIngredients => 'No ingredients mapped';

  @override
  String get orderNoRecipeYet => 'This item has no recipe composition yet.';

  @override
  String orderConfiguredProgress(int done, int total) {
    return '$done of $total configured';
  }

  @override
  String get orderReady => 'Ready';

  @override
  String get orderDefaultOptions => 'Default options';

  @override
  String get orderConfigure => 'Configure';

  @override
  String orderConfigureItem(Object name) {
    return 'Configure $name';
  }

  @override
  String get orderConfigureItems => 'Configure items';

  @override
  String get orderItemUnavailable => 'Item unavailable';

  @override
  String get orderItemFallback => 'Item';

  @override
  String get orderTapToChooseOptions => 'Tap to choose options';

  @override
  String get orderNoOptionsToConfigure => 'No options to configure';

  @override
  String get orderHistoryTitle => 'Orders';

  @override
  String get orderCurrentShift => 'Current shift';

  @override
  String get orderFilterAll => 'All';

  @override
  String get orderFilterSynced => 'Synced';

  @override
  String get orderNoOrdersYet => 'No orders yet';

  @override
  String get orderOrdersAppearHere =>
      'Orders completed during this shift will appear here.';

  @override
  String get orderOpenShiftToSell =>
      'Open a shift to start selling — its orders will appear here.';

  @override
  String get orderNothingHere => 'Nothing here';

  @override
  String orderNoFilterMatch(Object filter) {
    return 'No orders match the \"$filter\" filter.';
  }

  @override
  String get orderStatOrders => 'Orders';

  @override
  String get orderMixed => 'Mixed';

  @override
  String get orderColTime => 'Time';

  @override
  String get orderColAmount => 'Amount';

  @override
  String get orderNoItemDetails => 'No item details available';

  @override
  String get orderTax14 => 'Tax (14%)';

  @override
  String get orderVoid => 'Void';

  @override
  String get orderIngredients => 'Ingredients';

  @override
  String get orderIngredientUse => 'Ingredient Use';

  @override
  String get orderNoDeductions => 'No deductions recorded';

  @override
  String get orderNoDeductionsBody =>
      'This order line has no ingredient deductions.';

  @override
  String get orderSourceBase => 'Base';

  @override
  String get orderSourceComboItem => 'Combo item';

  @override
  String get orderSourceAddon => 'Addon';

  @override
  String orderVoidTitle(int number) {
    return 'Void Order #$number';
  }

  @override
  String get orderVoidCannotUndo => 'This action cannot be undone';

  @override
  String get orderVoidOfflineQueued =>
      'Offline — void will be queued and applied when reconnected';

  @override
  String get orderVoidReasonHeader => 'Reason';

  @override
  String get orderVoidReasonCustomerRequest => 'Customer request';

  @override
  String get orderVoidReasonWrongOrder => 'Wrong order';

  @override
  String get orderVoidReasonQualityIssue => 'Quality issue';

  @override
  String get orderVoidReasonOther => 'Other';

  @override
  String get orderVoidSelectReason => 'Please select a reason';

  @override
  String get orderVoidSpecifyReason => 'Please specify the other reason';

  @override
  String get orderVoidDescribeHint => 'Describe the reason…';

  @override
  String orderVoidConfirmTitle(int number) {
    return 'Void order #$number?';
  }

  @override
  String get orderVoidConfirmBodyOnline =>
      'This permanently voids the order and cannot be undone.';

  @override
  String get orderVoidConfirmBodyOffline =>
      'You are offline — the void will be queued and applied when you reconnect.';

  @override
  String get orderVoidConfirmAction => 'Void order';

  @override
  String get orderVoidRestoreTitle => 'Return items to inventory';

  @override
  String get orderVoidRestoreBody => 'Ingredients go back into stock';

  @override
  String get orderVoidAction => 'Void Order';

  @override
  String get orderQueueVoid => 'Queue Void';

  @override
  String get orderPlaced => 'Order Placed!';

  @override
  String get orderQueuedSyncs => 'Queued — syncs automatically';

  @override
  String orderNumber(int number) {
    return 'Order #$number';
  }

  @override
  String get orderReceiptTip => 'Tip';

  @override
  String get orderReceiptCustomer => 'Customer';

  @override
  String get orderReceiptTime => 'Time';

  @override
  String get orderChangeGiven => 'Change Given';

  @override
  String get orderNewOrder => 'New Order';

  @override
  String get orderPrintingReceipt => 'Printing receipt…';

  @override
  String get orderReceiptFailed => 'Receipt didn\'t print';

  @override
  String get orderReceiptPrinted => 'Receipt printed';

  @override
  String get orderReprint => 'Reprint';

  @override
  String get orderReceiptPreview => 'Receipt Preview';

  @override
  String get orderDraftReceiptPreview => 'Draft Receipt Preview';

  @override
  String get orderReceiptPrintedOk => 'Receipt printed successfully';

  @override
  String get checkoutDiscountOptional => 'DISCOUNT (OPTIONAL)';

  @override
  String get checkoutCustomerOptional => 'CUSTOMER NAME (OPTIONAL)';

  @override
  String get checkoutNameHint => 'e.g. Ahmed';

  @override
  String get checkoutPaymentHeader => 'PAYMENT';

  @override
  String get checkoutSplitPayment => 'Split payment';

  @override
  String get checkoutLoadingMethods => 'Loading payment methods…';

  @override
  String get checkoutNoMethodsConfigured =>
      'No payment methods are configured for this organization. Add them from the dashboard, then try again.';

  @override
  String get checkoutMethodsLoadFailed => 'Couldn\'t load payment methods';

  @override
  String get checkoutMethodsNeeded =>
      'Orders need a payment method — check your connection and retry.';

  @override
  String get checkoutPreview => 'Preview';

  @override
  String get checkoutSelectMethod => 'Select a payment method';

  @override
  String get checkoutNoDiscount => 'None';

  @override
  String get checkoutTipOptional => 'TIP (OPTIONAL)';

  @override
  String get checkoutTipAmount => 'Tip amount';

  @override
  String get checkoutCashTendered => 'Cash tendered';

  @override
  String get checkoutExact => 'Exact';

  @override
  String get checkoutChangeDue => 'Change due';

  @override
  String get checkoutShortBy => 'Short by';

  @override
  String get checkoutSelectSplitMethods =>
      'Select the methods the customer is paying with.';

  @override
  String checkoutRemaining(Object amount) {
    return '$amount remaining';
  }

  @override
  String checkoutOver(Object amount) {
    return '$amount over';
  }

  @override
  String get checkoutBalanced => 'Balanced';

  @override
  String get syncCenterTitle => 'Sync Center';

  @override
  String get syncPausedSubtitle => 'Paused — sign in to resume';

  @override
  String syncOfflineQueued(int count) {
    return 'Offline — $count queued';
  }

  @override
  String get syncSyncing => 'Syncing…';

  @override
  String syncNeedAttention(int count) {
    return '$count need attention';
  }

  @override
  String syncWaitingCount(int count) {
    return '$count waiting to sync';
  }

  @override
  String get syncAllSyncedBody =>
      'Every sale, shift and void on this device has reached the server. Pull down to check again.';

  @override
  String get syncNeedsAttentionHeader => 'NEEDS ATTENTION';

  @override
  String get syncWaitingHeader => 'WAITING TO SYNC';

  @override
  String get syncPausedTitle => 'Session expired — sign in to resume syncing';

  @override
  String syncPausedBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count queued items are safe on this device. Syncing is paused until you sign in again — the app will take you to the sign-in screen when needed, and the queue resumes automatically.',
      one:
          '1 queued item is safe on this device. Syncing is paused until you sign in again — the app will take you to the sign-in screen when needed, and the queue resumes automatically.',
    );
    return '$_temp0';
  }

  @override
  String syncOfflineBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count items queued. Everything keeps working and syncs automatically when you reconnect.',
      one:
          '1 item queued. Everything keeps working and syncs automatically when you reconnect.',
    );
    return '$_temp0';
  }

  @override
  String syncSyncingBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items remaining.',
      one: '1 item remaining.',
    );
    return '$_temp0';
  }

  @override
  String syncStuckTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items need attention',
      one: '1 item needs attention',
    );
    return '$_temp0';
  }

  @override
  String get syncStuckBody =>
      'These stopped syncing after repeated failures. Retry or discard them below.';

  @override
  String get syncWaitingTitle => 'Waiting to sync';

  @override
  String syncWaitingBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items will sync shortly.',
      one: '1 item will sync shortly.',
    );
    return '$_temp0';
  }

  @override
  String syncShiftOpenChip(int count) {
    return '$count shift open';
  }

  @override
  String syncShiftCloseChip(int count) {
    return '$count shift close';
  }

  @override
  String syncVoidsChip(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count voids',
      one: '1 void',
    );
    return '$_temp0';
  }

  @override
  String syncCashChip(int count) {
    return '$count cash';
  }

  @override
  String syncStuckChip(int count) {
    return '$count stuck';
  }

  @override
  String get syncFromAnotherSession => 'From another session';

  @override
  String syncOtherSessionBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items — sync when that user signs in on this device',
      one: '1 item — syncs when that user signs in on this device',
    );
    return '$_temp0';
  }

  @override
  String get syncSyncingChip => 'Syncing';

  @override
  String get syncWalkIn => 'Walk-in';

  @override
  String syncOpeningCashDetail(Object amount) {
    return 'Opening cash $amount';
  }

  @override
  String syncClosingCashDetail(Object amount) {
    return 'Closing cash $amount';
  }

  @override
  String syncReason(Object reason) {
    return 'Reason: $reason';
  }

  @override
  String syncWaitingFor(Object label) {
    return 'Waiting for: $label';
  }

  @override
  String get syncAfterAllOrders => 'Syncs after all orders';

  @override
  String syncFailedAttempts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count failed attempts — will retry automatically',
      one: '1 failed attempt — will retry automatically',
    );
    return '$_temp0';
  }

  @override
  String get syncStoppedAfterFailures => 'Stopped after repeated failures';

  @override
  String syncDiscardConfirmTitle(Object label) {
    return 'Discard this $label?';
  }

  @override
  String get syncDiscardConfirmBody =>
      'It will be permanently removed from the sync queue and will never reach the server.';

  @override
  String get syncTypeOrder => 'Order';

  @override
  String get syncTypeVoidOrder => 'Void Order';

  @override
  String get syncTypeCashMovement => 'Cash Movement';

  @override
  String get syncTypeUnknown => 'Unknown';

  @override
  String get syncPendingOrder => 'Pending Order';

  @override
  String get syncJustNow => 'just now';

  @override
  String syncMinutesAgo(int minutes) {
    return '${minutes}m ago';
  }

  @override
  String syncHoursAgo(int hours) {
    return '${hours}h ago';
  }

  @override
  String syncDaysAgo(int days) {
    return '${days}d ago';
  }

  @override
  String syncSignInToSync(int count) {
    return 'Sign in to sync $count';
  }

  @override
  String syncSyncingCount(int count) {
    return 'Syncing $count…';
  }

  @override
  String get syncOfflineSessionBanner =>
      'Offline session — sales queue on this device. Sign in when online to sync.';

  @override
  String get syncOfflineBanner =>
      'Offline — everything keeps working and syncs when you reconnect.';

  @override
  String syncSessionExpiredBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Session expired — sign in to resume syncing $count queued items.',
      one: 'Session expired — sign in to resume syncing 1 queued item.',
    );
    return '$_temp0';
  }

  @override
  String get settingsVersionCopied => 'Version copied to clipboard';

  @override
  String get settingsSignOutTitle => 'Sign out?';

  @override
  String get settingsSignOutBody =>
      'You will need your name and PIN to sign back in.';

  @override
  String get settingsCloseShiftFirstBody =>
      'Your shift is still open. Close it and count the drawer before signing out.';

  @override
  String get settingsGoCloseShift => 'Go to close shift';

  @override
  String get settingsAccount => 'Account';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsDiagnostics => 'Diagnostics';

  @override
  String get settingsAbout => 'About';

  @override
  String get settingsWarningsLog => 'Warnings log';

  @override
  String get settingsNoWarnings => 'No warnings recorded';

  @override
  String settingsEntriesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count entries',
      one: '1 entry',
    );
    return '$_temp0';
  }

  @override
  String get settingsWarningsBody =>
      'Cache and sync warnings will show up here when they happen.';

  @override
  String get settingsDiagnosticsCopied => 'Diagnostics copied to clipboard';

  @override
  String get setupConnectDevice => 'Connect Device';

  @override
  String get setupConnectSubtitle =>
      'Sign in with your manager account to link this device to your branch.';

  @override
  String get setupEmail => 'Email';

  @override
  String get setupPassword => 'Password';

  @override
  String get setupContinue => 'Continue';

  @override
  String get setupEnterCredentials => 'Enter your email and password';

  @override
  String get setupSelectBranch => 'Select Branch';

  @override
  String get setupSelectBranchSubtitle =>
      'Choose the branch this device will serve.';

  @override
  String get setupNoBranches => 'No active branches found.';

  @override
  String get settingsDeviceSection => 'Device';

  @override
  String get settingsReconfigureDevice => 'Reconfigure Device';

  @override
  String get settingsReconfigureShiftOpen =>
      'Close the current shift before reconfiguring the device.';

  @override
  String get settingsReconfigureTitle => 'Reconfigure Device?';

  @override
  String get settingsReconfigureBody =>
      'This will sign you out and require a manager login to reconnect.';

  @override
  String get settingsReconfigureConfirm => 'Reconfigure';

  @override
  String get receiptOrderLabel => 'Order #';

  @override
  String get receiptDate => 'Date';

  @override
  String get receiptItems => 'ITEMS';

  @override
  String get receiptNoItems => 'No items in cart';

  @override
  String get receiptVoidedStamp => '*** VOIDED ***';

  @override
  String get receiptThankYou => 'Thank you for visiting!';

  @override
  String get receiptDraft => 'DRAFT';
}
