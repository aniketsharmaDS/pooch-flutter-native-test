import 'package:poochcare/features/ecommerce/data/models/buy_pet/product_filters_model.dart';
import 'package:poochcare/features/ecommerce/domain/models/delivery_check.dart';
import 'package:poochcare/features/ecommerce/domain/models/paginated_products.dart';
import 'package:poochcare/features/ecommerce/domain/models/product_detail.dart';
import 'package:poochcare/features/pets/domain/models/breed.dart';

abstract class BuyPetRepository {
  Future<PaginatedProducts> getProducts({
    required int page,
    String? petType,
    String? search,
    String? sortBy,
    String? sortOrder,
    List<String>? gender,
    List<String>? breed,
    String? size,
    List<String>? lifeStage,
    List<String>? energyLevel,
    List<String>? grooming,
    List<String>? temperament,
    List<String>? subcategory,
    List<String>? allergy,
  });

  Future<PaginatedProducts> getRecentlyViewed({
    required int page,
    String? search,
  });

  Future<PaginatedProducts> getPopularProducts({
    required int page,
    String? search,
  });

  Future<PaginatedProducts> getFeaturedProducts({
    required int page,
    required String petType,
    String? search,
  });
  Future<ProductDetail> getProductDetail({required String productId});
  Future<DeliveryCheck> checkDelivery({
    required String productId,
    required String pincode,
  });
  Future<ProductFilters> getProductFilters({required String petType});
  Future<List<Breed>> getBreeds({required String petType});

  Future<dynamic> addToWishlist(String productId);

  Future<void> removeFromWishlist(String productId);

  Future<PaginatedProducts> getWishlist({required int page});

  Future<int> getWishlistCount();
}
