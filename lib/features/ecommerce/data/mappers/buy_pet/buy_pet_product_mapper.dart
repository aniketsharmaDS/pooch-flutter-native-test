import 'package:poochcare/features/ecommerce/data/models/buy_pet/product_model.dart';
import 'package:poochcare/features/ecommerce/domain/models/product.dart';

class BuyPetProductMapper {
  const BuyPetProductMapper._();

  static Product toDomain(ProductModel model) {
    return Product(
      id: model.id,
      name: model.name,
      price: model.price,
      finalDiscountedPrice: model.finalDiscountedPrice,
      inWishlist: model.inWishlist,
      productImages: model.productImages,
      tileImage: model.tileImage,
      petDetails: model.petDetails == null
          ? null
          : PetDetails(
              breedName: model.petDetails!.breedName,
              age: model.petDetails!.age,
              isVaccinated: model.petDetails!.isVaccinated,
            ),
    );
  }

  static List<Product> listToDomain(List<ProductModel> models) {
    return models.map(toDomain).toList(growable: false);
  }
}
