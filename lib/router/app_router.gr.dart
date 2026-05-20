// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AccessoriesScreen]
class AccessoriesRoute extends PageRouteInfo<AccessoriesRouteArgs> {
  AccessoriesRoute({
    Key? key,
    String? couponCode,
    List<PageRouteInfo>? children,
  }) : super(
         AccessoriesRoute.name,
         args: AccessoriesRouteArgs(key: key, couponCode: couponCode),
         initialChildren: children,
       );

  static const String name = 'AccessoriesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AccessoriesRouteArgs>(
        orElse: () => const AccessoriesRouteArgs(),
      );
      return WrappedRoute(
        child: AccessoriesScreen(key: args.key, couponCode: args.couponCode),
      );
    },
  );
}

class AccessoriesRouteArgs {
  const AccessoriesRouteArgs({this.key, this.couponCode});

  final Key? key;

  final String? couponCode;

  @override
  String toString() {
    return 'AccessoriesRouteArgs{key: $key, couponCode: $couponCode}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AccessoriesRouteArgs) return false;
    return key == other.key && couponCode == other.couponCode;
  }

  @override
  int get hashCode => key.hashCode ^ couponCode.hashCode;
}

/// generated route for
/// [AccessoryOrderSummaryScreen]
class AccessoryOrderSummaryRoute
    extends PageRouteInfo<AccessoryOrderSummaryRouteArgs> {
  AccessoryOrderSummaryRoute({
    Key? key,
    String? couponCode,
    required String accessoryId,
    required String petId,
    List<PageRouteInfo>? children,
  }) : super(
         AccessoryOrderSummaryRoute.name,
         args: AccessoryOrderSummaryRouteArgs(
           key: key,
           couponCode: couponCode,
           accessoryId: accessoryId,
           petId: petId,
         ),
         initialChildren: children,
       );

  static const String name = 'AccessoryOrderSummaryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AccessoryOrderSummaryRouteArgs>();
      return WrappedRoute(
        child: AccessoryOrderSummaryScreen(
          key: args.key,
          couponCode: args.couponCode,
          accessoryId: args.accessoryId,
          petId: args.petId,
        ),
      );
    },
  );
}

class AccessoryOrderSummaryRouteArgs {
  const AccessoryOrderSummaryRouteArgs({
    this.key,
    this.couponCode,
    required this.accessoryId,
    required this.petId,
  });

  final Key? key;

  final String? couponCode;

  final String accessoryId;

  final String petId;

  @override
  String toString() {
    return 'AccessoryOrderSummaryRouteArgs{key: $key, couponCode: $couponCode, accessoryId: $accessoryId, petId: $petId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AccessoryOrderSummaryRouteArgs) return false;
    return key == other.key &&
        couponCode == other.couponCode &&
        accessoryId == other.accessoryId &&
        petId == other.petId;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      couponCode.hashCode ^
      accessoryId.hashCode ^
      petId.hashCode;
}

/// generated route for
/// [AddNewAddressScreen]
class AddNewAddressRoute extends PageRouteInfo<AddNewAddressRouteArgs> {
  AddNewAddressRoute({
    Address? address,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         AddNewAddressRoute.name,
         args: AddNewAddressRouteArgs(address: address, key: key),
         initialChildren: children,
       );

  static const String name = 'AddNewAddressRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddNewAddressRouteArgs>(
        orElse: () => const AddNewAddressRouteArgs(),
      );
      return AddNewAddressScreen(address: args.address, key: args.key);
    },
  );
}

class AddNewAddressRouteArgs {
  const AddNewAddressRouteArgs({this.address, this.key});

  final Address? address;

  final Key? key;

  @override
  String toString() {
    return 'AddNewAddressRouteArgs{address: $address, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AddNewAddressRouteArgs) return false;
    return address == other.address && key == other.key;
  }

  @override
  int get hashCode => address.hashCode ^ key.hashCode;
}

/// generated route for
/// [AddPetFoundScreen]
class AddPetFoundRoute extends PageRouteInfo<void> {
  const AddPetFoundRoute({List<PageRouteInfo>? children})
    : super(AddPetFoundRoute.name, initialChildren: children);

  static const String name = 'AddPetFoundRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AddPetFoundScreen();
    },
  );
}

/// generated route for
/// [AddPetMedicalRecordsTabScreen]
class AddPetMedicalRecordsTabRoute extends PageRouteInfo<void> {
  const AddPetMedicalRecordsTabRoute({List<PageRouteInfo>? children})
    : super(AddPetMedicalRecordsTabRoute.name, initialChildren: children);

  static const String name = 'AddPetMedicalRecordsTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AddPetMedicalRecordsTabScreen();
    },
  );
}

/// generated route for
/// [AddPetProfileScreen]
class AddPetProfileRoute extends PageRouteInfo<void> {
  const AddPetProfileRoute({List<PageRouteInfo>? children})
    : super(AddPetProfileRoute.name, initialChildren: children);

  static const String name = 'AddPetProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AddPetProfileScreen();
    },
  );
}

/// generated route for
/// [AddScheduleScreen]
class AddScheduleRoute extends PageRouteInfo<AddScheduleRouteArgs> {
  AddScheduleRoute({
    Key? key,
    ScheduleItemUIModel? initialItem,
    DateTime? initialDate,
    bool isEditing = false,
    List<PageRouteInfo>? children,
  }) : super(
         AddScheduleRoute.name,
         args: AddScheduleRouteArgs(
           key: key,
           initialItem: initialItem,
           initialDate: initialDate,
           isEditing: isEditing,
         ),
         initialChildren: children,
       );

  static const String name = 'AddScheduleRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddScheduleRouteArgs>(
        orElse: () => const AddScheduleRouteArgs(),
      );
      return AddScheduleScreen(
        key: args.key,
        initialItem: args.initialItem,
        initialDate: args.initialDate,
        isEditing: args.isEditing,
      );
    },
  );
}

class AddScheduleRouteArgs {
  const AddScheduleRouteArgs({
    this.key,
    this.initialItem,
    this.initialDate,
    this.isEditing = false,
  });

  final Key? key;

  final ScheduleItemUIModel? initialItem;

  final DateTime? initialDate;

  final bool isEditing;

  @override
  String toString() {
    return 'AddScheduleRouteArgs{key: $key, initialItem: $initialItem, initialDate: $initialDate, isEditing: $isEditing}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AddScheduleRouteArgs) return false;
    return key == other.key &&
        initialItem == other.initialItem &&
        initialDate == other.initialDate &&
        isEditing == other.isEditing;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      initialItem.hashCode ^
      initialDate.hashCode ^
      isEditing.hashCode;
}

/// generated route for
/// [AllCommunityEventsListScreen]
class AllCommunityEventsListRoute extends PageRouteInfo<void> {
  const AllCommunityEventsListRoute({List<PageRouteInfo>? children})
    : super(AllCommunityEventsListRoute.name, initialChildren: children);

  static const String name = 'AllCommunityEventsListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const AllCommunityEventsListScreen());
    },
  );
}

/// generated route for
/// [AllCommunityTipsGuideListScreen]
class AllCommunityTipsGuideListRoute extends PageRouteInfo<void> {
  const AllCommunityTipsGuideListRoute({List<PageRouteInfo>? children})
    : super(AllCommunityTipsGuideListRoute.name, initialChildren: children);

  static const String name = 'AllCommunityTipsGuideListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const AllCommunityTipsGuideListScreen());
    },
  );
}

/// generated route for
/// [AllFoundPoochListScreen]
class AllFoundPoochListRoute extends PageRouteInfo<void> {
  const AllFoundPoochListRoute({List<PageRouteInfo>? children})
    : super(AllFoundPoochListRoute.name, initialChildren: children);

  static const String name = 'AllFoundPoochListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const AllFoundPoochListScreen());
    },
  );
}

/// generated route for
/// [AllInvitesScreen]
class AllInvitesRoute extends PageRouteInfo<void> {
  const AllInvitesRoute({List<PageRouteInfo>? children})
    : super(AllInvitesRoute.name, initialChildren: children);

  static const String name = 'AllInvitesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AllInvitesScreen();
    },
  );
}

/// generated route for
/// [AllMissingPoochListScreen]
class AllMissingPoochListRoute
    extends PageRouteInfo<AllMissingPoochListRouteArgs> {
  AllMissingPoochListRoute({
    Key? key,
    String listType = 'default',
    String? petType,
    String? petGender,
    List<PageRouteInfo>? children,
  }) : super(
         AllMissingPoochListRoute.name,
         args: AllMissingPoochListRouteArgs(
           key: key,
           listType: listType,
           petType: petType,
           petGender: petGender,
         ),
         initialChildren: children,
       );

  static const String name = 'AllMissingPoochListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AllMissingPoochListRouteArgs>(
        orElse: () => const AllMissingPoochListRouteArgs(),
      );
      return WrappedRoute(
        child: AllMissingPoochListScreen(
          key: args.key,
          listType: args.listType,
          petType: args.petType,
          petGender: args.petGender,
        ),
      );
    },
  );
}

class AllMissingPoochListRouteArgs {
  const AllMissingPoochListRouteArgs({
    this.key,
    this.listType = 'default',
    this.petType,
    this.petGender,
  });

  final Key? key;

  final String listType;

  final String? petType;

  final String? petGender;

  @override
  String toString() {
    return 'AllMissingPoochListRouteArgs{key: $key, listType: $listType, petType: $petType, petGender: $petGender}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AllMissingPoochListRouteArgs) return false;
    return key == other.key &&
        listType == other.listType &&
        petType == other.petType &&
        petGender == other.petGender;
  }

  @override
  int get hashCode =>
      key.hashCode ^ listType.hashCode ^ petType.hashCode ^ petGender.hashCode;
}

/// generated route for
/// [AllSubscribedClinicsScreen]
class AllSubscribedClinicsRoute extends PageRouteInfo<void> {
  const AllSubscribedClinicsRoute({List<PageRouteInfo>? children})
    : super(AllSubscribedClinicsRoute.name, initialChildren: children);

  static const String name = 'AllSubscribedClinicsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AllSubscribedClinicsScreen();
    },
  );
}

/// generated route for
/// [AppButtonScreen]
class AppButtonRoute extends PageRouteInfo<void> {
  const AppButtonRoute({List<PageRouteInfo>? children})
    : super(AppButtonRoute.name, initialChildren: children);

  static const String name = 'AppButtonRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppButtonScreen();
    },
  );
}

/// generated route for
/// [AppDesignScreen]
class AppDesignRoute extends PageRouteInfo<void> {
  const AppDesignRoute({List<PageRouteInfo>? children})
    : super(AppDesignRoute.name, initialChildren: children);

  static const String name = 'AppDesignRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppDesignScreen();
    },
  );
}

/// generated route for
/// [AppDisplayScreen]
class AppDisplayRoute extends PageRouteInfo<void> {
  const AppDisplayRoute({List<PageRouteInfo>? children})
    : super(AppDisplayRoute.name, initialChildren: children);

  static const String name = 'AppDisplayRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppDisplayScreen();
    },
  );
}

/// generated route for
/// [AppFormScreen]
class AppFormRoute extends PageRouteInfo<void> {
  const AppFormRoute({List<PageRouteInfo>? children})
    : super(AppFormRoute.name, initialChildren: children);

  static const String name = 'AppFormRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppFormScreen();
    },
  );
}

/// generated route for
/// [AppGridScreen]
class AppGridRoute extends PageRouteInfo<void> {
  const AppGridRoute({List<PageRouteInfo>? children})
    : super(AppGridRoute.name, initialChildren: children);

  static const String name = 'AppGridRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppGridScreen();
    },
  );
}

/// generated route for
/// [AppListItemScreen]
class AppListItemRoute extends PageRouteInfo<void> {
  const AppListItemRoute({List<PageRouteInfo>? children})
    : super(AppListItemRoute.name, initialChildren: children);

  static const String name = 'AppListItemRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppListItemScreen();
    },
  );
}

/// generated route for
/// [AppListScreen]
class AppListRoute extends PageRouteInfo<void> {
  const AppListRoute({List<PageRouteInfo>? children})
    : super(AppListRoute.name, initialChildren: children);

  static const String name = 'AppListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppListScreen();
    },
  );
}

/// generated route for
/// [AppNudgesScreen]
class AppNudgesRoute extends PageRouteInfo<void> {
  const AppNudgesRoute({List<PageRouteInfo>? children})
    : super(AppNudgesRoute.name, initialChildren: children);

  static const String name = 'AppNudgesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppNudgesScreen();
    },
  );
}

/// generated route for
/// [AppTextInputScreen]
class AppTextInputRoute extends PageRouteInfo<void> {
  const AppTextInputRoute({List<PageRouteInfo>? children})
    : super(AppTextInputRoute.name, initialChildren: children);

  static const String name = 'AppTextInputRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppTextInputScreen();
    },
  );
}

/// generated route for
/// [AppTopChipTabBarScreen]
class AppTopChipTabBarRoute extends PageRouteInfo<void> {
  const AppTopChipTabBarRoute({List<PageRouteInfo>? children})
    : super(AppTopChipTabBarRoute.name, initialChildren: children);

  static const String name = 'AppTopChipTabBarRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppTopChipTabBarScreen();
    },
  );
}

/// generated route for
/// [AppTopTabBarScreen]
class AppTopTabBarRoute extends PageRouteInfo<void> {
  const AppTopTabBarRoute({List<PageRouteInfo>? children})
    : super(AppTopTabBarRoute.name, initialChildren: children);

