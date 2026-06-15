import 'package:url_launcher/url_launcher.dart';

/// Open Google Maps centred on a coordinate — the installed Maps app on mobile,
/// otherwise the browser. Returns false if nothing could handle it.
Future<bool> openInMaps(double lat, double lng) {
  final uri = Uri.parse(
    'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
  );
  return launchUrl(uri, mode: LaunchMode.externalApplication);
}

/// Start a phone call to [phone] via the device dialer. Strips formatting to a
/// dialable `tel:` number.
Future<bool> dialPhone(String phone) {
  final digits = phone.replaceAll(RegExp(r'[^0-9+]'), '');
  return launchUrl(Uri(scheme: 'tel', path: digits));
}
