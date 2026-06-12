import 'package:flutter/widgets.dart';

import 'app_localizations.dart';

export 'app_localizations.dart';

/// Shorthand for `AppLocalizations.of(context)`.
///
/// Usage: `Text(l10n(context).orderCheckout)`.
AppLocalizations l10n(BuildContext context) => AppLocalizations.of(context);