  static const String name = 'AppTopTabBarRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppTopTabBarScreen();
    },
  );
}

/// generated route for
/// [AppointmentBookingSummaryScreen]
class AppointmentBookingSummaryRoute
    extends PageRouteInfo<AppointmentBookingSummaryRouteArgs> {
  AppointmentBookingSummaryRoute({
    required String clinicId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         AppointmentBookingSummaryRoute.name,
         args: AppointmentBookingSummaryRouteArgs(clinicId: clinicId, key: key),
         initialChildren: children,
       );

  static const String name = 'AppointmentBookingSummaryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AppointmentBookingSummaryRouteArgs>();
      return AppointmentBookingSummaryScreen(
        clinicId: args.clinicId,
        key: args.key,
      );
    },
  );
}

class AppointmentBookingSummaryRouteArgs {
  const AppointmentBookingSummaryRouteArgs({required this.clinicId, this.key});

  final String clinicId;

  final Key? key;

  @override
  String toString() {
    return 'AppointmentBookingSummaryRouteArgs{clinicId: $clinicId, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AppointmentBookingSummaryRouteArgs) return false;
    return clinicId == other.clinicId && key == other.key;
  }

  @override
  int get hashCode => clinicId.hashCode ^ key.hashCode;
}

/// generated route for
/// [AppointmentPaymentSummaryScreen]
class AppointmentPaymentSummaryRoute
    extends PageRouteInfo<AppointmentPaymentSummaryRouteArgs> {
  AppointmentPaymentSummaryRoute({
    required String clinicId,
    required String planStatus,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         AppointmentPaymentSummaryRoute.name,
         args: AppointmentPaymentSummaryRouteArgs(
           clinicId: clinicId,
           planStatus: planStatus,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'AppointmentPaymentSummaryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AppointmentPaymentSummaryRouteArgs>();
      return AppointmentPaymentSummaryScreen(
        clinicId: args.clinicId,
        planStatus: args.planStatus,
        key: args.key,
      );
    },
  );
}

class AppointmentPaymentSummaryRouteArgs {
  const AppointmentPaymentSummaryRouteArgs({
    required this.clinicId,
    required this.planStatus,
    this.key,
  });

  final String clinicId;

  final String planStatus;

  final Key? key;

  @override
  String toString() {
    return 'AppointmentPaymentSummaryRouteArgs{clinicId: $clinicId, planStatus: $planStatus, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AppointmentPaymentSummaryRouteArgs) return false;
    return clinicId == other.clinicId &&
        planStatus == other.planStatus &&
        key == other.key;
  }

  @override
  int get hashCode => clinicId.hashCode ^ planStatus.hashCode ^ key.hashCode;
}

/// generated route for
/// [AppointmentTransitionScreen]
class AppointmentTransitionRoute extends PageRouteInfo<void> {
  const AppointmentTransitionRoute({List<PageRouteInfo>? children})
    : super(AppointmentTransitionRoute.name, initialChildren: children);

  static const String name = 'AppointmentTransitionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppointmentTransitionScreen();
    },
  );
}

/// generated route for
/// [AppointmentsTabScreen]
class AppointmentsTabRoute extends PageRouteInfo<void> {
  const AppointmentsTabRoute({List<PageRouteInfo>? children})
    : super(AppointmentsTabRoute.name, initialChildren: children);

  static const String name = 'AppointmentsTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppointmentsTabScreen();
    },
  );
}

/// generated route for
/// [BuyPetDetailScreen]
class BuyPetDetailRoute extends PageRouteInfo<BuyPetDetailRouteArgs> {
  BuyPetDetailRoute({
    Key? key,
    required String productId,
    bool isFromGetHelp = false,
    List<PageRouteInfo>? children,
  }) : super(
         BuyPetDetailRoute.name,
         args: BuyPetDetailRouteArgs(
           key: key,
           productId: productId,
           isFromGetHelp: isFromGetHelp,
         ),
         initialChildren: children,
       );

  static const String name = 'BuyPetDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BuyPetDetailRouteArgs>();
      return BuyPetDetailScreen(
        key: args.key,
        productId: args.productId,
        isFromGetHelp: args.isFromGetHelp,
      );
    },
  );
}

class BuyPetDetailRouteArgs {
  const BuyPetDetailRouteArgs({
    this.key,
    required this.productId,
    this.isFromGetHelp = false,
  });

  final Key? key;

  final String productId;

  final bool isFromGetHelp;

  @override
  String toString() {
    return 'BuyPetDetailRouteArgs{key: $key, productId: $productId, isFromGetHelp: $isFromGetHelp}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BuyPetDetailRouteArgs) return false;
    return key == other.key &&
        productId == other.productId &&
        isFromGetHelp == other.isFromGetHelp;
  }

  @override
  int get hashCode =>
      key.hashCode ^ productId.hashCode ^ isFromGetHelp.hashCode;
}

/// generated route for
/// [BuyPetLandingScreen]
class BuyPetLandingRoute extends PageRouteInfo<void> {
  const BuyPetLandingRoute({List<PageRouteInfo>? children})
    : super(BuyPetLandingRoute.name, initialChildren: children);

  static const String name = 'BuyPetLandingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BuyPetLandingScreen();
    },
  );
}

/// generated route for
/// [BuyPetListingScreen]
class BuyPetListingRoute extends PageRouteInfo<void> {
  const BuyPetListingRoute({List<PageRouteInfo>? children})
    : super(BuyPetListingRoute.name, initialChildren: children);

  static const String name = 'BuyPetListingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BuyPetListingScreen();
    },
  );
}

/// generated route for
/// [CancelOrderTransitionScreen]
class CancelOrderTransitionRoute
    extends PageRouteInfo<CancelOrderTransitionRouteArgs> {
  CancelOrderTransitionRoute({
    Key? key,
    required String orderId,
    required String itemId,
    List<PageRouteInfo>? children,
  }) : super(
         CancelOrderTransitionRoute.name,
         args: CancelOrderTransitionRouteArgs(
           key: key,
           orderId: orderId,
           itemId: itemId,
         ),
         initialChildren: children,
       );

  static const String name = 'CancelOrderTransitionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CancelOrderTransitionRouteArgs>();
      return CancelOrderTransitionScreen(
        key: args.key,
        orderId: args.orderId,
        itemId: args.itemId,
      );
    },
  );
}

class CancelOrderTransitionRouteArgs {
  const CancelOrderTransitionRouteArgs({
    this.key,
    required this.orderId,
    required this.itemId,
  });

  final Key? key;

  final String orderId;

  final String itemId;

  @override
  String toString() {
    return 'CancelOrderTransitionRouteArgs{key: $key, orderId: $orderId, itemId: $itemId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CancelOrderTransitionRouteArgs) return false;
    return key == other.key &&
        orderId == other.orderId &&
        itemId == other.itemId;
  }

  @override
  int get hashCode => key.hashCode ^ orderId.hashCode ^ itemId.hashCode;
}

/// generated route for
/// [CartScreen]
class CartRoute extends PageRouteInfo<CartRouteArgs> {
  CartRoute({Key? key, String? productId, List<PageRouteInfo>? children})
    : super(
        CartRoute.name,
        args: CartRouteArgs(key: key, productId: productId),
        initialChildren: children,
      );

  static const String name = 'CartRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CartRouteArgs>(
        orElse: () => const CartRouteArgs(),
      );
      return CartScreen(key: args.key, productId: args.productId);
    },
  );
}

class CartRouteArgs {
  const CartRouteArgs({this.key, this.productId});

  final Key? key;

  final String? productId;

  @override
  String toString() {
    return 'CartRouteArgs{key: $key, productId: $productId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CartRouteArgs) return false;
    return key == other.key && productId == other.productId;
  }

  @override
  int get hashCode => key.hashCode ^ productId.hashCode;
}

/// generated route for
/// [ChangeLanguageScreen]
class ChangeLanguageRoute extends PageRouteInfo<void> {
  const ChangeLanguageRoute({List<PageRouteInfo>? children})
    : super(ChangeLanguageRoute.name, initialChildren: children);

  static const String name = 'ChangeLanguageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ChangeLanguageScreen();
    },
  );
}

/// generated route for
/// [ClinicDetailsScreen]
class ClinicDetailsRoute extends PageRouteInfo<ClinicDetailsRouteArgs> {
  ClinicDetailsRoute({
    required String clinicId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         ClinicDetailsRoute.name,
         args: ClinicDetailsRouteArgs(clinicId: clinicId, key: key),
         initialChildren: children,
       );

  static const String name = 'ClinicDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ClinicDetailsRouteArgs>();
      return ClinicDetailsScreen(clinicId: args.clinicId, key: args.key);
    },
  );
}

class ClinicDetailsRouteArgs {
  const ClinicDetailsRouteArgs({required this.clinicId, this.key});

  final String clinicId;

  final Key? key;

  @override
  String toString() {
    return 'ClinicDetailsRouteArgs{clinicId: $clinicId, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ClinicDetailsRouteArgs) return false;
    return clinicId == other.clinicId && key == other.key;
  }

  @override
  int get hashCode => clinicId.hashCode ^ key.hashCode;
}

/// generated route for
/// [ClinicPlanSelectionScreen]
class ClinicPlanSelectionRoute
    extends PageRouteInfo<ClinicPlanSelectionRouteArgs> {
  ClinicPlanSelectionRoute({
    required String clinicId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         ClinicPlanSelectionRoute.name,
         args: ClinicPlanSelectionRouteArgs(clinicId: clinicId, key: key),
         initialChildren: children,
       );

  static const String name = 'ClinicPlanSelectionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ClinicPlanSelectionRouteArgs>();
      return ClinicPlanSelectionScreen(clinicId: args.clinicId, key: args.key);
    },
  );
}

class ClinicPlanSelectionRouteArgs {
  const ClinicPlanSelectionRouteArgs({required this.clinicId, this.key});

  final String clinicId;

  final Key? key;

  @override
  String toString() {
    return 'ClinicPlanSelectionRouteArgs{clinicId: $clinicId, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ClinicPlanSelectionRouteArgs) return false;
    return clinicId == other.clinicId && key == other.key;
  }

  @override
  int get hashCode => clinicId.hashCode ^ key.hashCode;
}

/// generated route for
/// [ClinicSlotSelectionScreen]
class ClinicSlotSelectionRoute
    extends PageRouteInfo<ClinicSlotSelectionRouteArgs> {
  ClinicSlotSelectionRoute({
    required String clinicId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         ClinicSlotSelectionRoute.name,
         args: ClinicSlotSelectionRouteArgs(clinicId: clinicId, key: key),
         initialChildren: children,
       );

  static const String name = 'ClinicSlotSelectionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ClinicSlotSelectionRouteArgs>();
      return ClinicSlotSelectionScreen(clinicId: args.clinicId, key: args.key);
    },
  );
}

class ClinicSlotSelectionRouteArgs {
  const ClinicSlotSelectionRouteArgs({required this.clinicId, this.key});

  final String clinicId;

  final Key? key;

  @override
  String toString() {
    return 'ClinicSlotSelectionRouteArgs{clinicId: $clinicId, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ClinicSlotSelectionRouteArgs) return false;
    return clinicId == other.clinicId && key == other.key;
  }

  @override
  int get hashCode => clinicId.hashCode ^ key.hashCode;
}

/// generated route for
/// [ClinicsListingScreen]
class ClinicsListingRoute extends PageRouteInfo<ClinicsListingRouteArgs> {
  ClinicsListingRoute({
    Key? key,
    ClinicType clinicType = ClinicType.normal,
    String? selectedSpecialist,
    String? appBarTitle,
    List<PageRouteInfo>? children,
  }) : super(
         ClinicsListingRoute.name,
         args: ClinicsListingRouteArgs(
           key: key,
           clinicType: clinicType,
           selectedSpecialist: selectedSpecialist,
           appBarTitle: appBarTitle,
         ),
         initialChildren: children,
       );

  static const String name = 'ClinicsListingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ClinicsListingRouteArgs>(
        orElse: () => const ClinicsListingRouteArgs(),
      );
      return ClinicsListingScreen(
        key: args.key,
        clinicType: args.clinicType,
        selectedSpecialist: args.selectedSpecialist,
        appBarTitle: args.appBarTitle,
      );
    },
  );
}

class ClinicsListingRouteArgs {
  const ClinicsListingRouteArgs({
    this.key,
    this.clinicType = ClinicType.normal,
    this.selectedSpecialist,
    this.appBarTitle,
  });

  final Key? key;

  final ClinicType clinicType;

  final String? selectedSpecialist;

  final String? appBarTitle;

  @override
  String toString() {
    return 'ClinicsListingRouteArgs{key: $key, clinicType: $clinicType, selectedSpecialist: $selectedSpecialist, appBarTitle: $appBarTitle}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ClinicsListingRouteArgs) return false;
    return key == other.key &&
        clinicType == other.clinicType &&
        selectedSpecialist == other.selectedSpecialist &&
        appBarTitle == other.appBarTitle;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      clinicType.hashCode ^
      selectedSpecialist.hashCode ^
      appBarTitle.hashCode;
}

/// generated route for
/// [CommonPetListingScreen]
class CommonPetListingRoute extends PageRouteInfo<CommonPetListingRouteArgs> {
  CommonPetListingRoute({
    Key? key,
    required String title,
    required ListingType type,
    String? petType,
    required BuyPetLandingBloc bloc,
    List<PageRouteInfo>? children,
  }) : super(
         CommonPetListingRoute.name,
         args: CommonPetListingRouteArgs(
           key: key,
           title: title,
           type: type,
           petType: petType,
           bloc: bloc,
         ),
         initialChildren: children,
       );

