import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/domain/models/appointment.dart';
import 'package:poochcare/core/store/appointments/appointments_store_bloc.dart';
import 'package:poochcare/core/store/appointments/appointments_store_state.dart';
import 'package:poochcare/core/widgets/cards/app_card.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class AppointmentListWidget extends StatelessWidget {
  const AppointmentListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      AppointmentsStoreBloc,
      AppointmentsStoreState,
      List<Appointment>
    >(
      selector: (AppointmentsStoreState state) => state.appointmentIds
          .map((String id) => state.appointmentsById[id]!)
          .toList(),
      builder: (BuildContext context, List<Appointment> appointments) {
        return AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppText.bodyM(
                'Appointments',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              if (appointments.isEmpty)
                AppText.bodyM('No appointments found')
              else
                ...appointments.map(
                  (Appointment item) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: AppText.bodyS('${item.service} • ${item.dateLabel}'),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
