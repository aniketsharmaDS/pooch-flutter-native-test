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
  final int currentPage;
  final int totalPages;
  final bool hasReachedMax;
  final int yourAccessoriesCurrentPage;
  final int yourAccessoriesTotalPages;
  final bool yourAccessoriesHasReachedMax;
  final String? selectedAccessoryId;

  const AccessoriesState({
    this.status = AccessoriesStatus.initial,
    this.errorMessage = '',
    this.successMessage = '',
    this.accessoriesData,
    this.myAccessoriesData,
    this.myAccessoriesStatus = MyAccessoriesStatus.initial,
    this.accessories = const [],
    this.myAccessories = const [],
    this.currentPage = 1,
    this.totalPages = 1,
    this.hasReachedMax = false,
    this.selectedAccessoryId,
    this.yourAccessoriesCurrentPage = 1,
    this.yourAccessoriesHasReachedMax = false,
    this.yourAccessoriesTotalPages = 1,
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
    int? totalPages,
    String? selectedAccessoryId,
    int? yourAccessoriesCurrentPage,
    int? yourAccessoriesTotalPages,
    bool? yourAccessoriesHasReachedMax,
  }) {
    return AccessoriesState(
      yourAccessoriesCurrentPage:
          yourAccessoriesCurrentPage ?? this.yourAccessoriesCurrentPage,
      yourAccessoriesHasReachedMax:
          yourAccessoriesHasReachedMax ?? this.yourAccessoriesHasReachedMax,
      yourAccessoriesTotalPages:
          yourAccessoriesTotalPages ?? this.yourAccessoriesTotalPages,
      myAccessories: myAccessories ?? this.myAccessories,
      accessories: accessories ?? this.accessories,
      myAccessoriesStatus: myAccessoriesStatus ?? this.myAccessoriesStatus,
      myAccessoriesData: myAccessoriesData ?? this.myAccessoriesData,
      accessoriesData: accessoriesData ?? this.accessoriesData,
      status: status ?? this.status,
      errorMessage: errorMessage,
      successMessage: successMessage,
      totalPages: totalPages ?? this.totalPages,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      selectedAccessoryId: selectedAccessoryId,
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
    currentPage,
    totalPages,
    hasReachedMax,
    selectedAccessoryId,
  ];
}
