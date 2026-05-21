import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/utils/app_extensions/string_capitalise_extension.dart';
import 'package:poochcare/features/fun/presentation/bloc/accessories_bloc/accessories_event.dart';
import 'package:poochcare/features/fun/presentation/bloc/accessories_bloc/accessories_state.dart';
import 'package:poochcare/features/fun/presentation/widgets/accessories_widget.dart';
import 'package:poochcare/features/fun/repository/accessories_repository.dart';

class AccessoriesBloc extends Bloc<AccessoriesEvent, AccessoriesState> {
  final AccessoriesRepository repository;

  AccessoriesBloc(this.repository) : super(const AccessoriesState()) {
    on<FetchAccessoriesEvent>(_onFetchAccessories);
    on<FetchMyAccessoriesEvent>(_onFetchMyAccessories);
    on<SelectAccessoriesItemEvent>(_onSelectedAccessory);
  }

  Future<void> _onFetchAccessories(
    FetchAccessoriesEvent event,
    Emitter<AccessoriesState> emit,
  ) async {
    if (state.hasReachedMax || state.status == AccessoriesStatus.loading) {
      return;
    }
    emit(state.copyWith(status: AccessoriesStatus.loading));

    final accessoriesData = await repository.getMarketplaceAccessories(
      couponCode: event.couponCode,
      page: state.currentPage,
    );

    final isLastPage =
        accessoriesData.pagination.currentPage >=
        accessoriesData.pagination.totalPages;
    final updatedItems = List<Accessory>.from(state.accessories)
      ..addAll(
        (accessoriesData.accessories).map((e) {
          return Accessory(
            currency: e.currency.toUpperCase(),
            name: e.accessoryCategory.capitalize(),
            price: e.price.toDouble(),
            imageUrl: e.thumbnail,
            id: e.id,
          );
        }),
      );
    emit(
      state.copyWith(
        status: AccessoriesStatus.success,
        accessoriesData: accessoriesData,
        accessories: updatedItems,
        currentPage:
            accessoriesData.pagination.currentPage +
            1, // Advance pointer for next call
        totalPages: accessoriesData.pagination.totalPages,
        hasReachedMax: isLastPage,
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
    if (state.yourAccessoriesHasReachedMax ||
        state.myAccessoriesStatus == MyAccessoriesStatus.loading) {
      return;
    }
    emit(state.copyWith(myAccessoriesStatus: MyAccessoriesStatus.loading));
    final accessoriesData = await repository.getMyAccessories(
      page: state.yourAccessoriesCurrentPage,
    );
    final isLastPage =
        accessoriesData.pagination.page >=
        accessoriesData.pagination.totalPages;
    // final accessories = (accessoriesData.accessories).map((e) {
    //   AccessoryOrderItemModel? item = e.items.isNotEmpty ? e.items.first : null;
    //   return Accessory(
    //     currency: item?.currency.toUpperCase() ?? '',
    //     name: (item?.accessory.accessoryCategory ?? 'N/A').capitalize(),
    //     price: double.parse(item?.price ?? '0'),
    //     imageUrl: item?.accessory.thumbnail,
    //     id: item?.id ?? '',
    //   );
    // }).toList();

    final updatedItems = List<Accessory>.from(state.accessories)
      ..addAll(
        (accessoriesData.accessories).map((e) {
          final item = e.items.isNotEmpty ? e.items.first : null;
          return Accessory(
            currency: (item?.currency ?? '').toUpperCase(),
            name: (item?.accessory.accessoryCategory ?? '').capitalize(),
            price: double.tryParse(item?.price ?? '0') ?? 0.0,
            imageUrl: item?.accessory.thumbnail ?? '',
            id: item?.accessory.id ?? '',
          );
        }),
      );
    emit(
      state.copyWith(
        yourAccessoriesCurrentPage: state.yourAccessoriesCurrentPage + 1,
        yourAccessoriesHasReachedMax: isLastPage,
        yourAccessoriesTotalPages: accessoriesData.pagination.totalPages,
        myAccessoriesStatus: MyAccessoriesStatus.success,
        myAccessoriesData: accessoriesData,
        myAccessories: updatedItems,
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

  FutureOr<void> _onSelectedAccessory(
    SelectAccessoriesItemEvent event,
    Emitter<AccessoriesState> emit,
  ) {
    emit(state.copyWith(selectedAccessoryId: event.accessoryId));
  }
}
