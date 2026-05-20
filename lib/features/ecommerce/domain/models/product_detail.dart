import 'package:equatable/equatable.dart';

class ProductDetail extends Equatable {
  const ProductDetail({
    required this.id,
    required this.name,
    required this.gender,
    required this.description,
    required this.price,
    this.finalDiscountedPrice,
    required this.currencyCode,
    required this.countryCode,
    required this.productImages,
    required this.tileImage,
    required this.inWishlist,
    required this.inCart,
    required this.tags,
    this.deliveryType,
    this.deliveryDistance,
    this.deliveryMethod,
    this.couponApplied,
    this.couponError,
    this.petDetails,
  });

  final String id;
  final String name;
  final String gender;
  final String description;
  final double price;
  final double? finalDiscountedPrice;
  final String currencyCode;
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
  final ProductDetailPetDetails? petDetails;

  ProductDetail copyWith({
    String? id,
    String? name,
    String? description,
    String? gender,
    double? price,
    double? finalDiscountedPrice,
    String? currencyCode,
    String? countryCode,
    List<String>? productImages,
    List<String>? tileImage,
    bool? inWishlist,
    bool? inCart,
    List<String>? tags,
    String? deliveryType,
    String? deliveryDistance,
    String? deliveryMethod,
    String? couponApplied,
    String? couponError,
    ProductDetailPetDetails? petDetails,
  }) {
    return ProductDetail(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      gender: gender ?? this.gender,
      price: price ?? this.price,
      finalDiscountedPrice: finalDiscountedPrice ?? this.finalDiscountedPrice,
      currencyCode: currencyCode ?? this.currencyCode,
      countryCode: countryCode ?? this.countryCode,
      productImages: productImages ?? this.productImages,
      tileImage: tileImage ?? this.tileImage,
      inWishlist: inWishlist ?? this.inWishlist,
      inCart: inCart ?? this.inCart,
      tags: tags ?? this.tags,
      deliveryType: deliveryType ?? this.deliveryType,
      deliveryDistance: deliveryDistance ?? this.deliveryDistance,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      couponApplied: couponApplied ?? this.couponApplied,
      couponError: couponError ?? this.couponError,
      petDetails: petDetails ?? this.petDetails,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    id,
    name,
    gender,
    description,
    price,
    finalDiscountedPrice,
    currencyCode,
    countryCode,
    productImages,
    tileImage,
    inWishlist,
    inCart,
    tags,
    deliveryType,
    deliveryDistance,
    deliveryMethod,
    couponApplied,
    couponError,
    petDetails,
  ];
}

class ProductDetailPetDetails extends Equatable {
  const ProductDetailPetDetails({
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
    required this.isVaccinated,
    required this.isHypoallergenic,
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
  final BreedInfo? breedInfo;

  @override
  List<Object?> get props => <Object?>[
    name,
    description,
    temperament,
    size,
    weight,
    weightUnit,
    height,
    heightUnit,
    lifeStage,
    energyLevel,
    groomingNeeds,
    isHypoallergenic,
    gender,
    dateOfBirth,
    bcsScore,
    breedInfo,
  ];
}

class BreedInfo extends Equatable {
  const BreedInfo({
    required this.breedName,
    required this.petType,
    required this.sizeCategory,
    required this.temperament,
  });

  final String breedName;
  final String petType;
  final String sizeCategory;
  final String temperament;

  @override
  List<Object?> get props => <Object?>[
    breedName,
    petType,
    sizeCategory,
    temperament,
  ];
}
