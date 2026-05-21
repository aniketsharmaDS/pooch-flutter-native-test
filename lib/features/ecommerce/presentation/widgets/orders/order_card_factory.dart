import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/widgets/dialogs/app_select_pet_dialog.dart';
// import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/features/ecommerce/data/mappers/orders/order_action_mapper.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_item_model.dart';
import 'package:poochcare/features/ecommerce/data/types/orders/orders.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/consultation_order_list_card.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/order_list_card.dart';
import 'package:poochcare/features/insight/data/cubit/appointment_request_cubit.dart';
import 'package:poochcare/features/user_profile/domain/models/user_pet.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';
// import 'package:poochcare/features/insight/data/cubit/appointment_request_cubit.dart';
import 'package:poochcare/router/app_router.dart';

class OrderCardFactory extends StatelessWidget {
  final OrderItemModel item;

  const OrderCardFactory({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final action = OrderActionMapper.resolve(context, item);

    VoidCallback? onCardTap;

    // 👇 Only for product & accessory
    if (item.orderType == OrderType.product ||
        item.orderType == OrderType.accessory) {
      onCardTap = () {
        context.router.push(
          OrderDetailsRoute(orderId: item.orderId, itemId: item.itemId),
        );
      };
    }

    switch (item.orderType) {
      case OrderType.product:
      case OrderType.accessory:
        return OrderListCard(
          item: item,
          actionLabel: action.label,
          onAction: action.onTap,
          onTap: onCardTap,
        );

      case OrderType.vetSubscription:
      case OrderType.poochSubscription:
        return ConsultationOrderListCard(
          title: item.title,
          subtitle: item.subtitle,
          dateTime: item.dateTime,
          orderId: item.orderNumber,
          status: item.status,
          image: NetworkImage(item.image),
          onUpgrade: () {
            selectPetAndsubscribeClinic(context, item: item);
          },
        );
    }
  }

  void selectPetAndsubscribeClinic(
    BuildContext context, {
    required OrderItemModel item,
  }) async {
    final String? petId = item.subscriptionDetails.isNotEmpty
        ? item.subscriptionDetails.first.pet?.id
        : null;

    final String? clinicId = item.subscriptionDetails.isNotEmpty
        ? item.subscriptionDetails.first.clinic?.id
        : null;
    log(
      'Upgrade tapped for order ${petId ?? 'No Pet ID'} and clinic ${clinicId ?? 'No Clinic ID'}',
    );
    log('Upgrade tapped for order ${item.toString()}');
    if (petId == null || clinicId == null) {
      // ignore: prefer_single_quotes
      const SnackBar(content: Text('Invalid subscription details'));
      return;
    }

    final List<UserPet> pets = context.read<UserProfileBloc>().state.pets;

    final List<Pet> petsList = pets.map((userPet) {
      return Pet(
        id: userPet.id,
        name: userPet.name,
        imageUrl: userPet.profilePicture ?? '',
        isSelected: petId == userPet.id,
      );
    }).toList();

    final bool isPetValid = petsList.any((p) => p.id == petId);

    if (!isPetValid) {
      // ignore: prefer_single_quotes
      const SnackBar(content: Text('Pet does not belong to you'));
      return;
    }

    /// If pet exists but not found in user list
    Pet? selectedUserPet;

    try {
      selectedUserPet = petsList.firstWhere((p) => p.id == petId);
    } catch (e) {
      selectedUserPet = null;
    }

    final appointmentCubit = getIt<AppointmentCubit>();

    /// Start fresh booking flow
    appointmentCubit.reset();

    /// Save clinic
    appointmentCubit.updateClinic(clinicId: clinicId);

    /// Save pet
    appointmentCubit.updatePet(
      petId: selectedUserPet?.id,
      petName: selectedUserPet?.name,
      petImage: selectedUserPet?.imageUrl,
      petNotes: '',
    );

    context.router.push(ClinicPlanSelectionRoute(clinicId: clinicId));
  }
}
