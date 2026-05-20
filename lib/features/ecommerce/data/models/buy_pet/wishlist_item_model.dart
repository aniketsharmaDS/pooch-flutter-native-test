import 'package:poochcare/features/ecommerce/data/models/buy_pet/product_model.dart';

class WishlistItemModel {
  final String id;
  final String petId;
  final ProductModel pet;

  WishlistItemModel({required this.id, required this.petId, required this.pet});

  factory WishlistItemModel.fromJson(Map<String, dynamic> json) {
    return WishlistItemModel(
      id: json['id'] as String,
      petId: json['petId'] as String,
      pet: ProductModel.fromMap(json['pet'] as Map<String, dynamic>),
    );
  }
}
