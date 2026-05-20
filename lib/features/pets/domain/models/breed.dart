import 'package:equatable/equatable.dart';

class Breed extends Equatable {
  const Breed({
    required this.id,
    required this.petType,
    required this.name,
    this.sizeCategory,
  });

  final String id;
  final String petType;
  final String name;
  final String? sizeCategory;

  static Breed fromMap(Map<String, dynamic> map, {String languageCode = 'en'}) {
    final String id = (map['id'] as String?) ?? '';
    final String petType = (map['petType'] as String?) ?? '';
    final String? sizeCategory = (map['sizeCategory'] as String?);

    String name = (map['breedName'] as String?) ?? '';

    final dynamic translationsRaw = map['translations'];
    if (translationsRaw is List) {
      for (final dynamic item in translationsRaw) {
        if (item is! Map<String, dynamic>) continue;
        final String? lc = item['languageCode'] as String?;
        if (lc == languageCode) {
          final String? translatedName = item['breedName'] as String?;
          if (translatedName != null && translatedName.isNotEmpty) {
            name = translatedName;
          }
          break;
        }
      }
    }

    return Breed(
      id: id,
      petType: petType,
      name: name,
      sizeCategory: sizeCategory,
    );
  }

  @override
  List<Object?> get props => <Object?>[id, petType, name, sizeCategory];
}
