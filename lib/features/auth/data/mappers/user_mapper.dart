import 'package:poochcare/features/auth/data/models/user_response.dart';
import 'package:poochcare/features/auth/domain/models/user.dart';

class UserMapper {
  const UserMapper._();

  static User toDomain(UserResponse response) =>
      User(id: response.id, name: response.name, email: response.email);
}
