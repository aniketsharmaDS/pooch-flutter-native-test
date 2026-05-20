import 'package:flutter/material.dart';
import 'package:poochcare/core/widgets/others/price_summary_section.dart';

class OrderSummarySection extends StatelessWidget {
  final int itemCount;
  final int mrp;
  final int deliveryFee;
  final double discountAmount;
  final int tax;
  final int total;

  const OrderSummarySection({
    super.key,
    required this.itemCount,
    required this.mrp,
    required this.deliveryFee,
    required this.discountAmount,
    required this.tax,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return PriceSummarySection(
      title: 'Order Summary',
      itemCount: itemCount,
      rows: _buildRows(),
    );
  }

  List<PriceSummaryRow> _buildRows() {
    return [
      PriceSummaryRow(title: 'MRP', value: '₹$mrp'),
      PriceSummaryRow(
        title: 'Delivery Fee',
        value: deliveryFee == 0 ? 'Free' : '₹$deliveryFee',
        valueColor: deliveryFee == 0 ? Colors.green : null,
      ),
      if (discountAmount > 0)
        PriceSummaryRow(
          title: 'Discount',
          value: '-₹$discountAmount',
          titleColor: Colors.green,
          valueColor: Colors.green,
        ),
      PriceSummaryRow(title: 'Tax', value: '₹$tax'),
      PriceSummaryRow(title: 'Total', value: '₹$total', isTotal: true),
    ];
  }
}
