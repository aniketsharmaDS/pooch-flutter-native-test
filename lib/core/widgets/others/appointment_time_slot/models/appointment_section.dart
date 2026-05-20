import 'package:poochcare/core/widgets/others/appointment_time_slot/models/slots.dart';

class AppointmentSection {
  final String title;
  final String timing;
  final List<Slots> slots;
  final String iconPath;

  AppointmentSection({
    required this.title,
    required this.timing,
    required this.slots,
    required this.iconPath,
  });
}
