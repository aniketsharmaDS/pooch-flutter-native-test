import 'package:equatable/equatable.dart';
import 'package:poochcare/features/fun/data/models/accessory_marketplace_response_model.dart';
import 'package:poochcare/features/fun/data/models/accessory_my_accessories_response_model.dart';
import 'package:poochcare/features/fun/presentation/widgets/accessories_widget.dart';
import 'package:poochcare/features/insight/data/models/subscribed_clinics_response_model.dart';

enum AccessoriesStatus { initial, loading, success, failure }

enum MyAccessoriesStatus { initial, loading, success, failure }

class AccessoriesState extends Equatable {
  final AccessoriesStatus status;
  final MyAccessoriesStatus myAccessoriesStatus;
  final String? errorMessage;
  final String? successMessage;
  final AccessoryMarketplaceResponseModel? accessoriesData;
  final List<Accessory> accessories;
  final List<Accessory> myAccessories;
  final MyAccessoriesResponseModel? myAccessoriesData;
  const AccessoriesState({
    this.status = AccessoriesStatus.initial,
    this.errorMessage = '',
    this.successMessage = '',
    this.accessoriesData,
    this.myAccessoriesData,
    this.myAccessoriesStatus = MyAccessoriesStatus.initial,
    this.accessories = const [],
    this.myAccessories = const [],
  });

  AccessoriesState copyWith({
    AccessoriesStatus? status,
    MyAccessoriesStatus? myAccessoriesStatus,
    String? errorMessage,
    String? successMessage,
    SubscribedClinicsResponseModel? subscribedClinicsData,
    int? currentPage,
    bool? hasReachedMax,
    AccessoryMarketplaceResponseModel? accessoriesData,
    MyAccessoriesResponseModel? myAccessoriesData,
    List<Accessory>? accessories,
    List<Accessory>? myAccessories,
  }) {
    return AccessoriesState(
      myAccessories: myAccessories ?? this.myAccessories,
      accessories: accessories ?? this.accessories,
      myAccessoriesStatus: myAccessoriesStatus ?? this.myAccessoriesStatus,
      myAccessoriesData: myAccessoriesData ?? this.myAccessoriesData,
      accessoriesData: accessoriesData ?? this.accessoriesData,
      status: status ?? this.status,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    successMessage,
    accessoriesData,
    myAccessoriesData,
    myAccessoriesStatus,
    accessories,
    myAccessories,
  ];
}