  static const String name = 'CommonPetListingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CommonPetListingRouteArgs>();
      return CommonPetListingScreen(
        key: args.key,
        title: args.title,
        type: args.type,
        petType: args.petType,
        bloc: args.bloc,
      );
    },
  );
}

class CommonPetListingRouteArgs {
  const CommonPetListingRouteArgs({
    this.key,
    required this.title,
    required this.type,
    this.petType,
    required this.bloc,
  });

  final Key? key;

  final String title;

  final ListingType type;

  final String? petType;

  final BuyPetLandingBloc bloc;

  @override
  String toString() {
    return 'CommonPetListingRouteArgs{key: $key, title: $title, type: $type, petType: $petType, bloc: $bloc}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CommonPetListingRouteArgs) return false;
    return key == other.key &&
        title == other.title &&
        type == other.type &&
        petType == other.petType &&
        bloc == other.bloc;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      title.hashCode ^
      type.hashCode ^
      petType.hashCode ^
      bloc.hashCode;
}

/// generated route for
/// [CommunityEventDetailsScreen]
class CommunityEventDetailsRoute
    extends PageRouteInfo<CommunityEventDetailsRouteArgs> {
  CommunityEventDetailsRoute({
    Key? key,
    required String eventId,
    bool? isOwnPost = false,
    List<PageRouteInfo>? children,
  }) : super(
         CommunityEventDetailsRoute.name,
         args: CommunityEventDetailsRouteArgs(
           key: key,
           eventId: eventId,
           isOwnPost: isOwnPost,
         ),
         initialChildren: children,
       );

  static const String name = 'CommunityEventDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CommunityEventDetailsRouteArgs>();
      return WrappedRoute(
        child: CommunityEventDetailsScreen(
          key: args.key,
          eventId: args.eventId,
          isOwnPost: args.isOwnPost,
        ),
      );
    },
  );
}

class CommunityEventDetailsRouteArgs {
  const CommunityEventDetailsRouteArgs({
    this.key,
    required this.eventId,
    this.isOwnPost = false,
  });

  final Key? key;

  final String eventId;

  final bool? isOwnPost;

  @override
  String toString() {
    return 'CommunityEventDetailsRouteArgs{key: $key, eventId: $eventId, isOwnPost: $isOwnPost}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CommunityEventDetailsRouteArgs) return false;
    return key == other.key &&
        eventId == other.eventId &&
        isOwnPost == other.isOwnPost;
  }

  @override
  int get hashCode => key.hashCode ^ eventId.hashCode ^ isOwnPost.hashCode;
}

/// generated route for
/// [CommunityTabScreen]
class CommunityTabRoute extends PageRouteInfo<void> {
  const CommunityTabRoute({List<PageRouteInfo>? children})
    : super(CommunityTabRoute.name, initialChildren: children);

  static const String name = 'CommunityTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CommunityTabScreen();
    },
  );
}

/// generated route for
/// [CommunityTipsGuideDetailsScreen]
class CommunityTipsGuideDetailsRoute
    extends PageRouteInfo<CommunityTipsGuideDetailsRouteArgs> {
  CommunityTipsGuideDetailsRoute({
    Key? key,
    required String tipId,
    bool? isOwnPost = false,
    List<PageRouteInfo>? children,
  }) : super(
         CommunityTipsGuideDetailsRoute.name,
         args: CommunityTipsGuideDetailsRouteArgs(
           key: key,
           tipId: tipId,
           isOwnPost: isOwnPost,
         ),
         initialChildren: children,
       );

  static const String name = 'CommunityTipsGuideDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CommunityTipsGuideDetailsRouteArgs>();
      return WrappedRoute(
        child: CommunityTipsGuideDetailsScreen(
          key: args.key,
          tipId: args.tipId,
          isOwnPost: args.isOwnPost,
        ),
      );
    },
  );
}

class CommunityTipsGuideDetailsRouteArgs {
  const CommunityTipsGuideDetailsRouteArgs({
    this.key,
    required this.tipId,
    this.isOwnPost = false,
  });

  final Key? key;

  final String tipId;

  final bool? isOwnPost;

  @override
  String toString() {
    return 'CommunityTipsGuideDetailsRouteArgs{key: $key, tipId: $tipId, isOwnPost: $isOwnPost}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CommunityTipsGuideDetailsRouteArgs) return false;
    return key == other.key &&
        tipId == other.tipId &&
        isOwnPost == other.isOwnPost;
  }

  @override
  int get hashCode => key.hashCode ^ tipId.hashCode ^ isOwnPost.hashCode;
}

/// generated route for
/// [ConfigurePoochTransitionScreen]
class ConfigurePoochTransitionRoute extends PageRouteInfo<void> {
  const ConfigurePoochTransitionRoute({List<PageRouteInfo>? children})
    : super(ConfigurePoochTransitionRoute.name, initialChildren: children);

  static const String name = 'ConfigurePoochTransitionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ConfigurePoochTransitionScreen();
    },
  );
}

/// generated route for
/// [CouponsScreen]
class CouponsRoute extends PageRouteInfo<void> {
  const CouponsRoute({List<PageRouteInfo>? children})
    : super(CouponsRoute.name, initialChildren: children);

  static const String name = 'CouponsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CouponsScreen();
    },
  );
}

/// generated route for
/// [CreateParentProfileScreen]
class CreateParentProfileRoute
    extends PageRouteInfo<CreateParentProfileRouteArgs> {
  CreateParentProfileRoute({
    Key? key,
    String? nickname,
    List<PageRouteInfo>? children,
  }) : super(
         CreateParentProfileRoute.name,
         args: CreateParentProfileRouteArgs(key: key, nickname: nickname),
         initialChildren: children,
       );

  static const String name = 'CreateParentProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateParentProfileRouteArgs>(
        orElse: () => const CreateParentProfileRouteArgs(),
      );
      return CreateParentProfileScreen(key: args.key, nickname: args.nickname);
    },
  );
}

class CreateParentProfileRouteArgs {
  const CreateParentProfileRouteArgs({this.key, this.nickname});

  final Key? key;

  final String? nickname;

  @override
  String toString() {
    return 'CreateParentProfileRouteArgs{key: $key, nickname: $nickname}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CreateParentProfileRouteArgs) return false;
    return key == other.key && nickname == other.nickname;
  }

  @override
  int get hashCode => key.hashCode ^ nickname.hashCode;
}

/// generated route for
/// [CreatePetProfileScreen]
class CreatePetProfileRoute extends PageRouteInfo<CreatePetProfileRouteArgs> {
  CreatePetProfileRoute({
    Key? key,
    String? initialPhoneNumber,
    String? initialEmail,
    String? initialCountryCode,
    bool isAddPetFlow = false,
    List<PageRouteInfo>? children,
  }) : super(
         CreatePetProfileRoute.name,
         args: CreatePetProfileRouteArgs(
           key: key,
           initialPhoneNumber: initialPhoneNumber,
           initialEmail: initialEmail,
           initialCountryCode: initialCountryCode,
           isAddPetFlow: isAddPetFlow,
         ),
         initialChildren: children,
       );

  static const String name = 'CreatePetProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreatePetProfileRouteArgs>(
        orElse: () => const CreatePetProfileRouteArgs(),
      );
      return WrappedRoute(
        child: CreatePetProfileScreen(
          key: args.key,
          initialPhoneNumber: args.initialPhoneNumber,
          initialEmail: args.initialEmail,
          initialCountryCode: args.initialCountryCode,
          isAddPetFlow: args.isAddPetFlow,
        ),
      );
    },
  );
}

class CreatePetProfileRouteArgs {
  const CreatePetProfileRouteArgs({
    this.key,
    this.initialPhoneNumber,
    this.initialEmail,
    this.initialCountryCode,
    this.isAddPetFlow = false,
  });

  final Key? key;

  final String? initialPhoneNumber;

  final String? initialEmail;

  final String? initialCountryCode;

  final bool isAddPetFlow;

  @override
  String toString() {
    return 'CreatePetProfileRouteArgs{key: $key, initialPhoneNumber: $initialPhoneNumber, initialEmail: $initialEmail, initialCountryCode: $initialCountryCode, isAddPetFlow: $isAddPetFlow}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CreatePetProfileRouteArgs) return false;
    return key == other.key &&
        initialPhoneNumber == other.initialPhoneNumber &&
        initialEmail == other.initialEmail &&
        initialCountryCode == other.initialCountryCode &&
        isAddPetFlow == other.isAddPetFlow;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      initialPhoneNumber.hashCode ^
      initialEmail.hashCode ^
      initialCountryCode.hashCode ^
      isAddPetFlow.hashCode;
}

/// generated route for
/// [DelieveryCompleteTransitionScreen]
class DelieveryCompleteTransitionRoute extends PageRouteInfo<void> {
  const DelieveryCompleteTransitionRoute({List<PageRouteInfo>? children})
    : super(DelieveryCompleteTransitionRoute.name, initialChildren: children);

  static const String name = 'DelieveryCompleteTransitionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DelieveryCompleteTransitionScreen();
    },
  );
}

/// generated route for
/// [EcommerceTransitionScreen]
class EcommerceTransitionRoute extends PageRouteInfo<void> {
  const EcommerceTransitionRoute({List<PageRouteInfo>? children})
    : super(EcommerceTransitionRoute.name, initialChildren: children);

  static const String name = 'EcommerceTransitionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const EcommerceTransitionScreen();
    },
  );
}

/// generated route for
/// [EditParentProfileScreen]
class EditParentProfileRoute extends PageRouteInfo<EditParentProfileRouteArgs> {
  EditParentProfileRoute({
    Key? key,
    required UserProfile profile,
    List<PageRouteInfo>? children,
  }) : super(
         EditParentProfileRoute.name,
         args: EditParentProfileRouteArgs(key: key, profile: profile),
         initialChildren: children,
       );

  static const String name = 'EditParentProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditParentProfileRouteArgs>();
      return WrappedRoute(
        child: EditParentProfileScreen(key: args.key, profile: args.profile),
      );
    },
  );
}

class EditParentProfileRouteArgs {
  const EditParentProfileRouteArgs({this.key, required this.profile});

  final Key? key;

  final UserProfile profile;

  @override
  String toString() {
    return 'EditParentProfileRouteArgs{key: $key, profile: $profile}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EditParentProfileRouteArgs) return false;
    return key == other.key && profile == other.profile;
  }

  @override
  int get hashCode => key.hashCode ^ profile.hashCode;
}

/// generated route for
/// [EditPetProfileScreen]
class EditPetProfileRoute extends PageRouteInfo<EditPetProfileRouteArgs> {
  EditPetProfileRoute({
    Key? key,
    required UserPet pet,
    List<PageRouteInfo>? children,
  }) : super(
         EditPetProfileRoute.name,
         args: EditPetProfileRouteArgs(key: key, pet: pet),
         initialChildren: children,
       );

  static const String name = 'EditPetProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditPetProfileRouteArgs>();
      return WrappedRoute(
        child: EditPetProfileScreen(key: args.key, pet: args.pet),
      );
    },
  );
}

class EditPetProfileRouteArgs {
  const EditPetProfileRouteArgs({this.key, required this.pet});

  final Key? key;

  final UserPet pet;

  @override
  String toString() {
    return 'EditPetProfileRouteArgs{key: $key, pet: $pet}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EditPetProfileRouteArgs) return false;
    return key == other.key && pet == other.pet;
  }

  @override
  int get hashCode => key.hashCode ^ pet.hashCode;
}

/// generated route for
/// [EventsListScreen]
class EventsListRoute extends PageRouteInfo<void> {
  const EventsListRoute({List<PageRouteInfo>? children})
    : super(EventsListRoute.name, initialChildren: children);

  static const String name = 'EventsListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const EventsListScreen();
    },
  );
}

/// generated route for
/// [ExpenseTrackerDetailsScreen]
class ExpenseTrackerDetailsRoute
    extends PageRouteInfo<ExpenseTrackerDetailsRouteArgs> {
  ExpenseTrackerDetailsRoute({
    Key? key,
    int? month,
    required int year,
    required String type,
    String? petId,
    List<PageRouteInfo>? children,
  }) : super(
         ExpenseTrackerDetailsRoute.name,
         args: ExpenseTrackerDetailsRouteArgs(
           key: key,
           month: month,
           year: year,
           type: type,
           petId: petId,
         ),
         initialChildren: children,
       );

  static const String name = 'ExpenseTrackerDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ExpenseTrackerDetailsRouteArgs>();
      return ExpenseTrackerDetailsScreen(
        key: args.key,
        month: args.month,
        year: args.year,
        type: args.type,
        petId: args.petId,
      );
    },
  );
}

class ExpenseTrackerDetailsRouteArgs {
  const ExpenseTrackerDetailsRouteArgs({
    this.key,
    this.month,
    required this.year,
    required this.type,
    this.petId,
  });

  final Key? key;

  final int? month;

  final int year;

  final String type;

  final String? petId;

  @override
  String toString() {
    return 'ExpenseTrackerDetailsRouteArgs{key: $key, month: $month, year: $year, type: $type, petId: $petId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ExpenseTrackerDetailsRouteArgs) return false;
    return key == other.key &&
        month == other.month &&
        year == other.year &&
        type == other.type &&
        petId == other.petId;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      month.hashCode ^
      year.hashCode ^
      type.hashCode ^
      petId.hashCode;
}

/// generated route for
/// [ExpenseTrackerScreen]
class ExpenseTrackerRoute extends PageRouteInfo<void> {
  const ExpenseTrackerRoute({List<PageRouteInfo>? children})
    : super(ExpenseTrackerRoute.name, initialChildren: children);

