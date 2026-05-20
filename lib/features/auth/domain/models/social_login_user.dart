import 'package:equatable/equatable.dart';

class SocialLoginUser extends Equatable {
  const SocialLoginUser({
    required this.id,
    required this.provider,
    required this.isActive,
    required this.isDeleted,
    required this.isOnboarded,
    required this.isProfileCompleted,
    required this.isPetOnboarded,
    required this.points,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.email,
    required this.primaryIdentifier,
    required this.isSocialLogin,
    required this.role,
    required this.isVerified,
    required this.updatedAtLegacy,
    required this.createdAtLegacy,
  });

  final String id;
  final String provider;
  final bool isActive;
  final bool isDeleted;
  final bool isOnboarded;
  final bool isProfileCompleted;
  final bool isPetOnboarded;
  final int points;
  final String createdAt;
  final String updatedAt;
  final String name;
  final String email;
  final String primaryIdentifier;
  final bool isSocialLogin;
  final String role;
  final bool isVerified;
  final String updatedAtLegacy;
  final String createdAtLegacy;

  @override
  List<Object?> get props => <Object?>[
    id,
    provider,
    isActive,
    isDeleted,
    isOnboarded,
    isProfileCompleted,
    isPetOnboarded,
    points,
    createdAt,
    updatedAt,
    name,
    email,
    primaryIdentifier,
    isSocialLogin,
    role,
    isVerified,
    updatedAtLegacy,
    createdAtLegacy,
  ];
}
