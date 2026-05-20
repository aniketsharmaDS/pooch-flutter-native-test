import 'package:equatable/equatable.dart';

class OtpVerificationUser extends Equatable {
  const OtpVerificationUser({
    required this.id,
    required this.provider,
    required this.providerId,
    required this.isSocialLogin,
    required this.isActive,
    required this.isDeleted,
    required this.deletedBy,
    required this.deletedAt,
    required this.deletionReason,
    required this.isOnboarded,
    required this.isProfileCompleted,
    required this.isPetOnboarded,
    required this.points,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.phone,
    required this.countryCode,
    required this.country,
    required this.role,
    required this.primaryIdentifier,
    required this.isVerified,
    required this.hasInvites,
    required this.updatedAtLegacy,
    required this.createdAtLegacy,
    required this.email,
  });

  final String id;
  final String provider;
  final String providerId;
  final bool isSocialLogin;
  final bool isActive;
  final bool isDeleted;
  final String deletedBy;
  final String deletedAt;
  final String deletionReason;
  final bool isOnboarded;
  final bool isProfileCompleted;
  final bool isPetOnboarded;
  final int points;
  final String createdAt;
  final String updatedAt;
  final String name;
  final String phone;
  final String countryCode;
  final String country;
  final String role;
  final String primaryIdentifier;
  final bool isVerified;
  final bool hasInvites;
  final String updatedAtLegacy;
  final String createdAtLegacy;
  final String email;

  @override
  List<Object?> get props => <Object?>[
    id,
    provider,
    providerId,
    isSocialLogin,
    isActive,
    isDeleted,
    deletedBy,
    deletedAt,
    deletionReason,
    isOnboarded,
    isProfileCompleted,
    isPetOnboarded,
    points,
    createdAt,
    updatedAt,
    name,
    phone,
    countryCode,
    country,
    role,
    primaryIdentifier,
    isVerified,
    hasInvites,
    updatedAtLegacy,
    createdAtLegacy,
    email,
  ];
}
