import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  const Cart({required this.itemsCount, required this.totalAmount});

  final int itemsCount;
  final double totalAmount;

  Cart copyWith({int? itemsCount, double? totalAmount}) {
    return Cart(
      itemsCount: itemsCount ?? this.itemsCount,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  @override
  List<Object?> get props => <Object?>[itemsCount, totalAmount];
}
