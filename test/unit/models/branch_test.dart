import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/branch.dart';

void main() {
  group('Branch Model', () {
    test('fromJson parses correctly', () {
      final json = {
        'id': 'b1',
        'org_id': 'org1',
        'name': 'Branch 1',
        'address': '123 St',
        'phone': '123456',
        'printer_brand': 'star',
        'printer_ip': '192.168.1.100',
        'printer_port': 9100,
        'is_active': true,
        'org_logo_url': 'http://logo.png',
      };

      final branch = Branch.fromJson(json);

      expect(branch.id, 'b1');
      expect(branch.orgId, 'org1');
      expect(branch.name, 'Branch 1');
      expect(branch.address, '123 St');
      expect(branch.phone, '123456');
      expect(branch.printerBrand, PrinterBrand.star);
      expect(branch.printerIp, '192.168.1.100');
      expect(branch.printerPort, 9100);
      expect(branch.isActive, true);
      expect(branch.orgLogoUrl, 'http://logo.png');
      expect(branch.hasPrinter, true);
    });

    test('toJson serializes correctly', () {
      const branch = Branch(
        id: 'b1',
        orgId: 'org1',
        name: 'Branch 1',
        isActive: true,
        printerBrand: PrinterBrand.epson,
        printerIp: '10.0.0.1',
      );

      final json = branch.toJson();

      expect(json['id'], 'b1');
      expect(json['org_id'], 'org1');
      expect(json['name'], 'Branch 1');
      expect(json['is_active'], true);
      expect(json['printer_brand'], 'epson');
      expect(json['printer_ip'], '10.0.0.1');
      expect(json['printer_port'], 9100);
    });

    test('hasPrinter returns false if ip is missing', () {
      const branch = Branch(
        id: 'b1',
        orgId: 'org1',
        name: 'Branch 1',
        isActive: true,
        printerBrand: PrinterBrand.epson,
      );
      expect(branch.hasPrinter, false);
    });

    test('hasPrinter returns false if brand is missing', () {
      const branch = Branch(
        id: 'b1',
        orgId: 'org1',
        name: 'Branch 1',
        isActive: true,
        printerIp: '192.168.1.10',
      );
      expect(branch.hasPrinter, false);
    });
  });
}