  static const String name = 'ExpenseTrackerRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ExpenseTrackerScreen();
    },
  );
}

/// generated route for
/// [FileViewerScreen]
class FileViewerRoute extends PageRouteInfo<FileViewerRouteArgs> {
  FileViewerRoute({
    Key? key,
    required String fileUrl,
    required String reportType,
    List<PageRouteInfo>? children,
  }) : super(
         FileViewerRoute.name,
         args: FileViewerRouteArgs(
           key: key,
           fileUrl: fileUrl,
           reportType: reportType,
         ),
         initialChildren: children,
       );

  static const String name = 'FileViewerRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FileViewerRouteArgs>();
      return FileViewerScreen(
        key: args.key,
        fileUrl: args.fileUrl,
        reportType: args.reportType,
      );
    },
  );
}

class FileViewerRouteArgs {
  const FileViewerRouteArgs({
    this.key,
    required this.fileUrl,
    required this.reportType,
  });

  final Key? key;

  final String fileUrl;

  final String reportType;

  @override
  String toString() {
    return 'FileViewerRouteArgs{key: $key, fileUrl: $fileUrl, reportType: $reportType}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FileViewerRouteArgs) return false;
    return key == other.key &&
        fileUrl == other.fileUrl &&
        reportType == other.reportType;
  }

  @override
  int get hashCode => key.hashCode ^ fileUrl.hashCode ^ reportType.hashCode;
}

/// generated route for
/// [FindVetClinicsScreen]
class FindVetClinicsRoute extends PageRouteInfo<void> {
  const FindVetClinicsRoute({List<PageRouteInfo>? children})
    : super(FindVetClinicsRoute.name, initialChildren: children);

  static const String name = 'FindVetClinicsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FindVetClinicsScreen();
    },
  );
}

/// generated route for
/// [FoundPetDetailsScreen]
class FoundPetDetailsRoute extends PageRouteInfo<FoundPetDetailsRouteArgs> {
  FoundPetDetailsRoute({
    Key? key,
    required String reportId,
    bool? isOwnPost = false,
    String listType = 'default',
    List<PageRouteInfo>? children,
  }) : super(
         FoundPetDetailsRoute.name,
         args: FoundPetDetailsRouteArgs(
           key: key,
           reportId: reportId,
           isOwnPost: isOwnPost,
           listType: listType,
         ),
         initialChildren: children,
       );

  static const String name = 'FoundPetDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FoundPetDetailsRouteArgs>();
      return WrappedRoute(
        child: FoundPetDetailsScreen(
          key: args.key,
          reportId: args.reportId,
          isOwnPost: args.isOwnPost,
          listType: args.listType,
        ),
      );
    },
  );
}

class FoundPetDetailsRouteArgs {
  const FoundPetDetailsRouteArgs({
    this.key,
    required this.reportId,
    this.isOwnPost = false,
    this.listType = 'default',
  });

  final Key? key;

  final String reportId;

  final bool? isOwnPost;

  final String listType;

  @override
  String toString() {
    return 'FoundPetDetailsRouteArgs{key: $key, reportId: $reportId, isOwnPost: $isOwnPost, listType: $listType}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FoundPetDetailsRouteArgs) return false;
    return key == other.key &&
        reportId == other.reportId &&
        isOwnPost == other.isOwnPost &&
        listType == other.listType;
  }

  @override
  int get hashCode =>
      key.hashCode ^ reportId.hashCode ^ isOwnPost.hashCode ^ listType.hashCode;
}

/// generated route for
/// [FoundPoochListScreen]
class FoundPoochListRoute extends PageRouteInfo<void> {
  const FoundPoochListRoute({List<PageRouteInfo>? children})
    : super(FoundPoochListRoute.name, initialChildren: children);

  static const String name = 'FoundPoochListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FoundPoochListScreen();
    },
  );
}

/// generated route for
/// [FunScreen]
class FunRoute extends PageRouteInfo<void> {
  const FunRoute({List<PageRouteInfo>? children})
    : super(FunRoute.name, initialChildren: children);

  static const String name = 'FunRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FunScreen();
    },
  );
}

/// generated route for
/// [GetHelpScreen]
class GetHelpRoute extends PageRouteInfo<void> {
  const GetHelpRoute({List<PageRouteInfo>? children})
    : super(GetHelpRoute.name, initialChildren: children);

  static const String name = 'GetHelpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const GetHelpScreen();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const HomeScreen());
    },
  );
}

/// generated route for
/// [HomeTabScreen]
class HomeTabRoute extends PageRouteInfo<void> {
  const HomeTabRoute({List<PageRouteInfo>? children})
    : super(HomeTabRoute.name, initialChildren: children);

  static const String name = 'HomeTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const HomeTabScreen());
    },
  );
}

/// generated route for
/// [ImageCropScreen]
class ImageCropRoute extends PageRouteInfo<ImageCropRouteArgs> {
  ImageCropRoute({
    Key? key,
    required File imageFile,
    List<PageRouteInfo>? children,
  }) : super(
         ImageCropRoute.name,
         args: ImageCropRouteArgs(key: key, imageFile: imageFile),
         initialChildren: children,
       );

  static const String name = 'ImageCropRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ImageCropRouteArgs>();
      return ImageCropScreen(key: args.key, imageFile: args.imageFile);
    },
  );
}

class ImageCropRouteArgs {
  const ImageCropRouteArgs({this.key, required this.imageFile});

  final Key? key;

  final File imageFile;

  @override
  String toString() {
    return 'ImageCropRouteArgs{key: $key, imageFile: $imageFile}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ImageCropRouteArgs) return false;
    return key == other.key && imageFile == other.imageFile;
  }

  @override
  int get hashCode => key.hashCode ^ imageFile.hashCode;
}

/// generated route for
/// [InsightCareScreen]
class InsightCareRoute extends PageRouteInfo<void> {
  const InsightCareRoute({List<PageRouteInfo>? children})
    : super(InsightCareRoute.name, initialChildren: children);

  static const String name = 'InsightCareRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const InsightCareScreen();
    },
  );
}

/// generated route for
/// [InsightGutScreen]
class InsightGutRoute extends PageRouteInfo<void> {
  const InsightGutRoute({List<PageRouteInfo>? children})
    : super(InsightGutRoute.name, initialChildren: children);

  static const String name = 'InsightGutRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const InsightGutScreen();
    },
  );
}

/// generated route for
/// [InsightPainScreen]
class InsightPainRoute extends PageRouteInfo<void> {
  const InsightPainRoute({List<PageRouteInfo>? children})
    : super(InsightPainRoute.name, initialChildren: children);

  static const String name = 'InsightPainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const InsightPainScreen();
    },
  );
}

/// generated route for
/// [InsightSymptomsScreen]
class InsightSymptomsRoute extends PageRouteInfo<void> {
  const InsightSymptomsRoute({List<PageRouteInfo>? children})
    : super(InsightSymptomsRoute.name, initialChildren: children);

  static const String name = 'InsightSymptomsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const InsightSymptomsScreen();
    },
  );
}

/// generated route for
/// [InsightTabScreen]
class InsightTabRoute extends PageRouteInfo<void> {
  const InsightTabRoute({List<PageRouteInfo>? children})
    : super(InsightTabRoute.name, initialChildren: children);

  static const String name = 'InsightTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const InsightTabScreen();
    },
  );
}

/// generated route for
/// [InsightVetsScreen]
class InsightVetsRoute extends PageRouteInfo<void> {
  const InsightVetsRoute({List<PageRouteInfo>? children})
    : super(InsightVetsRoute.name, initialChildren: children);

  static const String name = 'InsightVetsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const InsightVetsScreen();
    },
  );
}

/// generated route for
/// [IntroScreen]
class IntroRoute extends PageRouteInfo<void> {
  const IntroRoute({List<PageRouteInfo>? children})
    : super(IntroRoute.name, initialChildren: children);

  static const String name = 'IntroRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const IntroScreen();
    },
  );
}

/// generated route for
/// [IntroTransitionScreen]
class IntroTransitionRoute extends PageRouteInfo<void> {
  const IntroTransitionRoute({List<PageRouteInfo>? children})
    : super(IntroTransitionRoute.name, initialChildren: children);

  static const String name = 'IntroTransitionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const IntroTransitionScreen();
    },
  );
}

/// generated route for
/// [InvitesScreen]
class InvitesRoute extends PageRouteInfo<void> {
  const InvitesRoute({List<PageRouteInfo>? children})
    : super(InvitesRoute.name, initialChildren: children);

  static const String name = 'InvitesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const InvitesScreen();
    },
  );
}

/// generated route for
/// [LeaderboardScreen]
class LeaderboardRoute extends PageRouteInfo<void> {
  const LeaderboardRoute({List<PageRouteInfo>? children})
    : super(LeaderboardRoute.name, initialChildren: children);

  static const String name = 'LeaderboardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const LeaderboardScreen());
    },
  );
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const LoginScreen());
    },
  );
}

/// generated route for
/// [MissingBiometricPetFoundScreen]
class MissingBiometricPetFoundRoute
    extends PageRouteInfo<MissingBiometricPetFoundRouteArgs> {
  MissingBiometricPetFoundRoute({
    Key? key,
    required String reportId,
    List<PageRouteInfo>? children,
  }) : super(
         MissingBiometricPetFoundRoute.name,
         args: MissingBiometricPetFoundRouteArgs(key: key, reportId: reportId),
         initialChildren: children,
       );

  static const String name = 'MissingBiometricPetFoundRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MissingBiometricPetFoundRouteArgs>();
      return WrappedRoute(
        child: MissingBiometricPetFoundScreen(
          key: args.key,
          reportId: args.reportId,
        ),
      );
    },
  );
}

class MissingBiometricPetFoundRouteArgs {
  const MissingBiometricPetFoundRouteArgs({this.key, required this.reportId});

  final Key? key;

  final String reportId;

  @override
  String toString() {
    return 'MissingBiometricPetFoundRouteArgs{key: $key, reportId: $reportId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MissingBiometricPetFoundRouteArgs) return false;
    return key == other.key && reportId == other.reportId;
  }

  @override
  int get hashCode => key.hashCode ^ reportId.hashCode;
}

/// generated route for
/// [MissingBiometricPetNotFoundScreen]
class MissingBiometricPetNotFoundRoute
    extends PageRouteInfo<MissingBiometricPetNotFoundRouteArgs> {
  MissingBiometricPetNotFoundRoute({
    Key? key,
    required String reportId,
    List<PageRouteInfo>? children,
  }) : super(
         MissingBiometricPetNotFoundRoute.name,
         args: MissingBiometricPetNotFoundRouteArgs(
           key: key,
           reportId: reportId,
         ),
         initialChildren: children,
       );

  static const String name = 'MissingBiometricPetNotFoundRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MissingBiometricPetNotFoundRouteArgs>();
      return WrappedRoute(
        child: MissingBiometricPetNotFoundScreen(
          key: args.key,
          reportId: args.reportId,
        ),
      );
    },
  );
}

class MissingBiometricPetNotFoundRouteArgs {
  const MissingBiometricPetNotFoundRouteArgs({
    this.key,
    required this.reportId,
  });

  final Key? key;

  final String reportId;

  @override
  String toString() {
    return 'MissingBiometricPetNotFoundRouteArgs{key: $key, reportId: $reportId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MissingBiometricPetNotFoundRouteArgs) return false;
    return key == other.key && reportId == other.reportId;
  }

  @override
  int get hashCode => key.hashCode ^ reportId.hashCode;
}

/// generated route for
/// [MissingPetDetailsScreen]
class MissingPetDetailsRoute extends PageRouteInfo<MissingPetDetailsRouteArgs> {
  MissingPetDetailsRoute({
    Key? key,
    required String reportId,
    bool? isOwnPost = false,
    String listType = 'default',
    List<PageRouteInfo>? children,
  }) : super(
         MissingPetDetailsRoute.name,
         args: MissingPetDetailsRouteArgs(
           key: key,
           reportId: reportId,
           isOwnPost: isOwnPost,
           listType: listType,
         ),
         initialChildren: children,
       );

  static const String name = 'MissingPetDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MissingPetDetailsRouteArgs>();
      return WrappedRoute(
        child: MissingPetDetailsScreen(
          key: args.key,
          reportId: args.reportId,
          isOwnPost: args.isOwnPost,
          listType: args.listType,
        ),
      );
    },
  );
}

class MissingPetDetailsRouteArgs {
  const MissingPetDetailsRouteArgs({
    this.key,
    required this.reportId,
    this.isOwnPost = false,
    this.listType = 'default',
  });

  final Key? key;

  final String reportId;

  final bool? isOwnPost;

  final String listType;

  @override
  String toString() {
    return 'MissingPetDetailsRouteArgs{key: $key, reportId: $reportId, isOwnPost: $isOwnPost, listType: $listType}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MissingPetDetailsRouteArgs) return false;
    return key == other.key &&
        reportId == other.reportId &&
        isOwnPost == other.isOwnPost &&
        listType == other.listType;
  }

  @override
  int get hashCode =>
      key.hashCode ^ reportId.hashCode ^ isOwnPost.hashCode ^ listType.hashCode;
}

/// generated route for
/// [MissingPoochListScreen]
class MissingPoochListRoute extends PageRouteInfo<void> {
  const MissingPoochListRoute({List<PageRouteInfo>? children})
    : super(MissingPoochListRoute.name, initialChildren: children);

