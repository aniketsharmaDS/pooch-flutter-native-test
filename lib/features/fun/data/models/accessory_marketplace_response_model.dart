import 'package:poochcare/core/utils/parser_utils.dart';

class AccessoryPriceModel {
  const AccessoryPriceModel({
    required this.price,
    required this.country,
    required this.isCustom,
  });

  final int price;
  final String country;
  final bool isCustom;

  factory AccessoryPriceModel.fromMap(Map<String, dynamic> map) {
    return AccessoryPriceModel(
      price: ParserUtils.readInt(map['price']),
      country: ParserUtils.readString(map['country']),
      isCustom: ParserUtils.readBool(map['isCustom']),
    );
  }
}

class AccessoryTranslationModel {
  const AccessoryTranslationModel({
    required this.id,
    required this.accessoryId,
    required this.langCode,
    required this.name,
    required this.description,
    required this.features,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String accessoryId;
  final String langCode;
  final String name;
  final String description;
  final List<String> features;
  final String createdAt;
  final String updatedAt;

  factory AccessoryTranslationModel.fromMap(Map<String, dynamic> map) {
    return AccessoryTranslationModel(
      id: ParserUtils.readString(map['id']),
      accessoryId: ParserUtils.readString(map['accessoryId']),
      langCode: ParserUtils.readString(map['langCode']),
      name: ParserUtils.readString(map['name']),
      description: ParserUtils.readString(map['description']),
      features: ParserUtils.readStringList(map['features']),
      createdAt: ParserUtils.readString(map['createdAt']),
      updatedAt: ParserUtils.readString(map['updatedAt']),
    );
  }
}

class AccessoryProductModel {
  const AccessoryProductModel({required this.id, required this.status});

  final String id;
  final String status;

  factory AccessoryProductModel.fromMap(Map<String, dynamic> map) {
    return AccessoryProductModel(
      id: ParserUtils.readString(map['id']),
      status: ParserUtils.readString(map['status']),
    );
  }
}

class AccessoryMarketplaceItem {
  const AccessoryMarketplaceItem({
    required this.id,
    required this.productId,
    required this.avatarType,
    required this.accessoryCategory,
    required this.accessorySlot,
    required this.animationType,
    required this.riveFile,
    required this.riveVersion,
    required this.lottieFile,
    required this.lottieVersion,
    required this.thumbnail,
    required this.previewGif,
    required this.additionalImages,
    required this.startTime,
    required this.endTime,
    required this.hasInteractivity,
    required this.loopable,
    required this.prices,
    required this.isPremium,
    required this.stock,
    required this.points,
    required this.warehouseId,
    required this.compatibilityNotes,
    required this.deliveryType,
    required this.isDraft,
    required this.createdAt,
    required this.updatedAt,
    required this.translations,
    required this.product,
    required this.price,
    required this.country,
    required this.isCustomPrice,
    required this.currency,
  });

  final String id;
  final String productId;
  final String avatarType;
  final String accessoryCategory;
  final String accessorySlot;
  final String? animationType;
  final String? riveFile;
  final String? riveVersion;
  final String? lottieFile;
  final String? lottieVersion;
  final String? thumbnail;
  final String? previewGif;
  final List<String> additionalImages;
  final String? startTime;
  final String? endTime;
  final bool hasInteractivity;
  final bool loopable;
  final List<AccessoryPriceModel> prices;
  final bool isPremium;
  final int stock;
  final int points;
  final String? warehouseId;
  final String? compatibilityNotes;
  final String deliveryType;
  final bool isDraft;
  final String createdAt;
  final String updatedAt;
  final List<AccessoryTranslationModel> translations;
  final AccessoryProductModel? product;
  final int price;
  final String country;
  final bool isCustomPrice;
  final String currency;

  factory AccessoryMarketplaceItem.fromMap(Map<String, dynamic> map) {
    return AccessoryMarketplaceItem(
      currency: ParserUtils.readString(map['currency']),
      id: ParserUtils.readString(map['id']),
      productId: ParserUtils.readString(map['productId']),
      avatarType: ParserUtils.readString(map['avatarType']),
      accessoryCategory: ParserUtils.readString(map['accessoryCategory']),
      accessorySlot: ParserUtils.readString(map['accessorySlot']),
      animationType: ParserUtils.readNullableString(map['animationType']),
      riveFile: ParserUtils.readNullableString(map['riveFile']),
      riveVersion: ParserUtils.readNullableString(map['riveVersion']),
      lottieFile: ParserUtils.readNullableString(map['lottieFile']),
      lottieVersion: ParserUtils.readNullableString(map['lottieVersion']),
      thumbnail: ParserUtils.readNullableString(map['thumbnail']),
      previewGif: ParserUtils.readNullableString(map['previewGif']),
      additionalImages: ParserUtils.readStringList(map['additionalImages']),
      startTime: ParserUtils.readNullableString(map['startTime']),
      endTime: ParserUtils.readNullableString(map['endTime']),
      hasInteractivity: ParserUtils.readBool(map['hasInteractivity']),
      loopable: ParserUtils.readBool(map['loopable']),
      prices: (map['prices'] as List? ?? const <dynamic>[])
          .whereType<Map>()
          .map((e) => ParserUtils.readMap(e))
          .map(AccessoryPriceModel.fromMap)
          .toList(growable: false),
      isPremium: ParserUtils.readBool(map['isPremium']),
      stock: ParserUtils.readInt(map['stock']),
      points: ParserUtils.readInt(map['points']),
      warehouseId: ParserUtils.readNullableString(map['warehouseId']),
      compatibilityNotes: ParserUtils.readNullableString(
        map['compatibilityNotes'],
      ),
      deliveryType: ParserUtils.readString(map['deliveryType']),
      isDraft: ParserUtils.readBool(map['isDraft']),
      createdAt: ParserUtils.readString(map['createdAt']),
      updatedAt: ParserUtils.readString(map['updatedAt']),
      translations: (map['translations'] as List? ?? const <dynamic>[])
          .whereType<Map>()
          .map((e) => ParserUtils.readMap(e))
          .map(AccessoryTranslationModel.fromMap)
          .toList(growable: false),
      product: map['product'] is Map
          ? AccessoryProductModel.fromMap(ParserUtils.readMap(map['product']))
          : null,
      price: ParserUtils.readInt(map['price']),
      country: ParserUtils.readString(map['country']),
      isCustomPrice: ParserUtils.readBool(map['isCustomPrice']),
    );
  }
}

class AccessoryMarketplacePaginationModel {
  const AccessoryMarketplacePaginationModel({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
    required this.limit,
  });

  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int itemsPerPage;
  final int limit;

  factory AccessoryMarketplacePaginationModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return AccessoryMarketplacePaginationModel(
      currentPage: ParserUtils.readInt(map['currentPage']),
      totalPages: ParserUtils.readInt(map['totalPages']),
      totalItems: ParserUtils.readInt(map['totalItems']),
      itemsPerPage: ParserUtils.readInt(map['itemsPerPage']),
      limit: ParserUtils.readInt(map['limit']),
    );
  }
}

class AccessoryMarketplaceResponseModel {
  const AccessoryMarketplaceResponseModel({
    required this.accessories,
    required this.pagination,
  });

  final List<AccessoryMarketplaceItem> accessories;
  final AccessoryMarketplacePaginationModel pagination;

  factory AccessoryMarketplaceResponseModel.fromMap(Map<String, dynamic> map) {
    return AccessoryMarketplaceResponseModel(
      accessories: (map['accessories'] as List? ?? const <dynamic>[])
          .whereType<Map>()
          .map((e) => ParserUtils.readMap(e))
          .map(AccessoryMarketplaceItem.fromMap)
          .toList(growable: false),
      pagination: AccessoryMarketplacePaginationModel.fromMap(
        ParserUtils.readMap(map['pagination']),
      ),
    );
  }
}
