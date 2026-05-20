import 'package:equatable/equatable.dart';
import 'package:poochcare/core/utils/date_time_formattter.dart';
import 'package:poochcare/core/utils/parser_utils.dart';

class OrderPreviewModel extends Equatable {
  final String type;
  final List<OrderPreviewItemModel> items;
  final int itemCount;
  final OrderPreviewPricingModel pricing;
  final OrderPreviewAddressModel? shippingAddress;
  final OrderPreviewCouponModel? appliedCoupon;

  const OrderPreviewModel({
    required this.type,
    required this.items,
    required this.itemCount,
    required this.pricing,
    this.shippingAddress,
    this.appliedCoupon,
  });

  factory OrderPreviewModel.fromMap(Map<String, dynamic> map) {
    return OrderPreviewModel(
      type: ParserUtils.readString(map['type']),
      items: (map['items'] as List? ?? [])
          .map((e) => OrderPreviewItemModel.fromMap(ParserUtils.readMap(e)))
          .toList(),
      itemCount: ParserUtils.readInt(map['itemCount']),
      pricing: OrderPreviewPricingModel.fromMap(
        ParserUtils.readMap(map['pricing']),
      ),
      shippingAddress: map['shippingAddress'] != null
          ? OrderPreviewAddressModel.fromMap(
              ParserUtils.readMap(map['shippingAddress']),
            )
          : null,
      appliedCoupon: map['appliedCoupon'] != null
          ? OrderPreviewCouponModel.fromMap(
              ParserUtils.readMap(map['appliedCoupon']),
            )
          : null,
    );
  }

  @override
  List<Object?> get props => [
    type,
    items,
    itemCount,
    pricing,
    shippingAddress,
    appliedCoupon,
  ];
}

class OrderPreviewItemModel extends Equatable {
  final String productId;
  final String productName;
  final String productType;
  final String price;
  final String currencyCode;
  final String countryCode;
  final int quantity;
  final double itemTotal;
  final PetDetailsModel? petDetails;
  final List<String>? productImages;

  const OrderPreviewItemModel({
    this.productImages,
    required this.productId,
    required this.productName,
    required this.productType,
    required this.price,
    required this.currencyCode,
    required this.countryCode,
    required this.quantity,
    required this.itemTotal,
    this.petDetails,
  });

  factory OrderPreviewItemModel.fromMap(Map<String, dynamic> map) {
    return OrderPreviewItemModel(
      productImages: ParserUtils.readStringList(map['productImages']),
      productId: ParserUtils.readString(map['productId']),
      productName: ParserUtils.readString(map['productName']),
      productType: ParserUtils.readString(map['productType']),
      price: ParserUtils.readString(map['price']),
      currencyCode: ParserUtils.readString(map['currencyCode']),
      countryCode: ParserUtils.readString(map['countryCode']),
      quantity: ParserUtils.readInt(map['quantity']),
      itemTotal: ParserUtils.readDouble(map['itemTotal']),
      petDetails: map['petDetails'] != null
          ? PetDetailsModel.fromMap(ParserUtils.readMap(map['petDetails']))
          : null,
    );
  }

  @override
  List<Object?> get props => [
    productId,
    productName,
    productType,
    price,
    currencyCode,
    countryCode,
    quantity,
    itemTotal,
    petDetails,
    productImages,
  ];
}

class OrderPreviewPricingModel extends Equatable {
  final double basePrice;
  final double subtotal;
  final double taxAmount;
  final String taxRate;
  final double deliveryCharge;
  final String deliveryChargeRate;
  final double discountAmount;
  final String discountType;
  final double totalAmount;

  const OrderPreviewPricingModel({
    required this.basePrice,
    required this.subtotal,
    required this.taxAmount,
    required this.taxRate,
    required this.deliveryCharge,
    required this.deliveryChargeRate,
    required this.discountAmount,
    required this.discountType,
    required this.totalAmount,
  });

