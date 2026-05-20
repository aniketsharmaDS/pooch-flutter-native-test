import 'package:flutter/material.dart';
import 'package:poochcare/core/widgets/others/appointment_time_slot/models/appointment_section.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class SlotsGridView extends StatelessWidget {
  const SlotsGridView({super.key, required this.appointmentsSection});

  final AppointmentSection appointmentsSection;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      shrinkWrap: true,
      itemCount: appointmentsSection.slots.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final slotData = appointmentsSection.slots[index];
        return InkWell(
          onTap: slotData.isAvailable ? slotData.onTap : null,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            alignment: Alignment.center,
            height: 40,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(
                color: slotData.isSelected
                    ? const Color(0xffE7B123)
                    : const Color(0xffEFE8E6),
              ),
              borderRadius: BorderRadius.circular(10),
              color: slotData.isSelected
                  ? const Color(0xffFFF9E9)
                  : Colors.transparent,
            ),
            child: AppText.bodyS(
              slotData.slotTime,
              color: slotData.isAvailable
                  ? const Color(0xff260B01)
                  : const Color(0xffA7A7A8),
            ),
          ),
        );
      },
    );
  }
}
