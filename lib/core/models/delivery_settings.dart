/// Branch delivery configuration as returned by `GET /delivery/settings` and
/// `POST /delivery/accepting`.
///
/// Ownership split (mirrors the backend): the **dashboard/manager** owns the
/// `*_enabled` master switches, daily windows, and fees; the **POS/teller**
/// owns only the `*_override` accepting toggle (`auto` | `open` | `closed`),
/// set via `POST /delivery/accepting`. The POS can never re-open a channel the
/// dashboard has disabled (`*_enabled == false`) — the backend rejects it, and
/// the UI hides the control for those channels.
///
/// Hand-written + tolerant (like [DeliveryOrder]) so a slightly older/newer
/// wire shape never hard-fails the teller's queue.
class DeliverySettings {
  final String branchId;
  final bool inMallEnabled;
  final bool outsideEnabled;

  /// `auto` | `open` | `closed` — the POS-owned accepting override per channel.
  final String inMallOverride;
  final String outsideOverride;

  final int inMallFee; // piastres
  final int prepTimeMinutes;

  const DeliverySettings({
    required this.branchId,
    this.inMallEnabled = false,
    this.outsideEnabled = false,
    this.inMallOverride = 'auto',
    this.outsideOverride = 'auto',
    this.inMallFee = 0,
    this.prepTimeMinutes = 0,
  });

  /// Is the channel enabled at all by management? (`channel` = `in_mall`/`outside`.)
  bool enabledFor(String channel) =>
      channel == 'outside' ? outsideEnabled : inMallEnabled;

  /// Current accepting override for the channel (`auto` | `open` | `closed`).
  String overrideFor(String channel) =>
      channel == 'outside' ? outsideOverride : inMallOverride;

  /// At least one delivery channel is enabled by management.
  bool get anyEnabled => inMallEnabled || outsideEnabled;

  factory DeliverySettings.fromJson(Map<String, dynamic> j) => DeliverySettings(
        branchId: j['branch_id'] as String? ?? '',
        inMallEnabled: j['in_mall_enabled'] as bool? ?? false,
        outsideEnabled: j['outside_enabled'] as bool? ?? false,
        inMallOverride: j['in_mall_override'] as String? ?? 'auto',
        outsideOverride: j['outside_override'] as String? ?? 'auto',
        inMallFee: (j['in_mall_fee'] as num?)?.toInt() ?? 0,
        prepTimeMinutes: (j['prep_time_minutes'] as num?)?.toInt() ?? 0,
      );
}