  factory OrderPreviewPricingModel.fromMap(Map<String, dynamic> map) {
    return OrderPreviewPricingModel(
      basePrice: ParserUtils.readDouble(map['basePrice']),
      subtotal: ParserUtils.readDouble(map['subtotal']),
      taxAmount: ParserUtils.readDouble(map['taxAmount']),
      taxRate: ParserUtils.readString(map['taxRate']),
      deliveryCharge: ParserUtils.readDouble(map['deliveryCharge']),
      deliveryChargeRate: ParserUtils.readString(map['deliveryChargeRate']),
      discountAmount: ParserUtils.readDouble(map['discountAmount']),
      discountType: ParserUtils.readString(map['discountType']),
      totalAmount: ParserUtils.readDouble(map['totalAmount']),
    );
  }

  @override
  List<Object?> get props => [
    basePrice,
    subtotal,
    taxAmount,
    taxRate,
    deliveryCharge,
    deliveryChargeRate,
    discountAmount,
    discountType,
    totalAmount,
  ];
}

class OrderPreviewAddressModel extends Equatable {
  final String id;
  final String addressLine;
  final String city;
  final String emirate;
  final String country;
  final bool isPrimary;

  const OrderPreviewAddressModel({
    required this.id,
    required this.addressLine,
    required this.city,
    required this.emirate,
    required this.country,
    required this.isPrimary,
  });

  factory OrderPreviewAddressModel.fromMap(Map<String, dynamic> map) {
    return OrderPreviewAddressModel(
      id: ParserUtils.readString(map['id']),
      addressLine: ParserUtils.readString(map['addressLine']),
      city: ParserUtils.readString(map['city']),
      emirate: ParserUtils.readString(map['emirate']),
      country: ParserUtils.readString(map['country']),
      isPrimary: ParserUtils.readBool(map['isPrimary']),
    );
  }

  @override
  List<Object?> get props => [
    id,
    addressLine,
    city,
    emirate,
    country,
    isPrimary,
  ];
}

class OrderPreviewCouponModel extends Equatable {
  final String code;
  final bool applied;
  final String? error;
  final String discountType;

  const OrderPreviewCouponModel({
    required this.code,
    required this.applied,
    this.error,
    required this.discountType,
  });

  factory OrderPreviewCouponModel.fromMap(Map<String, dynamic> map) {
    return OrderPreviewCouponModel(
      code: ParserUtils.readString(map['code']),
      applied: ParserUtils.readBool(map['applied']),
      error: ParserUtils.readNullableString(map['error']),
      discountType: ParserUtils.readString(map['discountType']),
    );
  }

  @override
  List<Object?> get props => [code, applied, error, discountType];
}

class PetDetailsModel extends Equatable {
  final String id;
  final String gender;
  final String breedId;
  final String dob;
  final String size;
  final String weight;
  final String height;
  final String heightUnit;
  final String weightUnit;
  final String priceUnit;
  final int bcsScore;
  final String lifeStage;
  final String energyLevel;
  final String groomingNeeds;
  final String temperament;
  final bool isHypoallergenic;
  final bool isVaccinated;
  final String? allergies;
  final String createdAt;
  final String updatedAt;
  final List<PetTranslationModel> translations;
  final BreedInfoModel? breedInfo;
  String get ageDisplay {
    final age = formatPetAge(dob: DateTime.tryParse(dob), showFullUnit: false);
    return age;
  }

  const PetDetailsModel({
    required this.id,
    required this.gender,
    required this.breedId,
    required this.dob,
    required this.size,
    required this.weight,
    required this.height,
    required this.heightUnit,
    required this.weightUnit,
    required this.priceUnit,
    required this.bcsScore,
    required this.lifeStage,
    required this.energyLevel,
    required this.groomingNeeds,
    required this.temperament,
    required this.isHypoallergenic,
    required this.isVaccinated,
    this.allergies,
    required this.createdAt,
    required this.updatedAt,
    required this.translations,
    this.breedInfo,
  });