  static const String name = 'MissingPoochListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MissingPoochListScreen();
    },
  );
}

/// generated route for
/// [MissingVerifyBiometricScreen]
class MissingVerifyBiometricRoute
    extends PageRouteInfo<MissingVerifyBiometricRouteArgs> {
  MissingVerifyBiometricRoute({
    Key? key,
    required String reportId,
    List<PageRouteInfo>? children,
  }) : super(
         MissingVerifyBiometricRoute.name,
         args: MissingVerifyBiometricRouteArgs(key: key, reportId: reportId),
         initialChildren: children,
       );

  static const String name = 'MissingVerifyBiometricRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MissingVerifyBiometricRouteArgs>();
      return WrappedRoute(
        child: MissingVerifyBiometricScreen(
          key: args.key,
          reportId: args.reportId,
        ),
      );
    },
  );
}

class MissingVerifyBiometricRouteArgs {
  const MissingVerifyBiometricRouteArgs({this.key, required this.reportId});

  final Key? key;

  final String reportId;

  @override
  String toString() {
    return 'MissingVerifyBiometricRouteArgs{key: $key, reportId: $reportId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MissingVerifyBiometricRouteArgs) return false;
    return key == other.key && reportId == other.reportId;
  }

  @override
  int get hashCode => key.hashCode ^ reportId.hashCode;
}

/// generated route for
/// [MyCommunityHomeScreen]
class MyCommunityHomeRoute extends PageRouteInfo<MyCommunityHomeRouteArgs> {
  MyCommunityHomeRoute({
    Key? key,
    int initialTabIndex = 0,
    List<PageRouteInfo>? children,
  }) : super(
         MyCommunityHomeRoute.name,
         args: MyCommunityHomeRouteArgs(
           key: key,
           initialTabIndex: initialTabIndex,
         ),
         initialChildren: children,
       );

  static const String name = 'MyCommunityHomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MyCommunityHomeRouteArgs>(
        orElse: () => const MyCommunityHomeRouteArgs(),
      );
      return WrappedRoute(
        child: MyCommunityHomeScreen(
          key: args.key,
          initialTabIndex: args.initialTabIndex,
        ),
      );
    },
  );
}

class MyCommunityHomeRouteArgs {
  const MyCommunityHomeRouteArgs({this.key, this.initialTabIndex = 0});

  final Key? key;

  final int initialTabIndex;

  @override
  String toString() {
    return 'MyCommunityHomeRouteArgs{key: $key, initialTabIndex: $initialTabIndex}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MyCommunityHomeRouteArgs) return false;
    return key == other.key && initialTabIndex == other.initialTabIndex;
  }

  @override
  int get hashCode => key.hashCode ^ initialTabIndex.hashCode;
}

/// generated route for
/// [MyEventFormScreen]
class MyEventFormRoute extends PageRouteInfo<MyEventFormRouteArgs> {
  MyEventFormRoute({
    Key? key,
    required MyEventFormType type,
    String? eventId,
    List<PageRouteInfo>? children,
  }) : super(
         MyEventFormRoute.name,
         args: MyEventFormRouteArgs(key: key, type: type, eventId: eventId),
         initialChildren: children,
       );

  static const String name = 'MyEventFormRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MyEventFormRouteArgs>();
      return WrappedRoute(
        child: MyEventFormScreen(
          key: args.key,
          type: args.type,
          eventId: args.eventId,
        ),
      );
    },
  );
}

class MyEventFormRouteArgs {
  const MyEventFormRouteArgs({this.key, required this.type, this.eventId});

  final Key? key;

  final MyEventFormType type;

  final String? eventId;

  @override
  String toString() {
    return 'MyEventFormRouteArgs{key: $key, type: $type, eventId: $eventId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MyEventFormRouteArgs) return false;
    return key == other.key && type == other.type && eventId == other.eventId;
  }

  @override
  int get hashCode => key.hashCode ^ type.hashCode ^ eventId.hashCode;
}

/// generated route for
/// [MyInvitesScreen]
class MyInvitesRoute extends PageRouteInfo<void> {
  const MyInvitesRoute({List<PageRouteInfo>? children})
    : super(MyInvitesRoute.name, initialChildren: children);

  static const String name = 'MyInvitesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const MyInvitesScreen());
    },
  );
}

/// generated route for
/// [MyPostLiveTabScreen]
class MyPostLiveTabRoute extends PageRouteInfo<void> {
  const MyPostLiveTabRoute({List<PageRouteInfo>? children})
    : super(MyPostLiveTabRoute.name, initialChildren: children);

  static const String name = 'MyPostLiveTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const MyPostLiveTabScreen());
    },
  );
}

/// generated route for
/// [MyPostReviewTabScreen]
class MyPostReviewTabRoute extends PageRouteInfo<void> {
  const MyPostReviewTabRoute({List<PageRouteInfo>? children})
    : super(MyPostReviewTabRoute.name, initialChildren: children);

  static const String name = 'MyPostReviewTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const MyPostReviewTabScreen());
    },
  );
}

/// generated route for
/// [MyPostTabScreen]
class MyPostTabRoute extends PageRouteInfo<MyPostTabRouteArgs> {
  MyPostTabRoute({
    Key? key,
    int initialIndex = 0,
    List<PageRouteInfo>? children,
  }) : super(
         MyPostTabRoute.name,
         args: MyPostTabRouteArgs(key: key, initialIndex: initialIndex),
         initialChildren: children,
       );

  static const String name = 'MyPostTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MyPostTabRouteArgs>(
        orElse: () => const MyPostTabRouteArgs(),
      );
      return MyPostTabScreen(key: args.key, initialIndex: args.initialIndex);
    },
  );
}

class MyPostTabRouteArgs {
  const MyPostTabRouteArgs({this.key, this.initialIndex = 0});

  final Key? key;

  final int initialIndex;

  @override
  String toString() {
    return 'MyPostTabRouteArgs{key: $key, initialIndex: $initialIndex}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MyPostTabRouteArgs) return false;
    return key == other.key && initialIndex == other.initialIndex;
  }

  @override
  int get hashCode => key.hashCode ^ initialIndex.hashCode;
}

/// generated route for
/// [MyPostedAllScreen]
class MyPostedAllRoute extends PageRouteInfo<void> {
  const MyPostedAllRoute({List<PageRouteInfo>? children})
    : super(MyPostedAllRoute.name, initialChildren: children);

  static const String name = 'MyPostedAllRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const MyPostedAllScreen());
    },
  );
}

/// generated route for
/// [MyPostedEventsScreen]
class MyPostedEventsRoute extends PageRouteInfo<void> {
  const MyPostedEventsRoute({List<PageRouteInfo>? children})
    : super(MyPostedEventsRoute.name, initialChildren: children);

  static const String name = 'MyPostedEventsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const MyPostedEventsScreen());
    },
  );
}

/// generated route for
/// [MyPostedFoundPetsScreen]
class MyPostedFoundPetsRoute extends PageRouteInfo<void> {
  const MyPostedFoundPetsRoute({List<PageRouteInfo>? children})
    : super(MyPostedFoundPetsRoute.name, initialChildren: children);

  static const String name = 'MyPostedFoundPetsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const MyPostedFoundPetsScreen());
    },
  );
}

/// generated route for
/// [MyPostedMissingPetsScreen]
class MyPostedMissingPetsRoute extends PageRouteInfo<void> {
  const MyPostedMissingPetsRoute({List<PageRouteInfo>? children})
    : super(MyPostedMissingPetsRoute.name, initialChildren: children);

  static const String name = 'MyPostedMissingPetsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const MyPostedMissingPetsScreen());
    },
  );
}

/// generated route for
/// [MyPostedTipsGuideScreen]
class MyPostedTipsGuideRoute extends PageRouteInfo<void> {
  const MyPostedTipsGuideRoute({List<PageRouteInfo>? children})
    : super(MyPostedTipsGuideRoute.name, initialChildren: children);

  static const String name = 'MyPostedTipsGuideRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const MyPostedTipsGuideScreen());
    },
  );
}

/// generated route for
/// [MyTipGuideFormScreen]
class MyTipGuideFormRoute extends PageRouteInfo<MyTipGuideFormRouteArgs> {
  MyTipGuideFormRoute({
    Key? key,
    required MyTipFormType type,
    String? tipId,
    List<PageRouteInfo>? children,
  }) : super(
         MyTipGuideFormRoute.name,
         args: MyTipGuideFormRouteArgs(key: key, type: type, tipId: tipId),
         initialChildren: children,
       );

  static const String name = 'MyTipGuideFormRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MyTipGuideFormRouteArgs>();
      return WrappedRoute(
        child: MyTipGuideFormScreen(
          key: args.key,
          type: args.type,
          tipId: args.tipId,
        ),
      );
    },
  );
}

class MyTipGuideFormRouteArgs {
  const MyTipGuideFormRouteArgs({this.key, required this.type, this.tipId});

  final Key? key;

  final MyTipFormType type;

  final String? tipId;

  @override
  String toString() {
    return 'MyTipGuideFormRouteArgs{key: $key, type: $type, tipId: $tipId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MyTipGuideFormRouteArgs) return false;
    return key == other.key && type == other.type && tipId == other.tipId;
  }

  @override
  int get hashCode => key.hashCode ^ type.hashCode ^ tipId.hashCode;
}

/// generated route for
/// [NetworkAllInvitesScreen]
class NetworkAllInvitesRoute extends PageRouteInfo<void> {
  const NetworkAllInvitesRoute({List<PageRouteInfo>? children})
    : super(NetworkAllInvitesRoute.name, initialChildren: children);

  static const String name = 'NetworkAllInvitesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NetworkAllInvitesScreen();
    },
  );
}

/// generated route for
/// [NetworkInvitesScreen]
class NetworkInvitesRoute extends PageRouteInfo<void> {
  const NetworkInvitesRoute({List<PageRouteInfo>? children})
    : super(NetworkInvitesRoute.name, initialChildren: children);

  static const String name = 'NetworkInvitesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const NetworkInvitesScreen());
    },
  );
}

/// generated route for
/// [NetworkReceivedInvitesScreen]
class NetworkReceivedInvitesRoute extends PageRouteInfo<void> {
  const NetworkReceivedInvitesRoute({List<PageRouteInfo>? children})
    : super(NetworkReceivedInvitesRoute.name, initialChildren: children);

  static const String name = 'NetworkReceivedInvitesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NetworkReceivedInvitesScreen();
    },
  );
}

/// generated route for
/// [NetworkSentInvitesScreen]
class NetworkSentInvitesRoute extends PageRouteInfo<void> {
  const NetworkSentInvitesRoute({List<PageRouteInfo>? children})
    : super(NetworkSentInvitesRoute.name, initialChildren: children);

  static const String name = 'NetworkSentInvitesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NetworkSentInvitesScreen();
    },
  );
}

/// generated route for
/// [OnboardingSuccessfulTransitionScreen]
class OnboardingSuccessfulTransitionRoute
    extends PageRouteInfo<OnboardingSuccessfulTransitionRouteArgs> {
  OnboardingSuccessfulTransitionRoute({
    Key? key,
    String? initialPhoneNumber,
    String? initialEmail,
    String? initialCountryCode,
    required bool isMultiplePet,
    List<PageRouteInfo>? children,
  }) : super(
         OnboardingSuccessfulTransitionRoute.name,
         args: OnboardingSuccessfulTransitionRouteArgs(
           key: key,
           initialPhoneNumber: initialPhoneNumber,
           initialEmail: initialEmail,
           initialCountryCode: initialCountryCode,
           isMultiplePet: isMultiplePet,
         ),
         initialChildren: children,
       );

  static const String name = 'OnboardingSuccessfulTransitionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OnboardingSuccessfulTransitionRouteArgs>();
      return OnboardingSuccessfulTransitionScreen(
        key: args.key,
        initialPhoneNumber: args.initialPhoneNumber,
        initialEmail: args.initialEmail,
        initialCountryCode: args.initialCountryCode,
        isMultiplePet: args.isMultiplePet,
      );
    },
  );
}

class OnboardingSuccessfulTransitionRouteArgs {
  const OnboardingSuccessfulTransitionRouteArgs({
    this.key,
    this.initialPhoneNumber,
    this.initialEmail,
    this.initialCountryCode,
    required this.isMultiplePet,
  });

  final Key? key;

  final String? initialPhoneNumber;

  final String? initialEmail;

  final String? initialCountryCode;

  final bool isMultiplePet;

  @override
  String toString() {
    return 'OnboardingSuccessfulTransitionRouteArgs{key: $key, initialPhoneNumber: $initialPhoneNumber, initialEmail: $initialEmail, initialCountryCode: $initialCountryCode, isMultiplePet: $isMultiplePet}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! OnboardingSuccessfulTransitionRouteArgs) return false;
    return key == other.key &&
        initialPhoneNumber == other.initialPhoneNumber &&
        initialEmail == other.initialEmail &&
        initialCountryCode == other.initialCountryCode &&
        isMultiplePet == other.isMultiplePet;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      initialPhoneNumber.hashCode ^
      initialEmail.hashCode ^
      initialCountryCode.hashCode ^
      isMultiplePet.hashCode;
}

/// generated route for
/// [OnboardingTransitionScreen]
class OnboardingTransitionRoute
    extends PageRouteInfo<OnboardingTransitionRouteArgs> {
  OnboardingTransitionRoute({
    Key? key,
    String? initialPhoneNumber,
    String? initialEmail,
    String? initialCountryCode,
    List<PageRouteInfo>? children,
  }) : super(
         OnboardingTransitionRoute.name,
         args: OnboardingTransitionRouteArgs(
           key: key,
           initialPhoneNumber: initialPhoneNumber,
           initialEmail: initialEmail,
           initialCountryCode: initialCountryCode,
         ),
         initialChildren: children,
       );

  static const String name = 'OnboardingTransitionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OnboardingTransitionRouteArgs>(
        orElse: () => const OnboardingTransitionRouteArgs(),
      );
      return OnboardingTransitionScreen(
        key: args.key,
        initialPhoneNumber: args.initialPhoneNumber,
        initialEmail: args.initialEmail,
        initialCountryCode: args.initialCountryCode,
      );
    },
  );
}

