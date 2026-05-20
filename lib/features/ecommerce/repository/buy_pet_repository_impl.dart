import 'package:poochcare/features/ecommerce/data/api/buy_pet_api_service.dart';
import 'package:poochcare/features/ecommerce/data/mappers/buy_pet/buy_pet_detail_mapper.dart';
import 'package:poochcare/features/ecommerce/data/mappers/buy_pet/buy_pet_product_mapper.dart';
import 'package:poochcare/features/ecommerce/data/mappers/buy_pet/delivery_check_mapper.dart';
import 'package:poochcare/features/ecommerce/data/models/buy_pet/product_filters_model.dart';
import 'package:poochcare/features/ecommerce/data/models/buy_pet/wishlist_item_model.dart';
import 'package:poochcare/features/ecommerce/domain/models/delivery_check.dart';
import 'package:poochcare/features/ecommerce/domain/models/paginated_products.dart';
import 'package:poochcare/features/ecommerce/domain/models/product_detail.dart';
import 'package:poochcare/features/ecommerce/domain/repository/buy_pet_repository.dart';
import 'package:poochcare/features/pets/data/api/pets_api_service.dart';
import 'package:poochcare/features/pets/domain/models/breed.dart';

class BuyPetRepositoryImpl implements BuyPetRepository {
  const BuyPetRepositoryImpl({required this.api, this.petsApi});

  final BuyPetApiService api;
  final PetsApiService? petsApi;

  @override
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
    String? couponCode,
  }) async {
    final response = await api.getAllProducts(
      couponCode: couponCode,
      page: page,
      petType: petType,
      search: search,
      sortBy: sortBy,
      sortOrder: sortOrder,
      gender: gender,
      breed: breed,
      size: size,
      lifeStage: lifeStage,
      energyLevel: energyLevel,
      grooming: grooming,
      temperament: temperament,
      subcategory: subcategory,
      allergy: allergy,
    );

    final hasNextPage = response.currentPage < response.totalPages;

    return PaginatedProducts(
      products: BuyPetProductMapper.listToDomain(response.products),
      currentPage: response.currentPage,
      hasNextPage: hasNextPage,
    );
  }

  @override
  Future<PaginatedProducts> getRecentlyViewed({
    required int page,
    String? search,
  }) async {
    final response = await api.getRecentlyViewedProducts(
      page: page,
      search: search,
    );

    final hasNextPage = response.currentPage < response.totalPages;

    return PaginatedProducts(
      products: BuyPetProductMapper.listToDomain(response.products),
      currentPage: response.currentPage,
      hasNextPage: hasNextPage,
    );
  }

  @override
  Future<PaginatedProducts> getPopularProducts({
    required int page,
    String? search,
  }) async {
    final response = await api.getPopularProducts(page: page, search: search);

    final hasNextPage = response.currentPage < response.totalPages;

    return PaginatedProducts(
      products: BuyPetProductMapper.listToDomain(response.products),
      currentPage: response.currentPage,
      hasNextPage: hasNextPage,
    );
  }

  @override
  Future<PaginatedProducts> getFeaturedProducts({
    required int page,
    required String petType,
    String? search,
  }) async {
    final response = await api.getFeaturedProducts(
      page: page,
      petType: petType,
      search: search,
    );

    final hasNextPage = response.currentPage < response.totalPages;

    return PaginatedProducts(
      products: BuyPetProductMapper.listToDomain(response.products),
      currentPage: response.currentPage,
      hasNextPage: hasNextPage,
    );
  }

  @override
  Future<ProductDetail> getProductDetail({required String productId}) async {
    final model = await api.getProductDetail(productId: productId);
    return BuyPetDetailMapper.toDomain(model);
  }

  @override
  Future<DeliveryCheck> checkDelivery({
    required String productId,
    required String pincode,
  }) async {
    final model = await api.checkDelivery(
      productId: productId,
      pincode: pincode,
    );
    return DeliveryCheckMapper.toDomain(model);
  }

  @override
  Future<ProductFilters> getProductFilters({required String petType}) async {
    return await api.getProductFilters(petType);
  }

  @override
  Future<List<Breed>> getBreeds({required String petType}) {
    return petsApi?.getBreeds(petType: petType) ?? Future.value([]);
  }

  @override
  Future<dynamic> addToWishlist(String productId) {
    return api.addToWishlist(productId);
  }

  @override
  Future<void> removeFromWishlist(String productId) {
    return api.removeFromWishlist(productId);
  }

  @override
  Future<PaginatedProducts> getWishlist({required int page}) async {
    final response = await api.getWishlist(page: page);

    final items = (response['items'] as List)
        .map((e) => WishlistItemModel.fromJson(e as Map<String, dynamic>))
        .toList();

    final products = items
        .map((e) => BuyPetProductMapper.toDomain(e.pet))
        .toList();

    return PaginatedProducts(
      products: products,
      currentPage: response['currentPage'] as int? ?? 1,
      hasNextPage: response['hasNextPage'] as bool? ?? false,
    );
  }

  @override
  Future<int> getWishlistCount() {
    return api.getWishlistCount();
  }
}
