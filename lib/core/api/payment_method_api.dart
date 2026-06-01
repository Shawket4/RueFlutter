import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/payment_method.dart';
import 'client.dart';

class PaymentMethodApi {
  final DioClient _c;
  PaymentMethodApi(this._c);

  Future<List<PaymentMethod>> list(String orgId) async {
    // The backend endpoint GET /payment-methods automatically infers orgId from token claims
    final res = await _c.dio.get('/payment-methods');
    return (res.data as List).map((d) => PaymentMethod.fromJson(d)).toList();
  }
}

final paymentMethodApiProvider = Provider<PaymentMethodApi>(
    (ref) => PaymentMethodApi(ref.watch(dioClientProvider)));
