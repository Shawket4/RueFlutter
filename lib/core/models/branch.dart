enum PrinterBrand { star, epson }

class Branch {
  final String        id;
  final String        orgId;
  final String        name;
  final String?       address;
  final String?       phone;
  final PrinterBrand? printerBrand;
  final String?       printerIp;
  final int           printerPort;
  final bool          isActive;
  final String?       orgLogoUrl;

  const Branch({
    required this.id,
    required this.orgId,
    required this.name,
    this.address,
    this.phone,
    this.printerBrand,
    this.printerIp,
    this.printerPort = 9100,
    required this.isActive,
    this.orgLogoUrl,
  });

  bool get hasPrinter =>
      printerIp != null && printerIp!.trim().isNotEmpty && printerBrand != null;

  factory Branch.fromJson(Map<String, dynamic> j) => Branch(
    id:           j['id']           as String,
    orgId:        j['org_id']       as String,
    name:         j['name']         as String,
    address:      j['address']      as String?,
    phone:        j['phone']        as String?,
    printerBrand: j['printer_brand'] == null
        ? null
        : PrinterBrand.values.byName(j['printer_brand'] as String),
    printerIp:    j['printer_ip']   as String?,
    printerPort:  (j['printer_port'] as int?) ?? 9100,
    isActive:     (j['is_active']   as bool?) ?? true,
    orgLogoUrl:   (j['org_logo_url'] ?? j['org_url'] ?? j['logo_url']) as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id, 'org_id': orgId, 'name': name, 'address': address,
    'phone': phone, 'printer_brand': printerBrand?.name,
    'printer_ip': printerIp, 'printer_port': printerPort,
    'is_active': isActive, 'org_logo_url': orgLogoUrl,
  };
}

