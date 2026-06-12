import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/user.dart';

import '../../helpers/model_fixtures.dart';

void main() {
  group('User', () {
    test('fromJson parses correctly', () {
      final json = {
        'id': 'u1',
        'org_id': 'org1',
        'branch_id': 'b1',
        'name': 'John Doe',
        'email': 'john@example.com',
        'role': 'org_admin',
        'is_active': true,
      };

      final user = User.fromJson(json);

      expect(user.id, 'u1');
      expect(user.orgId, 'org1');
      expect(user.branchId, 'b1');
      expect(user.name, 'John Doe');
      expect(user.email, 'john@example.com');
      expect(user.role, UserRole.orgAdmin);
      expect(user.role.value, 'org_admin');
      expect(user.isActive, true);
    });

    test('unknown role falls back instead of crashing', () {
      final json = {
        'id': 'u1',
        'name': 'John Doe',
        'role': 'galactic_overlord',
        'is_active': true,
      };
      expect(User.fromJson(json).role, UserRole.unknownDefaultOpenApi);
    });

    test('toJson keeps wire key names', () {
      final user = makeUser(
        id: 'u1',
        orgId: 'org1',
        branchId: null,
        name: 'John Doe',
        role: UserRole.teller,
        isActive: false,
      );

      final json = user.toJson();

      expect(json['id'], 'u1');
      expect(json['org_id'], 'org1');
      expect(json['name'], 'John Doe');
      expect(json['role'], 'teller');
      expect(json['is_active'], false);
    });
  });
}
