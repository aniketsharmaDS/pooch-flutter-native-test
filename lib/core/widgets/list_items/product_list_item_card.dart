import 'package:flutter/material.dart';
import 'package:poochcare/core/widgets/images/app_image_frame.dart';
// import 'package:pooch_fe_native/shared/ui_components/custom_image_frame.dart';

/// =============================
/// MODEL
/// =============================

class ProductItem {
  final String name;
  final String age;
  final String gender;
  final bool isVaccinated;
  final int price;
  final String deliveryText;
  final String image;

  const ProductItem({
    required this.name,
    required this.age,
    required this.gender,
    required this.isVaccinated,
    required this.price,
    required this.deliveryText,
    required this.image,
  });
}

/// =============================
/// LIST ITEM COMPONENT
/// =============================

class ProductListItemCard extends StatelessWidget {
  final ProductItem product;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const ProductListItemCard({
    super.key,
    required this.product,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// IMAGE
              AppImageFrame(width: 130, height: 110, imageUrl: product.image),

              const SizedBox(width: 12),

              /// CONTENT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// NAME + AGE
                    Text(
                      '${product.name}, ${product.age}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'Gilroy500',
                        color: Color(0xFF1B1B1B),
                      ),
                    ),

                    const SizedBox(height: 6),

                    /// GENDER + VACCINATION
                    Row(
                      children: [
                        Icon(
                          product.gender.toLowerCase() == 'female'
                              ? Icons.female
                              : Icons.male,
                          size: 14,
                          color: const Color(0xFF906556),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          product.gender,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xFF906556),
                          ),
                        ),

                        if (product.isVaccinated) ...[
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.vaccines,
                            size: 14,
                            color: Color(0xFF188C43),
                          ),
                          const SizedBox(width: 2),
                          const Expanded(
                            child: Text(
                              'Vaccinated & Dewormed',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Gilroy600',
                                color: Color(0xFF188C43),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),

                    const SizedBox(height: 6),

                    /// PRICE
                    Text(
                      'INR ${product.price}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Gilroy700',
                        color: Color(0xFF1B1B1B),
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// DELIVERY TEXT
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF9E9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        product.deliveryText,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 8,
                          fontFamily: 'Gilroy500',
                          color: Color(0xFF5A1903),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// DELETE BUTTON
              SizedBox(
                width: 30,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Color(0xFF906556),
                  ),
                  onPressed: onDelete,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
