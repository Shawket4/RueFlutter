// Façade over the OpenAPI-generated wire models (packages/sufrix_api).
// The app's `User` is the spec's `UserPublic` (auth/me + login payloads).
import 'package:sufrix_api/sufrix_api.dart';

export 'package:sufrix_api/sufrix_api.dart' show UserPublic, UserRole;

typedef User = UserPublic;
