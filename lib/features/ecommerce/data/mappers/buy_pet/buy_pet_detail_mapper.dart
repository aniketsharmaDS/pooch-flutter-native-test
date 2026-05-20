import 'package:poochcare/features/ecommerce/data/models/buy_pet/product_detail_model.dart';
import 'package:poochcare/features/ecommerce/domain/models/product_detail.dart';

class BuyPetDetailMapper {
  const BuyPetDetailMapper._();

  static ProductDetail toDomain(ProductDetailModel model) {
    final petDetails = model.petDetails;
    final breedInfo = petDetails?.breedInfo;

    final String name = _firstNonEmpty(<String?>[
      petDetails?.name,
      breedInfo?.breedName,
      'Pet',
    ]);

    final String description = _firstNonEmpty(<String?>[
      petDetails?.description,
      'Description unavailable.',
    ]);

    return ProductDetail(
      id: model.id,
      name: name,
      gender: model.gender,
      description: description,
      price: model.price,
      finalDiscountedPrice: model.finalDiscountedPrice,
      currencyCode: model.currencyCode,
      countryCode: model.countryCode,
      productImages: model.productImages,
      tileImage: model.tileImage,
      inWishlist: model.inWishlist,
      inCart: model.inCart,
      tags: model.tags,
      deliveryType: model.deliveryType,
      deliveryDistance: model.deliveryDistance,
      deliveryMethod: model.deliveryMethod,
      couponApplied: model.couponApplied,
      couponError: model.couponError,
      petDetails: petDetails == null
          ? null
          : ProductDetailPetDetails(
              name: petDetails.name,
              description: petDetails.description,
              temperament: petDetails.temperament,
              size: petDetails.size,
              weight: petDetails.weight,
              weightUnit: petDetails.weightUnit,
              height: petDetails.height,
              heightUnit: petDetails.heightUnit,
              lifeStage: petDetails.lifeStage,
              energyLevel: petDetails.energyLevel,
              groomingNeeds: petDetails.groomingNeeds,
              isVaccinated: petDetails.isVaccinated,
              isHypoallergenic: petDetails.isHypoallergenic,
              gender: petDetails.gender,
              dateOfBirth: petDetails.dateOfBirth,
              bcsScore: petDetails.bcsScore,
              breedInfo: breedInfo == null
                  ? null
                  : BreedInfo(
                      breedName: breedInfo.breedName,
                      petType: breedInfo.petType,
                      sizeCategory: breedInfo.sizeCategory,
                      temperament: breedInfo.temperament,
                    ),
            ),
    );
  }
}

String _firstNonEmpty(List<String?> values) {
  for (final value in values) {
    final v = value?.trim() ?? '';
    if (v.isNotEmpty) return v;
  }
  return '';
}