class OnboardingTransitionRouteArgs {
  const OnboardingTransitionRouteArgs({
    this.key,
    this.initialPhoneNumber,
    this.initialEmail,
    this.initialCountryCode,
  });

  final Key? key;

  final String? initialPhoneNumber;

  final String? initialEmail;

  final String? initialCountryCode;

  @override
  String toString() {
    return 'OnboardingTransitionRouteArgs{key: $key, initialPhoneNumber: $initialPhoneNumber, initialEmail: $initialEmail, initialCountryCode: $initialCountryCode}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! OnboardingTransitionRouteArgs) return false;
    return key == other.key &&
        initialPhoneNumber == other.initialPhoneNumber &&
        initialEmail == other.initialEmail &&
        initialCountryCode == other.initialCountryCode;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      initialPhoneNumber.hashCode ^
      initialEmail.hashCode ^
      initialCountryCode.hashCode;
}

/// generated route for
/// [OrderActionRequestScreen]
class OrderActionRequestRoute
    extends PageRouteInfo<OrderActionRequestRouteArgs> {
  OrderActionRequestRoute({
    Key? key,
    required OrderItemModel order,
    required OrderRequestType type,
    List<PageRouteInfo>? children,
  }) : super(
         OrderActionRequestRoute.name,
         args: OrderActionRequestRouteArgs(key: key, order: order, type: type),
         initialChildren: children,
       );

  static const String name = 'OrderActionRequestRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OrderActionRequestRouteArgs>();
      return OrderActionRequestScreen(
        key: args.key,
        order: args.order,
        type: args.type,
      );
    },
  );
}

class OrderActionRequestRouteArgs {
  const OrderActionRequestRouteArgs({
    this.key,
    required this.order,
    required this.type,
  });

  final Key? key;

  final OrderItemModel order;

  final OrderRequestType type;

  @override
  String toString() {
    return 'OrderActionRequestRouteArgs{key: $key, order: $order, type: $type}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! OrderActionRequestRouteArgs) return false;
    return key == other.key && order == other.order && type == other.type;
  }

  @override
  int get hashCode => key.hashCode ^ order.hashCode ^ type.hashCode;
}

/// generated route for
/// [OrderDetailsScreen]
class OrderDetailsRoute extends PageRouteInfo<OrderDetailsRouteArgs> {
  OrderDetailsRoute({
    Key? key,
    required String orderId,
    required String itemId,
    List<PageRouteInfo>? children,
  }) : super(
         OrderDetailsRoute.name,
         args: OrderDetailsRouteArgs(
           key: key,
           orderId: orderId,
           itemId: itemId,
         ),
         initialChildren: children,
       );

  static const String name = 'OrderDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OrderDetailsRouteArgs>();
      return OrderDetailsScreen(
        key: args.key,
        orderId: args.orderId,
        itemId: args.itemId,
      );
    },
  );
}

class OrderDetailsRouteArgs {
  const OrderDetailsRouteArgs({
    this.key,
    required this.orderId,
    required this.itemId,
  });

  final Key? key;

  final String orderId;

  final String itemId;

  @override
  String toString() {
    return 'OrderDetailsRouteArgs{key: $key, orderId: $orderId, itemId: $itemId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! OrderDetailsRouteArgs) return false;
    return key == other.key &&
        orderId == other.orderId &&
        itemId == other.itemId;
  }

  @override
  int get hashCode => key.hashCode ^ orderId.hashCode ^ itemId.hashCode;
}

/// generated route for
/// [OrderSuccessTransitionScreen]
class OrderSuccessTransitionRoute extends PageRouteInfo<void> {
  const OrderSuccessTransitionRoute({List<PageRouteInfo>? children})
    : super(OrderSuccessTransitionRoute.name, initialChildren: children);

  static const String name = 'OrderSuccessTransitionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OrderSuccessTransitionScreen();
    },
  );
}

/// generated route for
/// [OrdersListingScreen]
class OrdersListingRoute extends PageRouteInfo<void> {
  const OrdersListingRoute({List<PageRouteInfo>? children})
    : super(OrdersListingRoute.name, initialChildren: children);

  static const String name = 'OrdersListingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OrdersListingScreen();
    },
  );
}

/// generated route for
/// [OtpScreen]
class OtpRoute extends PageRouteInfo<OtpRouteArgs> {
  OtpRoute({
    Key? key,
    required String emailOrPhone,
    required String countryCode,
    String type = 'register',
    List<PageRouteInfo>? children,
  }) : super(
         OtpRoute.name,
         args: OtpRouteArgs(
           key: key,
           emailOrPhone: emailOrPhone,
           countryCode: countryCode,
           type: type,
         ),
         initialChildren: children,
       );

  static const String name = 'OtpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OtpRouteArgs>();
      return WrappedRoute(
        child: OtpScreen(
          key: args.key,
          emailOrPhone: args.emailOrPhone,
          countryCode: args.countryCode,
          type: args.type,
        ),
      );
    },
  );
}

class OtpRouteArgs {
  const OtpRouteArgs({
    this.key,
    required this.emailOrPhone,
    required this.countryCode,
    this.type = 'register',
  });

  final Key? key;

  final String emailOrPhone;

  final String countryCode;

  final String type;

  @override
  String toString() {
    return 'OtpRouteArgs{key: $key, emailOrPhone: $emailOrPhone, countryCode: $countryCode, type: $type}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! OtpRouteArgs) return false;
    return key == other.key &&
        emailOrPhone == other.emailOrPhone &&
        countryCode == other.countryCode &&
        type == other.type;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      emailOrPhone.hashCode ^
      countryCode.hashCode ^
      type.hashCode;
}

/// generated route for
/// [ParentVetChatScreen]
class ParentVetChatRoute extends PageRouteInfo<ParentVetChatRouteArgs> {
  ParentVetChatRoute({
    Key? key,
    required String appointmentId,
    required bool enableVideoCall,
    AppointmentApiModel? appointmentDetails,
    bool autoJoinVideoCall = false,
    List<PageRouteInfo>? children,
  }) : super(
         ParentVetChatRoute.name,
         args: ParentVetChatRouteArgs(
           key: key,
           appointmentId: appointmentId,
           enableVideoCall: enableVideoCall,
           appointmentDetails: appointmentDetails,
           autoJoinVideoCall: autoJoinVideoCall,
         ),
         initialChildren: children,
       );

  static const String name = 'ParentVetChatRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ParentVetChatRouteArgs>();
      return ParentVetChatScreen(
        key: args.key,
        appointmentId: args.appointmentId,
        enableVideoCall: args.enableVideoCall,
        appointmentDetails: args.appointmentDetails,
        autoJoinVideoCall: args.autoJoinVideoCall,
      );
    },
  );
}

class ParentVetChatRouteArgs {
  const ParentVetChatRouteArgs({
    this.key,
    required this.appointmentId,
    required this.enableVideoCall,
    this.appointmentDetails,
    this.autoJoinVideoCall = false,
  });

  final Key? key;

  final String appointmentId;

  final bool enableVideoCall;

  final AppointmentApiModel? appointmentDetails;

  final bool autoJoinVideoCall;

  @override
  String toString() {
    return 'ParentVetChatRouteArgs{key: $key, appointmentId: $appointmentId, enableVideoCall: $enableVideoCall, appointmentDetails: $appointmentDetails, autoJoinVideoCall: $autoJoinVideoCall}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ParentVetChatRouteArgs) return false;
    return key == other.key &&
        appointmentId == other.appointmentId &&
        enableVideoCall == other.enableVideoCall &&
        appointmentDetails == other.appointmentDetails &&
        autoJoinVideoCall == other.autoJoinVideoCall;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      appointmentId.hashCode ^
      enableVideoCall.hashCode ^
      appointmentDetails.hashCode ^
      autoJoinVideoCall.hashCode;
}

/// generated route for
/// [PetAddedSuccessfulTransitionScreen]
class PetAddedSuccessfulTransitionRoute
    extends PageRouteInfo<PetAddedSuccessfulTransitionRouteArgs> {
  PetAddedSuccessfulTransitionRoute({
    Key? key,
    VoidCallback? onAddAnotherPet,
    List<PageRouteInfo>? children,
  }) : super(
         PetAddedSuccessfulTransitionRoute.name,
         args: PetAddedSuccessfulTransitionRouteArgs(
           key: key,
           onAddAnotherPet: onAddAnotherPet,
         ),
         initialChildren: children,
       );

  static const String name = 'PetAddedSuccessfulTransitionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PetAddedSuccessfulTransitionRouteArgs>(
        orElse: () => const PetAddedSuccessfulTransitionRouteArgs(),
      );
      return PetAddedSuccessfulTransitionScreen(
        key: args.key,
        onAddAnotherPet: args.onAddAnotherPet,
      );
    },
  );
}

class PetAddedSuccessfulTransitionRouteArgs {
  const PetAddedSuccessfulTransitionRouteArgs({this.key, this.onAddAnotherPet});

  final Key? key;

  final VoidCallback? onAddAnotherPet;

  @override
  String toString() {
    return 'PetAddedSuccessfulTransitionRouteArgs{key: $key, onAddAnotherPet: $onAddAnotherPet}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PetAddedSuccessfulTransitionRouteArgs) return false;
    return key == other.key && onAddAnotherPet == other.onAddAnotherPet;
  }

  @override
  int get hashCode => key.hashCode ^ onAddAnotherPet.hashCode;
}

/// generated route for
/// [PetAppointmentsHistoryScreen]
class PetAppointmentsHistoryRoute extends PageRouteInfo<void> {
  const PetAppointmentsHistoryRoute({List<PageRouteInfo>? children})
    : super(PetAppointmentsHistoryRoute.name, initialChildren: children);

  static const String name = 'PetAppointmentsHistoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PetAppointmentsHistoryScreen();
    },
  );
}

/// generated route for
/// [PetMedicalAllListScreen]
class PetMedicalAllListRoute extends PageRouteInfo<void> {
  const PetMedicalAllListRoute({List<PageRouteInfo>? children})
    : super(PetMedicalAllListRoute.name, initialChildren: children);

  static const String name = 'PetMedicalAllListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PetMedicalAllListScreen();
    },
  );
}

/// generated route for
/// [PetMedicalConsultationListScreen]
class PetMedicalConsultationListRoute extends PageRouteInfo<void> {
  const PetMedicalConsultationListRoute({List<PageRouteInfo>? children})
    : super(PetMedicalConsultationListRoute.name, initialChildren: children);

  static const String name = 'PetMedicalConsultationListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PetMedicalConsultationListScreen();
    },
  );
}

/// generated route for
/// [PetMedicalDetailsScreen]
class PetMedicalDetailsRoute extends PageRouteInfo<PetMedicalDetailsRouteArgs> {
  PetMedicalDetailsRoute({
    Key? key,
    required String recordId,
    required String appointmentId,
    required MedicalHistoryRecordTypeFilter recordType,
    List<PageRouteInfo>? children,
  }) : super(
         PetMedicalDetailsRoute.name,
         args: PetMedicalDetailsRouteArgs(
           key: key,
           recordId: recordId,
           appointmentId: appointmentId,
           recordType: recordType,
         ),
         initialChildren: children,
       );

  static const String name = 'PetMedicalDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PetMedicalDetailsRouteArgs>();
      return WrappedRoute(
        child: PetMedicalDetailsScreen(
          key: args.key,
          recordId: args.recordId,
          appointmentId: args.appointmentId,
          recordType: args.recordType,
        ),
      );
    },
  );
}

class PetMedicalDetailsRouteArgs {
  const PetMedicalDetailsRouteArgs({
    this.key,
    required this.recordId,
    required this.appointmentId,
    required this.recordType,
  });

  final Key? key;

  final String recordId;

  final String appointmentId;

  final MedicalHistoryRecordTypeFilter recordType;

  @override
  String toString() {
    return 'PetMedicalDetailsRouteArgs{key: $key, recordId: $recordId, appointmentId: $appointmentId, recordType: $recordType}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PetMedicalDetailsRouteArgs) return false;
    return key == other.key &&
        recordId == other.recordId &&
        appointmentId == other.appointmentId &&
        recordType == other.recordType;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      recordId.hashCode ^
      appointmentId.hashCode ^
      recordType.hashCode;
}

/// generated route for
/// [PetMedicalHealthRecordsListScreen]
class PetMedicalHealthRecordsListRoute extends PageRouteInfo<void> {
  const PetMedicalHealthRecordsListRoute({List<PageRouteInfo>? children})
    : super(PetMedicalHealthRecordsListRoute.name, initialChildren: children);

  static const String name = 'PetMedicalHealthRecordsListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PetMedicalHealthRecordsListScreen();
    },
  );
}

/// generated route for
/// [PetMedicalHistoryScreen]
class PetMedicalHistoryRoute extends PageRouteInfo<void> {
  const PetMedicalHistoryRoute({List<PageRouteInfo>? children})
    : super(PetMedicalHistoryRoute.name, initialChildren: children);

