import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.isProfileCompleted = false,
    this.isPetOnboarded = false,
    this.isOnboarded = false,
    this.hasBoughtPet = false,
    this.countryCode,
    this.primaryIdentifier,
  });

  final String id;
  final String name;
  final String? email;
  final String? phone;
  final bool isProfileCompleted;
  final bool isPetOnboarded;
  final bool hasBoughtPet;
  final bool isOnboarded;
  final String? countryCode;
  final String? primaryIdentifier;

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    bool? isProfileCompleted,
    bool? isPetOnboarded,
    bool? isOnboarded,
    String? countryCode,
    String? primaryIdentifier,
    bool? hasBoughtPet
  }) {
    return User(
      hasBoughtPet: hasBoughtPet ?? this.hasBoughtPet,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      isProfileCompleted: isProfileCompleted ?? this.isProfileCompleted,
      isPetOnboarded: isPetOnboarded ?? this.isPetOnboarded,
      isOnboarded: isOnboarded ?? this.isOnboarded,
      countryCode: countryCode ?? this.countryCode,
      primaryIdentifier: primaryIdentifier ?? this.primaryIdentifier,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    id,
    name,
    email,
    phone,
    isProfileCompleted,
    isPetOnboarded,
    isOnboarded,
    countryCode,
    primaryIdentifier,
    hasBoughtPet
  ];
}
