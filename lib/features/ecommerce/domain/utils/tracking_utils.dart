import 'package:intl/intl.dart';

class TrackingUtils {
  static String format(String date) {
    final dt = DateTime.parse(date).toLocal();
    return DateFormat('dd MMM, hh:mm a').format(dt);
  }

  static String formatTitleDate(String date) {
    final dt = DateTime.parse(date).toLocal();

    final day = dt.day;
    final suffix = _getDaySuffix(day);

    return DateFormat('EEE, d').format(dt) +
        suffix +
        DateFormat(" MMM''yy").format(dt);
  }

  static String formatReason(String raw) {
    if (raw.isEmpty) return '';

    return raw
        .replaceAll('_', ' ')
        .split(' ')
        .map((e) => e.isNotEmpty ? e[0].toUpperCase() + e.substring(1) : '')
        .join(' ');
  }

  static String mapEventText(String status, String? notes) {
    if (notes != null && notes.isNotEmpty) return notes;

    switch (status) {
      case 'picked_up':
        return 'Your order has been picked up';
      case 'in_transit':
        return 'Your order is in transit';
      case 'out_for_delivery':
        return 'Out for delivery';
      case 'delivered':
        return 'Package delivered';
      default:
        return status.replaceAll('_', ' ');
    }
  }

  static String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';

    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
