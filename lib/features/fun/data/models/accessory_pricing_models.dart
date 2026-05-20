import 'package:poochcare/core/utils/parser_utils.dart';

class AccessorySummaryModel {
  const AccessorySummaryModel({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.price,
    required this.country,
    required this.currency,
    required this.isCustomPrice,
    required this.isPremium,
  });

  final String id;
  final String name;
  final String? thumbnail;
  final double price;
  final String country;
  final String currency;
  final bool isCustomPrice;
  final bool isPremium;

  factory AccessorySummaryModel.fromMap(Map<String, dynamic> map) {
    return AccessorySummaryModel(
      id: ParserUtils.readString(map['id']),
      name: ParserUtils.readString(map['name']),
      thumbnail: ParserUtils.readNullableString(map['thumbnail']),
      price: ParserUtils.readDouble(map['price']),
      country: ParserUtils.readString(map['country']),
      currency: ParserUtils.readString(map['currency']),
      isCustomPrice: ParserUtils.readBool(map['isCustomPrice']),
      isPremium: ParserUtils.readBool(map['isPremium']),
    );
  }
}

class AccessoryPricingModel {
  const AccessoryPricingModel({
    required this.basePrice,
    required this.discount,
    required this.finalPrice,
    required this.country,
    required this.currency,
  });

  final double basePrice;
  final double discount;
  final double finalPrice;
  final String country;
  final String currency;

  factory AccessoryPricingModel.fromMap(Map<String, dynamic> map) {
    return AccessoryPricingModel(
      basePrice: ParserUtils.readDouble(map['basePrice']),
      discount: ParserUtils.readDouble(map['discount']),
      finalPrice: ParserUtils.readDouble(map['finalPrice']),
      country: ParserUtils.readString(map['country']),
      currency: ParserUtils.readString(map['currency']),
    );
  }
}