  factory PetDetailsModel.fromMap(Map<String, dynamic> map) {
    return PetDetailsModel(
      id: ParserUtils.readString(map['id']),
      gender: ParserUtils.readString(map['gender']),
      breedId: ParserUtils.readString(map['breedId']),
      dob: ParserUtils.readString(map['dob']),
      size: ParserUtils.readString(map['size']),
      weight: ParserUtils.readString(map['weight']),
      height: ParserUtils.readString(map['height']),
      heightUnit: ParserUtils.readString(map['heightUnit']),
      weightUnit: ParserUtils.readString(map['weightUnit']),
      priceUnit: ParserUtils.readString(map['priceUnit']),
      bcsScore: ParserUtils.readInt(map['bcsScore']),
      lifeStage: ParserUtils.readString(map['lifeStage']),
      energyLevel: ParserUtils.readString(map['energyLevel']),
      groomingNeeds: ParserUtils.readString(map['groomingNeeds']),
      temperament: ParserUtils.readString(map['temperament']),
      isHypoallergenic: ParserUtils.readBool(map['isHypoallergenic']),
      isVaccinated: ParserUtils.readBool(map['isVaccinated']),
      allergies: ParserUtils.readNullableString(map['allergies']),
      createdAt: ParserUtils.readString(map['createdAt']),
      updatedAt: ParserUtils.readString(map['updatedAt']),
      translations: (map['translations'] as List? ?? [])
          .map((e) => PetTranslationModel.fromMap(ParserUtils.readMap(e)))
          .toList(),
      breedInfo: map['breedInfo'] != null
          ? BreedInfoModel.fromMap(ParserUtils.readMap(map['breedInfo']))
          : null,
    );
  }

  @override
  List<Object?> get props => [
    id,
    gender,
    breedId,
    dob,
    size,
    weight,
    height,
    heightUnit,
    weightUnit,
    priceUnit,
    bcsScore,
    lifeStage,
    energyLevel,
    groomingNeeds,
    temperament,
    isHypoallergenic,
    isVaccinated,
    allergies,
    createdAt,
    updatedAt,
    translations,
    breedInfo,
  ];
}

class PetTranslationModel extends Equatable {
  final int translationId;
  final String productId;
  final String langCode;
  final String name;
  final String description;
  final String createdAt;
  final String updatedAt;
  final String productIdField;

  const PetTranslationModel({
    required this.translationId,
    required this.productId,
    required this.langCode,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.productIdField,
  });

  factory PetTranslationModel.fromMap(Map<String, dynamic> map) {
    return PetTranslationModel(
      translationId: ParserUtils.readInt(map['translationId']),
      productId: ParserUtils.readString(map['productId']),
      langCode: ParserUtils.readString(map['langCode']),
      name: ParserUtils.readString(map['name']),
      description: ParserUtils.readString(map['description']),
      createdAt: ParserUtils.readString(map['createdAt']),
      updatedAt: ParserUtils.readString(map['updatedAt']),
      productIdField: ParserUtils.readString(map['product_id']),
    );
  }

  @override
  List<Object?> get props => [
    translationId,
    productId,
    langCode,
    name,
    description,
    createdAt,
    updatedAt,
    productIdField,
  ];
}

class BreedInfoModel extends Equatable {
  final String id;
  final String breedName;
  final String petType;
  final List<BreedTranslationModel> translations;

  const BreedInfoModel({
    required this.id,
    required this.breedName,
    required this.petType,
    required this.translations,
  });

  factory BreedInfoModel.fromMap(Map<String, dynamic> map) {
    return BreedInfoModel(
      id: ParserUtils.readString(map['id']),
      breedName: ParserUtils.readString(map['breedName']),
      petType: ParserUtils.readString(map['petType']),
      translations: (map['translations'] as List? ?? [])
          .map((e) => BreedTranslationModel.fromMap(ParserUtils.readMap(e)))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [id, breedName, petType, translations];
}

class BreedTranslationModel extends Equatable {
  final String languageCode;
  final String breedName;

  const BreedTranslationModel({
    required this.languageCode,
    required this.breedName,
  });

  factory BreedTranslationModel.fromMap(Map<String, dynamic> map) {
    return BreedTranslationModel(
      languageCode: ParserUtils.readString(map['languageCode']),
      breedName: ParserUtils.readString(map['breedName']),
    );
  }

  @override
  List<Object?> get props => [languageCode, breedName];
}
