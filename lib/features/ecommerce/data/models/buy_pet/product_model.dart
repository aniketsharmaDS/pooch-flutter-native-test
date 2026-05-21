import 'package:poochcare/core/utils/api_response_json_parser.dart';

class ProductModel {
  final String id;
  final String name;
  final double price;
  final double? finalDiscountedPrice;
  final bool inWishlist;
  final List<String> productImages;
  final List<String> tileImage;
  final PetDetailsModel? petDetails;

  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    this.finalDiscountedPrice,
    this.inWishlist = false,
    this.productImages = const <String>[],
    this.tileImage = const <String>[],
    this.petDetails,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: _readString(map['id']),
      name: _readString(map['name']),
      price: ApiResponseJsonParser.readDouble(map['price']),
      finalDiscountedPrice: ApiResponseJsonParser.readNullableDouble(
        map['finalDiscountedPrice'] ?? map['final_discounted_price'],
      ),
      inWishlist: _readBool(map['inWishlist'] ?? map['in_wishlist']),
      productImages: _readStringList(
        map['productImages'] ?? map['product_images'] ?? map['images'],
      ),
      tileImage: _readStringList(map['tileImage'] ?? map['tile_image']),
      petDetails: _readMap(
        map['petDetails'] ?? map['pet_details'],
      ).map(PetDetailsModel.fromMap),
    );
  }
}

class PetDetailsModel {
  final String breedName;
  final String age;
  final String? gender;
  final bool isVaccinated;

  const PetDetailsModel({
    required this.breedName,
    required this.age,
    this.gender,
    required this.isVaccinated,
  });

  factory PetDetailsModel.fromMap(Map<String, dynamic> map) {
    // Try to get breed name from nested breedInfo, then translations, then top-level fields
    String breedName = '';

    final breedInfoMap = _readMap(map['breedInfo']).orNull;
    if (breedInfoMap != null) {
      breedName = _readString(
        breedInfoMap['breedName'] ?? breedInfoMap['breed_name'],
      );
    }

    if (breedName.trim().isEmpty) {
      final translations = map['translations'] as List?;
      if (translations != null && translations.isNotEmpty) {
        final firstTranslation = translations.first;
        if (firstTranslation is Map) {
          breedName = _readString(firstTranslation['name']);
        }
      }
    }

    if (breedName.trim().isEmpty) {
      breedName = _readString(
        map['name'] ?? map['breedName'] ?? map['breed_name'],
      );
    }

    // Try to get age from ageDisplay (formatted), then ageInMonths, then age field
    String age = _readString(map['ageDisplay'] ?? map['age_display']);
    if (age.trim().isEmpty) {
      final ageInMonths = _readInt(map['ageInMonths'] ?? map['age_in_months']);
      if (ageInMonths > 0) {
        age = ageInMonths == 1 ? '1 month' : '$ageInMonths months';
      }
    }
    if (age.trim().isEmpty) {
      age = _readString(map['age']);
    }

    final isVaccinated = _readBool(map['isVaccinated'] ?? map['is_vaccinated']);

    return PetDetailsModel(
      breedName: breedName,
      age: age,
      gender: _readString(map['gender']),
      isVaccinated: isVaccinated,
    );
  }
}

String _readString(dynamic value) {
  if (value is String) return value;
  if (value == null) return '';
  return value.toString();
}

int _readInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value.trim()) ?? 0;
  return 0;
}

bool _readBool(dynamic value) {
  if (value is bool) return value;
  if (value is num) return value != 0;
  if (value is String) {
    final v = value.trim().toLowerCase();
    if (v == 'true' || v == '1' || v == 'yes') return true;
    if (v == 'false' || v == '0' || v == 'no') return false;
  }
  return false;
}

List<String> _readStringList(dynamic value) {
  if (value is List) {
    return value
        .map((e) {
          if (e is String) return e;
          if (e is Map) {
            final url = e['url'] ?? e['imageUrl'] ?? e['image_url'];
            return url is String ? url : '';
          }
          return '';
        })
        .where((e) => e.trim().isNotEmpty)
        .toList(growable: false);
  }
  return const <String>[];
}

Map<String, dynamic>? _asMap(dynamic value) {
  if (value is Map<String, dynamic>) return value;
  if (value is Map) {
    return value.map((key, value) => MapEntry(key.toString(), value));
  }
  return null;
}

_OptionalMap _readMap(dynamic value) => _OptionalMap(_asMap(value));

class _OptionalMap {
  final Map<String, dynamic>? _value;
  const _OptionalMap(this._value);

  bool get isPresent => _value != null;

  T? map<T>(T Function(Map<String, dynamic>) mapper) {
    final v = _value;
    if (v == null) return null;
    return mapper(v);
  }

  Map<String, dynamic>? get orNull => _value;
}
