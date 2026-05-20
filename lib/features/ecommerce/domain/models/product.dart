import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    this.finalDiscountedPrice,
    this.inWishlist = false,
    this.productImages = const <String>[],
    this.tileImage = const <String>[],
    this.petDetails,
  });

  final String id;
  final String name;
  final double price;

  /// Buy Pet listing fields (optional)
  final double? finalDiscountedPrice;
  final bool inWishlist;
  final List<String> productImages;
  final List<String> tileImage;
  final PetDetails? petDetails;

  Product copyWith({
    String? id,
    String? name,
    double? price,
    double? finalDiscountedPrice,
    bool? inWishlist,
    List<String>? productImages,
    List<String>? tileImage,
    PetDetails? petDetails,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      finalDiscountedPrice: finalDiscountedPrice ?? this.finalDiscountedPrice,
      inWishlist: inWishlist ?? this.inWishlist,
      productImages: productImages ?? this.productImages,
      tileImage: tileImage ?? this.tileImage,
      petDetails: petDetails ?? this.petDetails,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    id,
    name,
    price,
    finalDiscountedPrice,
    inWishlist,
    productImages,
    tileImage,
    petDetails,
  ];
}

class PetDetails extends Equatable {
  const PetDetails({this.breedName, this.age, required this.isVaccinated});

  final String? breedName;
  final String? age;
  final bool isVaccinated;

  @override
  List<Object?> get props => <Object?>[breedName, age, isVaccinated];
}
