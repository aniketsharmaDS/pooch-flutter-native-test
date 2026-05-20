import 'package:poochcare/features/fun/data/api/accessories_api_service.dart';
import 'package:poochcare/features/fun/data/models/accessory_booking_summary_response_model.dart';
import 'package:poochcare/features/fun/data/models/accessory_marketplace_response_model.dart';
import 'package:poochcare/features/fun/data/models/accessory_my_accessories_response_model.dart';
import 'package:poochcare/features/fun/data/models/accessory_purchase_response_model.dart';
import 'package:poochcare/features/fun/data/models/leaderboard_response_model.dart';

class AccessoriesRepository {
  const AccessoriesRepository(this._api);

  final AccessoriesApiService _api;

  Future<AccessoryMarketplaceResponseModel> getMarketplaceAccessories({
    int page = 1,
    int limit = 10,
    String? couponCode,
  }) {
    return _api.getMarketplaceAccessories(
      page: page,
      limit: limit,
      couponCode: couponCode,
    );
  }

  Future<MyAccessoriesResponseModel> getMyAccessories({
    int page = 1,
    int limit = 20,
  }) {
    return _api.getMyAccessories(page: page, limit: limit);
  }

  Future<AccessoryBookingSummaryModel> getBookingSummary({
    required String accessoryId,
    required String petId,
    required int quantity,
    required String country,
    String? couponCode,
    String langCode = '',
  }) {
    return _api.getBookingSummary(
      accessoryId: accessoryId,
      petId: petId,
      quantity: quantity,
      country: country,
      couponCode: couponCode,
      langCode: langCode,
    );
  }

  Future<AccessoryPurchaseResponseModel> purchaseAccessory({
    required String accessoryId,
    required String petId,
    required int quantity,
    required String country,
    String? couponCode,
    String? langCode,
  }) {
    return _api.purchaseAccessory(
      accessoryId: accessoryId,
      petId: petId,
      quantity: quantity,
      country: country,
      couponCode: couponCode,
      langCode: langCode,
    );
  }

  Future<LeaderboardResponseModel> getLeaderboard({
    int page = 1,
    int limit = 20,
  }) {
    return _api.getLeaderboard(page: page, limit: limit);
  }
}