  static const String name = 'PetMedicalHistoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PetMedicalHistoryScreen();
    },
  );
}

/// generated route for
/// [PetMedicalLabReportListScreen]
class PetMedicalLabReportListRoute extends PageRouteInfo<void> {
  const PetMedicalLabReportListRoute({List<PageRouteInfo>? children})
    : super(PetMedicalLabReportListRoute.name, initialChildren: children);

  static const String name = 'PetMedicalLabReportListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PetMedicalLabReportListScreen();
    },
  );
}

/// generated route for
/// [PetMedicalOtherDocumentsListScreen]
class PetMedicalOtherDocumentsListRoute extends PageRouteInfo<void> {
  const PetMedicalOtherDocumentsListRoute({List<PageRouteInfo>? children})
    : super(PetMedicalOtherDocumentsListRoute.name, initialChildren: children);

  static const String name = 'PetMedicalOtherDocumentsListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PetMedicalOtherDocumentsListScreen();
    },
  );
}

/// generated route for
/// [PetMedicalVaccinationListScreen]
class PetMedicalVaccinationListRoute extends PageRouteInfo<void> {
  const PetMedicalVaccinationListRoute({List<PageRouteInfo>? children})
    : super(PetMedicalVaccinationListRoute.name, initialChildren: children);

  static const String name = 'PetMedicalVaccinationListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PetMedicalVaccinationListScreen();
    },
  );
}

/// generated route for
/// [PoochParentChatListScreen]
class PoochParentChatListRoute extends PageRouteInfo<void> {
  const PoochParentChatListRoute({List<PageRouteInfo>? children})
    : super(PoochParentChatListRoute.name, initialChildren: children);

  static const String name = 'PoochParentChatListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PoochParentChatListScreen();
    },
  );
}

/// generated route for
/// [PoochParentChatScreen]
class PoochParentChatRoute extends PageRouteInfo<PoochParentChatRouteArgs> {
  PoochParentChatRoute({
    Key? key,
    required String userName,
    required String source,
    List<PageRouteInfo>? children,
  }) : super(
         PoochParentChatRoute.name,
         args: PoochParentChatRouteArgs(
           key: key,
           userName: userName,
           source: source,
         ),
         initialChildren: children,
       );

  static const String name = 'PoochParentChatRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PoochParentChatRouteArgs>();
      return PoochParentChatScreen(
        key: args.key,
        userName: args.userName,
        source: args.source,
      );
    },
  );
}

class PoochParentChatRouteArgs {
  const PoochParentChatRouteArgs({
    this.key,
    required this.userName,
    required this.source,
  });

  final Key? key;

  final String userName;

  final String source;

  @override
  String toString() {
    return 'PoochParentChatRouteArgs{key: $key, userName: $userName, source: $source}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PoochParentChatRouteArgs) return false;
    return key == other.key &&
        userName == other.userName &&
        source == other.source;
  }

  @override
  int get hashCode => key.hashCode ^ userName.hashCode ^ source.hashCode;
}

/// generated route for
/// [PoochPetShelterListScreen]
class PoochPetShelterListRoute extends PageRouteInfo<void> {
  const PoochPetShelterListRoute({List<PageRouteInfo>? children})
    : super(PoochPetShelterListRoute.name, initialChildren: children);

  static const String name = 'PoochPetShelterListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const PoochPetShelterListScreen());
    },
  );
}

/// generated route for
/// [ProductsTabScreen]
class ProductsTabRoute extends PageRouteInfo<void> {
  const ProductsTabRoute({List<PageRouteInfo>? children})
    : super(ProductsTabRoute.name, initialChildren: children);

  static const String name = 'ProductsTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProductsTabScreen();
    },
  );
}

/// generated route for
/// [PurchaseSuccessScreen]
class PurchaseSuccessRoute extends PageRouteInfo<void> {
  const PurchaseSuccessRoute({List<PageRouteInfo>? children})
    : super(PurchaseSuccessRoute.name, initialChildren: children);

  static const String name = 'PurchaseSuccessRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PurchaseSuccessScreen();
    },
  );
}

/// generated route for
/// [ReceivedInvitesScreen]
class ReceivedInvitesRoute extends PageRouteInfo<void> {
  const ReceivedInvitesRoute({List<PageRouteInfo>? children})
    : super(ReceivedInvitesRoute.name, initialChildren: children);

  static const String name = 'ReceivedInvitesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ReceivedInvitesScreen();
    },
  );
}

/// generated route for
/// [RegisterScreen]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const RegisterScreen());
    },
  );
}

/// generated route for
/// [ReportMissingPetFormScreen]
class ReportMissingPetFormRoute
    extends PageRouteInfo<ReportMissingPetFormRouteArgs> {
  ReportMissingPetFormRoute({
    Key? key,
    required ReportMissingPetFormType type,
    String? reportId,
    List<PageRouteInfo>? children,
  }) : super(
         ReportMissingPetFormRoute.name,
         args: ReportMissingPetFormRouteArgs(
           key: key,
           type: type,
           reportId: reportId,
         ),
         initialChildren: children,
       );

  static const String name = 'ReportMissingPetFormRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReportMissingPetFormRouteArgs>();
      return WrappedRoute(
        child: ReportMissingPetFormScreen(
          key: args.key,
          type: args.type,
          reportId: args.reportId,
        ),
      );
    },
  );
}

class ReportMissingPetFormRouteArgs {
  const ReportMissingPetFormRouteArgs({
    this.key,
    required this.type,
    this.reportId,
  });

  final Key? key;

  final ReportMissingPetFormType type;

  final String? reportId;

  @override
  String toString() {
    return 'ReportMissingPetFormRouteArgs{key: $key, type: $type, reportId: $reportId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ReportMissingPetFormRouteArgs) return false;
    return key == other.key && type == other.type && reportId == other.reportId;
  }

  @override
  int get hashCode => key.hashCode ^ type.hashCode ^ reportId.hashCode;
}

/// generated route for
/// [ReportMissingPetTransitionScreen]
class ReportMissingPetTransitionRoute
    extends PageRouteInfo<ReportMissingPetTransitionRouteArgs> {
  ReportMissingPetTransitionRoute({
    Key? key,
    required String petId,
    List<PageRouteInfo>? children,
  }) : super(
         ReportMissingPetTransitionRoute.name,
         args: ReportMissingPetTransitionRouteArgs(key: key, petId: petId),
         initialChildren: children,
       );

  static const String name = 'ReportMissingPetTransitionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReportMissingPetTransitionRouteArgs>();
      return ReportMissingPetTransitionScreen(key: args.key, petId: args.petId);
    },
  );
}

class ReportMissingPetTransitionRouteArgs {
  const ReportMissingPetTransitionRouteArgs({this.key, required this.petId});

  final Key? key;

  final String petId;

  @override
  String toString() {
    return 'ReportMissingPetTransitionRouteArgs{key: $key, petId: $petId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ReportMissingPetTransitionRouteArgs) return false;
    return key == other.key && petId == other.petId;
  }

  @override
  int get hashCode => key.hashCode ^ petId.hashCode;
}

/// generated route for
/// [RequestCancellationScreen]
class RequestCancellationRoute
    extends PageRouteInfo<RequestCancellationRouteArgs> {
  RequestCancellationRoute({
    Key? key,
    required String orderId,
    required String itemId,
    List<PageRouteInfo>? children,
  }) : super(
         RequestCancellationRoute.name,
         args: RequestCancellationRouteArgs(
           key: key,
           orderId: orderId,
           itemId: itemId,
         ),
         initialChildren: children,
       );

  static const String name = 'RequestCancellationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RequestCancellationRouteArgs>();
      return RequestCancellationScreen(
        key: args.key,
        orderId: args.orderId,
        itemId: args.itemId,
      );
    },
  );
}

class RequestCancellationRouteArgs {
  const RequestCancellationRouteArgs({
    this.key,
    required this.orderId,
    required this.itemId,
  });

  final Key? key;

  final String orderId;

  final String itemId;

  @override
  String toString() {
    return 'RequestCancellationRouteArgs{key: $key, orderId: $orderId, itemId: $itemId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RequestCancellationRouteArgs) return false;
    return key == other.key &&
        orderId == other.orderId &&
        itemId == other.itemId;
  }

  @override
  int get hashCode => key.hashCode ^ orderId.hashCode ^ itemId.hashCode;
}

/// generated route for
/// [SaveHouseDetailsScreen]
class SaveHouseDetailsRoute extends PageRouteInfo<SaveHouseDetailsRouteArgs> {
  SaveHouseDetailsRoute({
    Key? key,
    required bool isMultiplePet,
    String? initialPhoneNumber,
    String? initialEmail,
    String? initialCountryCode,
    List<PageRouteInfo>? children,
  }) : super(
         SaveHouseDetailsRoute.name,
         args: SaveHouseDetailsRouteArgs(
           key: key,
           isMultiplePet: isMultiplePet,
           initialPhoneNumber: initialPhoneNumber,
           initialEmail: initialEmail,
           initialCountryCode: initialCountryCode,
         ),
         initialChildren: children,
       );

  static const String name = 'SaveHouseDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SaveHouseDetailsRouteArgs>();
      return SaveHouseDetailsScreen(
        key: args.key,
        isMultiplePet: args.isMultiplePet,
        initialPhoneNumber: args.initialPhoneNumber,
        initialEmail: args.initialEmail,
        initialCountryCode: args.initialCountryCode,
      );
    },
  );
}

class SaveHouseDetailsRouteArgs {
  const SaveHouseDetailsRouteArgs({
    this.key,
    required this.isMultiplePet,
    this.initialPhoneNumber,
    this.initialEmail,
    this.initialCountryCode,
  });

  final Key? key;

  final bool isMultiplePet;

  final String? initialPhoneNumber;

  final String? initialEmail;

  final String? initialCountryCode;

  @override
  String toString() {
    return 'SaveHouseDetailsRouteArgs{key: $key, isMultiplePet: $isMultiplePet, initialPhoneNumber: $initialPhoneNumber, initialEmail: $initialEmail, initialCountryCode: $initialCountryCode}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SaveHouseDetailsRouteArgs) return false;
    return key == other.key &&
        isMultiplePet == other.isMultiplePet &&
        initialPhoneNumber == other.initialPhoneNumber &&
        initialEmail == other.initialEmail &&
        initialCountryCode == other.initialCountryCode;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      isMultiplePet.hashCode ^
      initialPhoneNumber.hashCode ^
      initialEmail.hashCode ^
      initialCountryCode.hashCode;
}

/// generated route for
/// [ScheduleScreen]
class ScheduleRoute extends PageRouteInfo<void> {
  const ScheduleRoute({List<PageRouteInfo>? children})
    : super(ScheduleRoute.name, initialChildren: children);

  static const String name = 'ScheduleRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ScheduleScreen();
    },
  );
}

/// generated route for
/// [SelectPetOptionScreen]
class SelectPetOptionRoute extends PageRouteInfo<SelectPetOptionRouteArgs> {
  SelectPetOptionRoute({
    Key? key,
    String? initialPhoneNumber,
    String? initialEmail,
    String? initialCountryCode,
    List<PageRouteInfo>? children,
  }) : super(
         SelectPetOptionRoute.name,
         args: SelectPetOptionRouteArgs(
           key: key,
           initialPhoneNumber: initialPhoneNumber,
           initialEmail: initialEmail,
           initialCountryCode: initialCountryCode,
         ),
         initialChildren: children,
       );

  static const String name = 'SelectPetOptionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SelectPetOptionRouteArgs>(
        orElse: () => const SelectPetOptionRouteArgs(),
      );
      return SelectPetOptionScreen(
        key: args.key,
        initialPhoneNumber: args.initialPhoneNumber,
        initialEmail: args.initialEmail,
        initialCountryCode: args.initialCountryCode,
      );
    },
  );
}

class SelectPetOptionRouteArgs {
  const SelectPetOptionRouteArgs({
    this.key,
    this.initialPhoneNumber,
    this.initialEmail,
    this.initialCountryCode,
  });

  final Key? key;

  final String? initialPhoneNumber;

  final String? initialEmail;

  final String? initialCountryCode;

  @override
  String toString() {
    return 'SelectPetOptionRouteArgs{key: $key, initialPhoneNumber: $initialPhoneNumber, initialEmail: $initialEmail, initialCountryCode: $initialCountryCode}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SelectPetOptionRouteArgs) return false;
    return key == other.key &&
        initialPhoneNumber == other.initialPhoneNumber &&
        initialEmail == other.initialEmail &&
        initialCountryCode == other.initialCountryCode;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      initialPhoneNumber.hashCode ^
      initialEmail.hashCode ^
      initialCountryCode.hashCode;
}

/// generated route for
/// [SentInvitesScreen]
class SentInvitesRoute extends PageRouteInfo<void> {
  const SentInvitesRoute({List<PageRouteInfo>? children})
    : super(SentInvitesRoute.name, initialChildren: children);

  static const String name = 'SentInvitesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SentInvitesScreen();
    },
  );
}

/// generated route for
/// [ServeTabScreen]
class ServeTabRoute extends PageRouteInfo<void> {
  const ServeTabRoute({List<PageRouteInfo>? children})
    : super(ServeTabRoute.name, initialChildren: children);

  static const String name = 'ServeTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ServeTabScreen();
    },
  );
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsScreen();
    },
  );
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashScreen();
    },
  );
}

/// generated route for
/// [SubsPaymentFailedTransitionScreen]
class SubsPaymentFailedTransitionRoute extends PageRouteInfo<void> {
  const SubsPaymentFailedTransitionRoute({List<PageRouteInfo>? children})
    : super(SubsPaymentFailedTransitionRoute.name, initialChildren: children);

  static const String name = 'SubsPaymentFailedTransitionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SubsPaymentFailedTransitionScreen();
    },
  );
}

/// generated route for
/// [TestDesignScreen]
class TestDesignRoute extends PageRouteInfo<void> {
  const TestDesignRoute({List<PageRouteInfo>? children})
    : super(TestDesignRoute.name, initialChildren: children);

  static const String name = 'TestDesignRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TestDesignScreen();
    },
  );
}

/// generated route for
/// [TipDetailsScreen]
class TipDetailsRoute extends PageRouteInfo<TipDetailsRouteArgs> {
  TipDetailsRoute({
    Key? key,
    required String contentId,
    List<PageRouteInfo>? children,
  }) : super(
         TipDetailsRoute.name,
         args: TipDetailsRouteArgs(key: key, contentId: contentId),
         initialChildren: children,
       );

  static const String name = 'TipDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TipDetailsRouteArgs>();
      return TipDetailsScreen(key: args.key, contentId: args.contentId);
    },
  );
}

class TipDetailsRouteArgs {
  const TipDetailsRouteArgs({this.key, required this.contentId});

  final Key? key;

  final String contentId;

  @override
  String toString() {
    return 'TipDetailsRouteArgs{key: $key, contentId: $contentId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TipDetailsRouteArgs) return false;
    return key == other.key && contentId == other.contentId;
  }

  @override
  int get hashCode => key.hashCode ^ contentId.hashCode;
}

/// generated route for
/// [TipsInfoListScreen]
class TipsInfoListRoute extends PageRouteInfo<void> {
  const TipsInfoListRoute({List<PageRouteInfo>? children})
    : super(TipsInfoListRoute.name, initialChildren: children);

  static const String name = 'TipsInfoListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TipsInfoListScreen();
    },
  );
}

/// generated route for
/// [TipsListingScreen]
class TipsListingRoute extends PageRouteInfo<TipsListingRouteArgs> {
  TipsListingRoute({Key? key, String? petId, List<PageRouteInfo>? children})
    : super(
        TipsListingRoute.name,
        args: TipsListingRouteArgs(key: key, petId: petId),
        initialChildren: children,
      );

  static const String name = 'TipsListingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TipsListingRouteArgs>(
        orElse: () => const TipsListingRouteArgs(),
      );
      return TipsListingScreen(key: args.key, petId: args.petId);
    },
  );
}

class TipsListingRouteArgs {
  const TipsListingRouteArgs({this.key, this.petId});

  final Key? key;

  final String? petId;

  @override
  String toString() {
    return 'TipsListingRouteArgs{key: $key, petId: $petId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TipsListingRouteArgs) return false;
    return key == other.key && petId == other.petId;
  }

  @override
  int get hashCode => key.hashCode ^ petId.hashCode;
}

/// generated route for
/// [TrackOrderScreen]
class TrackOrderRoute extends PageRouteInfo<TrackOrderRouteArgs> {
  TrackOrderRoute({
    Key? key,
    required String orderId,
    required String itemId,
    List<PageRouteInfo>? children,
  }) : super(
         TrackOrderRoute.name,
         args: TrackOrderRouteArgs(key: key, orderId: orderId, itemId: itemId),
         initialChildren: children,
       );

  static const String name = 'TrackOrderRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TrackOrderRouteArgs>();
      return TrackOrderScreen(
        key: args.key,
        orderId: args.orderId,
        itemId: args.itemId,
      );
    },
  );
}

class TrackOrderRouteArgs {
  const TrackOrderRouteArgs({
    this.key,
    required this.orderId,
    required this.itemId,
  });

  final Key? key;

  final String orderId;

  final String itemId;

  @override
  String toString() {
    return 'TrackOrderRouteArgs{key: $key, orderId: $orderId, itemId: $itemId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TrackOrderRouteArgs) return false;
    return key == other.key &&
        orderId == other.orderId &&
        itemId == other.itemId;
  }

  @override
  int get hashCode => key.hashCode ^ orderId.hashCode ^ itemId.hashCode;
}

/// generated route for
/// [TrainingDetailsScreen]
class TrainingDetailsRoute extends PageRouteInfo<TrainingDetailsRouteArgs> {
  TrainingDetailsRoute({
    Key? key,
    required String contentId,
    List<PageRouteInfo>? children,
  }) : super(
         TrainingDetailsRoute.name,
         args: TrainingDetailsRouteArgs(key: key, contentId: contentId),
         initialChildren: children,
       );

  static const String name = 'TrainingDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TrainingDetailsRouteArgs>();
      return TrainingDetailsScreen(key: args.key, contentId: args.contentId);
    },
  );
}

class TrainingDetailsRouteArgs {
  const TrainingDetailsRouteArgs({this.key, required this.contentId});

  final Key? key;

  final String contentId;

  @override
  String toString() {
    return 'TrainingDetailsRouteArgs{key: $key, contentId: $contentId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TrainingDetailsRouteArgs) return false;
    return key == other.key && contentId == other.contentId;
  }

  @override
  int get hashCode => key.hashCode ^ contentId.hashCode;
}

/// generated route for
/// [TrainingsListingScreen]
class TrainingsListingRoute extends PageRouteInfo<TrainingsListingRouteArgs> {
  TrainingsListingRoute({
    Key? key,
    String? petId,
    List<PageRouteInfo>? children,
  }) : super(
         TrainingsListingRoute.name,
         args: TrainingsListingRouteArgs(key: key, petId: petId),
         initialChildren: children,
       );

  static const String name = 'TrainingsListingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TrainingsListingRouteArgs>(
        orElse: () => const TrainingsListingRouteArgs(),
      );
      return TrainingsListingScreen(key: args.key, petId: args.petId);
    },
  );
}

class TrainingsListingRouteArgs {
  const TrainingsListingRouteArgs({this.key, this.petId});

  final Key? key;

  final String? petId;

  @override
  String toString() {
    return 'TrainingsListingRouteArgs{key: $key, petId: $petId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TrainingsListingRouteArgs) return false;
    return key == other.key && petId == other.petId;
  }

  @override
  int get hashCode => key.hashCode ^ petId.hashCode;
}

/// generated route for
/// [TransitionDemoScreen]
class TransitionDemoRoute extends PageRouteInfo<void> {
  const TransitionDemoRoute({List<PageRouteInfo>? children})
    : super(TransitionDemoRoute.name, initialChildren: children);

  static const String name = 'TransitionDemoRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TransitionDemoScreen();
    },
  );
}

/// generated route for
/// [TransitionScreen]
class TransitionRoute extends PageRouteInfo<TransitionRouteArgs> {
  TransitionRoute({
    Key? key,
    required TransitionScreenVariant variant,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    VoidCallback? onTertiaryPressed,
    String? petName,
    List<PageRouteInfo>? children,
  }) : super(
         TransitionRoute.name,
         args: TransitionRouteArgs(
           key: key,
           variant: variant,
           onPrimaryPressed: onPrimaryPressed,
           onSecondaryPressed: onSecondaryPressed,
           onTertiaryPressed: onTertiaryPressed,
           petName: petName,
         ),
         initialChildren: children,
       );

  static const String name = 'TransitionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TransitionRouteArgs>();
      return TransitionScreen(
        key: args.key,
        variant: args.variant,
        onPrimaryPressed: args.onPrimaryPressed,
        onSecondaryPressed: args.onSecondaryPressed,
        onTertiaryPressed: args.onTertiaryPressed,
        petName: args.petName,
      );
    },
  );
}

class TransitionRouteArgs {
  const TransitionRouteArgs({
    this.key,
    required this.variant,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.onTertiaryPressed,
    this.petName,
  });

  final Key? key;

  final TransitionScreenVariant variant;

  final VoidCallback? onPrimaryPressed;

  final VoidCallback? onSecondaryPressed;

  final VoidCallback? onTertiaryPressed;

  final String? petName;

  @override
  String toString() {
    return 'TransitionRouteArgs{key: $key, variant: $variant, onPrimaryPressed: $onPrimaryPressed, onSecondaryPressed: $onSecondaryPressed, onTertiaryPressed: $onTertiaryPressed, petName: $petName}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TransitionRouteArgs) return false;
    return key == other.key &&
        variant == other.variant &&
        onPrimaryPressed == other.onPrimaryPressed &&
        onSecondaryPressed == other.onSecondaryPressed &&
        onTertiaryPressed == other.onTertiaryPressed &&
        petName == other.petName;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      variant.hashCode ^
      onPrimaryPressed.hashCode ^
      onSecondaryPressed.hashCode ^
      onTertiaryPressed.hashCode ^
      petName.hashCode;
}

/// generated route for
/// [TricksAndTrainingSearchScreen]
class TricksAndTrainingSearchRoute
    extends PageRouteInfo<TricksAndTrainingSearchRouteArgs> {
  TricksAndTrainingSearchRoute({
    Key? key,
    required String query,
    List<PageRouteInfo>? children,
  }) : super(
         TricksAndTrainingSearchRoute.name,
         args: TricksAndTrainingSearchRouteArgs(key: key, query: query),
         initialChildren: children,
       );

  static const String name = 'TricksAndTrainingSearchRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TricksAndTrainingSearchRouteArgs>();
      return TricksAndTrainingSearchScreen(key: args.key, query: args.query);
    },
  );
}

class TricksAndTrainingSearchRouteArgs {
  const TricksAndTrainingSearchRouteArgs({this.key, required this.query});

  final Key? key;

  final String query;

  @override
  String toString() {
    return 'TricksAndTrainingSearchRouteArgs{key: $key, query: $query}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TricksAndTrainingSearchRouteArgs) return false;
    return key == other.key && query == other.query;
  }

  @override
  int get hashCode => key.hashCode ^ query.hashCode;
}

/// generated route for
/// [TricksAndTrainingsLandingScreen]
class TricksAndTrainingsLandingRoute extends PageRouteInfo<void> {
  const TricksAndTrainingsLandingRoute({List<PageRouteInfo>? children})
    : super(TricksAndTrainingsLandingRoute.name, initialChildren: children);

  static const String name = 'TricksAndTrainingsLandingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TricksAndTrainingsLandingScreen();
    },
  );
}

/// generated route for
/// [UserProfileScreen]
class UserProfileRoute extends PageRouteInfo<void> {
  const UserProfileRoute({List<PageRouteInfo>? children})
    : super(UserProfileRoute.name, initialChildren: children);

  static const String name = 'UserProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const UserProfileScreen());
    },
  );
}

/// generated route for
/// [VideoDetailsScreen]
class VideoDetailsRoute extends PageRouteInfo<VideoDetailsRouteArgs> {
  VideoDetailsRoute({
    Key? key,
    required String contentId,
    List<PageRouteInfo>? children,
  }) : super(
         VideoDetailsRoute.name,
         args: VideoDetailsRouteArgs(key: key, contentId: contentId),
         initialChildren: children,
       );

  static const String name = 'VideoDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VideoDetailsRouteArgs>();
      return VideoDetailsScreen(key: args.key, contentId: args.contentId);
    },
  );
}

class VideoDetailsRouteArgs {
  const VideoDetailsRouteArgs({this.key, required this.contentId});

  final Key? key;

  final String contentId;

  @override
  String toString() {
    return 'VideoDetailsRouteArgs{key: $key, contentId: $contentId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VideoDetailsRouteArgs) return false;
    return key == other.key && contentId == other.contentId;
  }

  @override
  int get hashCode => key.hashCode ^ contentId.hashCode;
}

/// generated route for
/// [VideosListingScreen]
class VideosListingRoute extends PageRouteInfo<VideosListingRouteArgs> {
  VideosListingRoute({Key? key, String? petId, List<PageRouteInfo>? children})
    : super(
        VideosListingRoute.name,
        args: VideosListingRouteArgs(key: key, petId: petId),
        initialChildren: children,
      );

  static const String name = 'VideosListingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VideosListingRouteArgs>(
        orElse: () => const VideosListingRouteArgs(),
      );
      return VideosListingScreen(key: args.key, petId: args.petId);
    },
  );
}

class VideosListingRouteArgs {
  const VideosListingRouteArgs({this.key, this.petId});

  final Key? key;

  final String? petId;

  @override
  String toString() {
    return 'VideosListingRouteArgs{key: $key, petId: $petId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VideosListingRouteArgs) return false;
    return key == other.key && petId == other.petId;
  }

  @override
  int get hashCode => key.hashCode ^ petId.hashCode;
}

/// generated route for
/// [VirtualPetGamingScreen]
class VirtualPetGamingRoute extends PageRouteInfo<void> {
  const VirtualPetGamingRoute({List<PageRouteInfo>? children})
    : super(VirtualPetGamingRoute.name, initialChildren: children);

  static const String name = 'VirtualPetGamingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const VirtualPetGamingScreen();
    },
  );
}

/// generated route for
/// [WishlistScreen]
class WishlistRoute extends PageRouteInfo<void> {
  const WishlistRoute({List<PageRouteInfo>? children})
    : super(WishlistRoute.name, initialChildren: children);

  static const String name = 'WishlistRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const WishlistScreen();
    },
  );
}

/// generated route for
/// [YourAccessoriesScreen]
class YourAccessoriesRoute extends PageRouteInfo<void> {
  const YourAccessoriesRoute({List<PageRouteInfo>? children})
    : super(YourAccessoriesRoute.name, initialChildren: children);

  static const String name = 'YourAccessoriesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const YourAccessoriesScreen());
    },
  );
}
