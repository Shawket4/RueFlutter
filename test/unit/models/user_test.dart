import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/user.dart';

void main() {
  group('User', () {
    test('fromJson parses correctly', () {
      final json = {
        'id': 'u1',
        'org_id': 'org1',
        'branch_id': 'b1',
        'name': 'John Doe',
        'email': 'john@example.com',
        'role': 'admin',
        'is_active': true,
      };

      final user = User.fromJson(json);

      expect(user.id, 'u1');
      expect(user.orgId, 'org1');
      expect(user.branchId, 'b1');
      expect(user.name, 'John Doe');
      expect(user.email, 'john@example.com');
      expect(user.role, 'admin');
      expect(user.isActive, true);
    });

    test('toJson serializes correctly', () {
      const user = User(
        id: 'u1',
        orgId: 'org1',
        name: 'John Doe',
        role: 'teller',
        isActive: false,
      );

      final json = user.toJson();

      expect(json['id'], 'u1');
      expect(json['org_id'], 'org1');
      expect(json['branch_id'], null);
      expect(json['name'], 'John Doe');
      expect(json['email'], null);
      expect(json['role'], 'teller');
      expect(json['is_active'], false);
    });
  });
}
