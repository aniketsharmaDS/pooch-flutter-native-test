import 'package:equatable/equatable.dart';

class Pet extends Equatable {
  const Pet({required this.id, required this.name, required this.breed});

  final String id;
  final String name;
  final String breed;

  Pet copyWith({String? id, String? name, String? breed}) {
    return Pet(
      id: id ?? this.id,
      name: name ?? this.name,
      breed: breed ?? this.breed,
    );
  }

  @override
  List<Object?> get props => <Object?>[id, name, breed];
}
