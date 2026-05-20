import 'package:dart_mappable/dart_mappable.dart';
import 'package:poochcare/core/mappers/safe_hooks.dart';
import 'package:poochcare/core/utils/date_time_formattter.dart';

part 'cart_item_model.mapper.dart';

@MappableClass()
class CartItem with CartItemMappable {
  const CartItem({
    required this.id,
    required this.userId,
    this.productType,
    this.productId,
    this.quantity,
    this.couponCode,
    this.discountAmount,
    this.originalPrice,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.pricing,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      CartItemMapper.fromMap(json);

  @MappableField(hook: SafeStringHook())
  final String id;

  @MappableField(hook: SafeStringHook())
  final String userId;

  final String? productType;

  final String? productId;

  final int? quantity;

  final String? couponCode;

  final String? discountAmount;

  final String? originalPrice;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final CartItemProduct? product;

  final CartItemPricing? pricing;
}

@MappableClass()
class CartItemProduct with CartItemProductMappable {
  const CartItemProduct({
    this.id,
    this.productNumber,
    this.vendorId,
    this.warehouseId,
    this.category,
    this.subcategory,
    this.price,
    this.currencyCode,
    this.countryCode,
    this.stock,
    this.status,
    this.productImages,
    this.tileImage,
    this.deliveryType,
    this.deliveryDistance,
    this.deliveryMethod,
    this.discountType,
    this.discountAmount,
    this.isActive,
    this.isDeleted,
    this.isDraft,
    this.tags,
    this.viewCount,
    this.createdAt,
    this.updatedAt,
    this.petDetails,
  });

  factory CartItemProduct.fromJson(Map<String, dynamic> json) =>
      CartItemProductMapper.fromMap(json);

  final String? id;

  final String? productNumber;

  final String? vendorId;

  final String? warehouseId;

  final String? category;

  final String? subcategory;

  final String? price;

  final String? currencyCode;

  final String? countryCode;

  final int? stock;

  final String? status;

  final List<String>? productImages;

  final List<String>? tileImage;

  final String? deliveryType;

  final String? deliveryDistance;

  final String? deliveryMethod;

  final String? discountType;

  final String? discountAmount;

  final bool? isActive;

  final bool? isDeleted;

  final bool? isDraft;

  final List<String>? tags;

  final int? viewCount;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final CartItemPetDetails? petDetails;
}

@MappableClass()
class CartItemPetDetails with CartItemPetDetailsMappable {
  const CartItemPetDetails({
    this.id,
    this.gender,
    this.breedId,
    this.dob,
    this.size,
    this.weight,
    this.height,
    this.heightUnit,
    this.weightUnit,
    this.priceUnit,
    this.bcsScore,
    this.lifeStage,
    this.energyLevel,
    this.groomingNeeds,
    this.temperament,
    this.isHypoallergenic,
    this.isVaccinated,
    this.allergies,
    this.createdAt,
    this.updatedAt,
    this.translations,
    this.breedInfo,
  });

  factory CartItemPetDetails.fromJson(Map<String, dynamic> json) =>
      CartItemPetDetailsMapper.fromMap(json);

  final String? id;

  final String? gender;

  final String? breedId;

  final DateTime? dob;

  final String? size;

  final String? weight;

  final String? height;

  final String? heightUnit;

  final String? weightUnit;

  final String? priceUnit;

  final int? bcsScore;

  final String? lifeStage;

  final String? energyLevel;

  final String? groomingNeeds;

  final String? temperament;

  final bool? isHypoallergenic;

  final bool? isVaccinated;

  final String? allergies;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final List<PetTranslation>? translations;

  final PetBreedInfo? breedInfo;

  String get ageDisplay {
    final age = formatPetAge(dob: dob, showFullUnit: false);
    return age;
  }
}

@MappableClass()
class PetTranslation with PetTranslationMappable {
  const PetTranslation({
    this.translationId,
    this.productId,
    this.langCode,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory PetTranslation.fromJson(Map<String, dynamic> json) =>
      PetTranslationMapper.fromMap(json);

  final int? translationId;

  final String? productId;

  final String? langCode;

  final String? name;

  final String? description;

  final DateTime? createdAt;

  final DateTime? updatedAt;
}

@MappableClass()
class PetBreedInfo with PetBreedInfoMappable {
  const PetBreedInfo({
    this.id,
    this.breedName,
    this.petType,
    this.sizeCategory,
    this.temperament,
    this.averageWeight,
    this.averageLifespan,
  });

  factory PetBreedInfo.fromJson(Map<String, dynamic> json) =>
      PetBreedInfoMapper.fromMap(json);

  final String? id;

  final String? breedName;

  final String? petType;

  final String? sizeCategory;

  final String? temperament;

  final String? averageWeight;

  final String? averageLifespan;
}

@MappableClass()
class CartItemPricing with CartItemPricingMappable {
  const CartItemPricing({
    this.basePrice,
    this.quantity,
    this.subtotal,
    this.discount,
    this.finalPrice,
    this.priceUnit,
    this.deliveryFee,
  });

  factory CartItemPricing.fromJson(Map<String, dynamic> json) =>
      CartItemPricingMapper.fromMap(json);

  final String? basePrice;

  final int? quantity;

  final double? subtotal;

  final double? discount;

  final double? finalPrice;

  final String? priceUnit;

  final double? deliveryFee;
}

@MappableClass()
class CartData with CartDataMappable {
  const CartData({
    required this.userId,
    this.items,
    this.totalItems,
    this.currentPage,
    this.totalPages,
    this.hasNextPage,
    this.hasPreviousPage,
    this.pricing,
    this.appliedCoupon,
    this.totalAmount,
    this.orderSummary,
  });

  factory CartData.fromJson(Map<String, dynamic> json) =>
      CartDataMapper.fromMap(json);

  @MappableField(hook: SafeStringHook())
  final String userId;

  final List<CartItem>? items;

  final int? totalItems;

  final int? currentPage;

  final int? totalPages;

  final bool? hasNextPage;

  final bool? hasPreviousPage;

  final CartPricing? pricing;

  @MappableField(key: 'appliedCoupon')
  final AppliedCoupon? appliedCoupon;

  @MappableField(key: 'total_amount')
  final double? totalAmount;

  @MappableField(key: 'order_summary')
  final CartOrderSummary? orderSummary;
}

@MappableClass()
class CartPricing with CartPricingMappable {
  const CartPricing({
    this.subtotal,
    this.totalDiscount,
    this.finalTotal,
    this.hasCouponApplied,
  });

  factory CartPricing.fromJson(Map<String, dynamic> json) =>
      CartPricingMapper.fromMap(json);

  final double? subtotal;

  final double? totalDiscount;

  final double? finalTotal;

  final bool? hasCouponApplied;
}

@MappableClass()
class AppliedCoupon with AppliedCouponMappable {
  const AppliedCoupon({
    this.couponCode,
    this.appliedAt,
    this.discountType,
    this.discountValue,
    this.minimumOrderAmount,
    this.maximumDiscountAmount,
    this.validFrom,
    this.validTo,
    this.status,
    this.totalDiscountApplied,
  });

  factory AppliedCoupon.fromJson(Map<String, dynamic> json) =>
      AppliedCouponMapper.fromMap(json);

  final String? couponCode;

  final DateTime? appliedAt;

  final String? discountType;

  final String? discountValue;

  final double? minimumOrderAmount;

  final double? maximumDiscountAmount;

  final DateTime? validFrom;

  final DateTime? validTo;

  final String? status;

  final double? totalDiscountApplied;
}

@MappableClass()
class CartOrderSummary with CartOrderSummaryMappable {
  const CartOrderSummary({
    this.items,
    this.subTotal,
    this.deliveryFee,
    this.tax,
    this.discount,
    this.addOns,
    this.total,
  });

  factory CartOrderSummary.fromJson(Map<String, dynamic> json) =>
      CartOrderSummaryMapper.fromMap(json);

  final List<CartOrderItem>? items;

  @MappableField(key: 'sub_total')
  final double? subTotal;

  @MappableField(key: 'delivery_fee')
  final double? deliveryFee;

  final double? tax;

  final double? discount;

  @MappableField(key: 'add_ons')
  final List<dynamic>? addOns;

  final double? total;
}

@MappableClass()
class CartOrderItem with CartOrderItemMappable {
  const CartOrderItem({
    this.title,
    this.price,
    this.priceUnit,
    this.deliveryFee,
  });

  factory CartOrderItem.fromJson(Map<String, dynamic> json) =>
      CartOrderItemMapper.fromMap(json);

  final String? title;

  final double? price;

  final String? priceUnit;

  @MappableField(key: 'delivery_fee')
  final double? deliveryFee;
}
