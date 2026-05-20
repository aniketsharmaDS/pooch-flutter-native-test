import 'package:equatable/equatable.dart';

class RegisterUser extends Equatable {
  const RegisterUser({
    required this.name,
    required this.phone,
    required this.role,
    required this.hasInvites,
  });

  final String name;
  final String phone;
  final String role;
  final bool hasInvites;

  @override
  List<Object?> get props => <Object?>[name, phone, role, hasInvites];
}
