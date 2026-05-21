import 'package:poochcare/core/utils/api_response_json_parser.dart';

class ProductDetailModel {
  const ProductDetailModel({
    required this.id,
    required this.price,
    required this.gender,
    required this.currencyCode,
    required this.countryCode,
    required this.productImages,
    required this.tileImage,
    required this.inWishlist,
    required this.inCart,
    required this.tags,
    this.finalDiscountedPrice,
    this.deliveryType,
    this.deliveryDistance,
    this.deliveryMethod,
    this.couponApplied,
    this.couponError,
    this.petDetails,
  });

  final String id;
  final double price;
  final double? finalDiscountedPrice;
  final String currencyCode;
  final String gender;
  final String countryCode;
  final List<String> productImages;
  final List<String> tileImage;
  final bool inWishlist;
  final bool inCart;
  final List<String> tags;
  final String? deliveryType;
  final String? deliveryDistance;
  final String? deliveryMethod;
  final String? couponApplied;
  final String? couponError;
  final PetDetailsInfoModel? petDetails;

  factory ProductDetailModel.fromMap(Map<String, dynamic> map) {
    return ProductDetailModel(
      id: _readString(map['id']),
      price: ApiResponseJsonParser.readDouble(map['price']),
      finalDiscountedPrice: ApiResponseJsonParser.readNullableDouble(
        map['finalDiscountedPrice'] ?? map['final_discounted_price'],
      ),
      gender: _readString(map['gender']),
      currencyCode: _readString(map['currencyCode'] ?? map['currency_code']),
      countryCode: _readString(map['countryCode'] ?? map['country_code']),
      productImages: _readStringList(
        map['productImages'] ?? map['product_images'] ?? map['images'],
      ),

      tileImage: _readStringList(
        map['tileImage'] ?? map['tile_image'] ?? map['thumbnail'],
      ),
      inWishlist: _readBool(map['inWishlist'] ?? map['in_wishlist']),
      inCart: _readBool(map['inCart'] ?? map['in_cart']),
      tags: _readStringList(map['tags']),
      deliveryType: _readNullableString(
        map['deliveryType'] ?? map['delivery_type'],
      ),
      deliveryDistance: _readNullableString(
        map['deliveryDistance'] ?? map['delivery_distance'],
      ),
      deliveryMethod: _readNullableString(
        map['deliveryMethod'] ?? map['delivery_method'],
      ),
      couponApplied: _readNullableString(
        map['couponApplied'] ?? map['coupon_applied'],
      ),
      couponError: _readNullableString(
        map['couponError'] ?? map['coupon_error'],
      ),
      petDetails: _readMap(
        map['petDetails'] ?? map['pet_details'],
      ).map(PetDetailsInfoModel.fromMap),
    );
  }
}

class PetDetailsInfoModel {
  const PetDetailsInfoModel({
    required this.name,
    required this.description,
    required this.temperament,
    required this.size,
    required this.weight,
    required this.weightUnit,
    required this.height,
    required this.heightUnit,
    required this.lifeStage,
    required this.energyLevel,
    required this.groomingNeeds,
    required this.isHypoallergenic,
    required this.isVaccinated,
    required this.gender,
    required this.dateOfBirth,
    required this.bcsScore,
    this.breedInfo,
  });

  final String name;
  final String description;
  final String temperament;
  final String size;
  final String weight;
  final String weightUnit;
  final String height;
  final String heightUnit;
  final String lifeStage;
  final String energyLevel;
  final String groomingNeeds;
  final bool isHypoallergenic;
  final bool isVaccinated;
  final String gender;
  final String dateOfBirth;
  final int bcsScore;
  final BreedInfoModel? breedInfo;

  factory PetDetailsInfoModel.fromMap(Map<String, dynamic> map) {
    final translation = _readTranslations(map['translations']);
    final breedInfoMap = _readMap(map['breedInfo'] ?? map['breed_info']);
    final breedInfo = breedInfoMap.map(BreedInfoModel.fromMap);

    final String name = _firstNonEmpty(<String?>[
      translation?.name,
      _readNullableString(map['name']),
      breedInfo?.breedName,
    ]);

    final String description = _firstNonEmpty(<String?>[
      translation?.description,
      _readNullableString(map['description']),
    ]);

    final String temperament = _firstNonEmpty(<String?>[
      _readNullableString(map['temperament']),
      breedInfo?.temperament,
    ]);

    return PetDetailsInfoModel(
      name: name,
      description: description,
      temperament: temperament,
      size: _readString(map['size']),
      weight: _readString(map['weight']),
      weightUnit: _readString(map['weightUnit'] ?? map['weight_unit']),
      height: _readString(map['height']),
      heightUnit: _readString(map['heightUnit'] ?? map['height_unit']),
      lifeStage: _readString(map['lifeStage'] ?? map['life_stage']),
      energyLevel: _readString(map['energyLevel'] ?? map['energy_level']),
      groomingNeeds: _readString(map['groomingNeeds'] ?? map['grooming_needs']),
      isVaccinated: _readBool(map['isVaccinated'] ?? map['is_vaccinated']),
      isHypoallergenic: _readBool(
        map['isHypoallergenic'] ?? map['is_hypoallergenic'],
      ),
      gender: _readString(map['gender']),
      dateOfBirth: _readString(map['dob'] ?? map['dateOfBirth']),
      bcsScore: _readInt(map['bcsScore'] ?? map['bcs_score']),
      breedInfo: breedInfo,
    );
  }
}

class BreedInfoModel {
  const BreedInfoModel({
    required this.breedName,
    required this.petType,
    required this.sizeCategory,
    required this.temperament,
  });

  final String breedName;
  final String petType;
  final String sizeCategory;
  final String temperament;

  factory BreedInfoModel.fromMap(Map<String, dynamic> map) {
    return BreedInfoModel(
      breedName: _readString(map['breedName'] ?? map['breed_name']),
      petType: _readString(map['petType'] ?? map['pet_type']),
      sizeCategory: _readString(map['sizeCategory'] ?? map['size_category']),
      temperament: _readString(map['temperament']),
    );
  }
}

class _TranslationInfo {
  final String name;
  final String description;
  const _TranslationInfo({required this.name, required this.description});
}

_TranslationInfo? _readTranslations(dynamic value) {
  if (value is! List || value.isEmpty) return null;
  final first = value.first;
  if (first is! Map) return null;
  final map = _asMap(first);
  if (map == null) return null;
  return _TranslationInfo(
    name: _readString(map['name'] ?? map['breedName'] ?? map['breed_name']),
    description: _readString(map['description']),
  );
}

String _firstNonEmpty(List<String?> values) {
  for (final value in values) {
    final v = value?.trim() ?? '';
    if (v.isNotEmpty) return v;
  }
  return '';
}

String _readString(dynamic value) {
  if (value is String) return value;
  if (value == null) return '';
  return value.toString();
}

String? _readNullableString(dynamic value) {
  if (value == null) return null;
  final text = _readString(value);
  return text.trim().isEmpty ? null : text;
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
        .map((e) => _readString(e))
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

  T? map<T>(T Function(Map<String, dynamic>) mapper) {
    final v = _value;
    if (v == null) return null;
    return mapper(v);
  }
}
