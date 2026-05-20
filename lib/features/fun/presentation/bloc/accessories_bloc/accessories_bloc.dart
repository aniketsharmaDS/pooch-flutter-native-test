import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/utils/app_extensions/string_capitalise_extension.dart';
import 'package:poochcare/features/fun/data/models/accessory_my_accessories_response_model.dart';
import 'package:poochcare/features/fun/presentation/bloc/accessories_bloc/accessories_event.dart';
import 'package:poochcare/features/fun/presentation/bloc/accessories_bloc/accessories_state.dart';
import 'package:poochcare/features/fun/presentation/widgets/accessories_widget.dart';
import 'package:poochcare/features/fun/repository/accessories_repository.dart';

class AccessoriesBloc extends Bloc<AccessoriesEvent, AccessoriesState> {
  final AccessoriesRepository repository;

  AccessoriesBloc(this.repository) : super(const AccessoriesState()) {
    on<FetchAccessoriesEvent>(_onFetchAccessories);
    on<FetchMyAccessoriesEvent>(_onFetchMyAccessories);
  }

  Future<void> _onFetchAccessories(
    FetchAccessoriesEvent event,
    Emitter<AccessoriesState> emit,
  ) async {
    emit(state.copyWith(status: AccessoriesStatus.loading));
    final accessoriesData = await repository.getMarketplaceAccessories(
      couponCode: event.couponCode,
      page: event.page ?? 1,
    );
    final accessories = (accessoriesData.accessories).map((e) {
      return Accessory(
        currency: e.currency.toUpperCase(),
        name: e.accessoryCategory.capitalize(),
        price: e.price.toDouble(),
        imageUrl: e.thumbnail,
        id: e.id,
      );
    }).toList();

    emit(
      state.copyWith(
        status: AccessoriesStatus.success,
        accessoriesData: accessoriesData,
        accessories: accessories,
      ),
    );

    try {} catch (e) {
      emit(
        state.copyWith(
          status: AccessoriesStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onFetchMyAccessories(
    FetchMyAccessoriesEvent event,
    Emitter<AccessoriesState> emit,
  ) async {
    emit(state.copyWith(myAccessoriesStatus: MyAccessoriesStatus.loading));
    final accessoriesData = await repository.getMyAccessories();
    final accessories = (accessoriesData.accessories).map((e) {
      AccessoryOrderItemModel? item = e.items.isNotEmpty ? e.items.first : null;
      return Accessory(
        currency: item?.currency.toUpperCase() ?? '',
        name: (item?.accessory.accessoryCategory ?? 'N/A').capitalize(),
        price: double.parse(item?.price ?? '0'),
        imageUrl: item?.accessory.thumbnail,
        id: item?.id ?? '',
      );
    }).toList();
    emit(
      state.copyWith(
        myAccessoriesStatus: MyAccessoriesStatus.success,
        myAccessoriesData: accessoriesData,
        myAccessories: accessories,
      ),
    );

    try {} catch (e) {
      emit(
        state.copyWith(
          myAccessoriesStatus: MyAccessoriesStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
