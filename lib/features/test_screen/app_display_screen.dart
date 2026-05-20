import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/services/loader_service.dart';
import 'package:poochcare/core/services/toast_service.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/action_buttons/action_card_grid.dart';
import 'package:poochcare/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:poochcare/core/widgets/bottom_sheet/comment_bottom_sheet/comment_bottom_sheet.dart';
import 'package:poochcare/core/widgets/bottom_sheet/invite_bottom_sheet/invite_bottom_sheet.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/dialogs/app_dialog.dart';
import 'package:poochcare/core/widgets/dialogs/app_select_pet_dialog.dart';
import 'package:poochcare/core/widgets/dropdowns/app_dropdowns.dart';
import 'package:poochcare/core/widgets/feedback/app_snack_bar.dart';
import 'package:poochcare/core/widgets/images/app_image_frame.dart';
import 'package:poochcare/core/widgets/images/app_image_picker_boxes/app_image_picker_boxes.dart';
import 'package:poochcare/core/widgets/input_repeater/medication_repeater_container.dart';
import 'package:poochcare/core/widgets/list_grid/pet_symptom_list.dart';
import 'package:poochcare/core/widgets/list_items/invitation_card/invitation_card.dart';
import 'package:poochcare/core/widgets/menus/app_popup_menu.dart';
import 'package:poochcare/core/widgets/others/app_date_picker/app_date_picker.dart';
import 'package:poochcare/core/widgets/others/app_error_container.dart';
import 'package:poochcare/core/widgets/others/app_info_tile.dart';
import 'package:poochcare/core/widgets/others/app_profile_avatar.dart';
import 'package:poochcare/core/widgets/others/app_tool_tip.dart';
import 'package:poochcare/core/widgets/others/appointment_time_slot/app_time_slot_selection.dart';
import 'package:poochcare/core/widgets/others/cart_item_card.dart';
import 'package:poochcare/core/widgets/others/clinics/clinic_details_card.dart';
import 'package:poochcare/core/widgets/others/coupon/applied_coupon_widget.dart';
import 'package:poochcare/core/widgets/others/coupon/apply_coupon_section.dart';
import 'package:poochcare/core/widgets/others/payments/clininc_subscription_plan_card.dart';
import 'package:poochcare/core/widgets/others/pet_weight_height_row.dart';
import 'package:poochcare/core/widgets/others/price_summary_section.dart';
import 'package:poochcare/core/widgets/others/upcoming_appointments_view.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/get_help/pet_see_result_view.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/bottom_sheets/otp_display_bottom_sheet.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/order_item_pet_card.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/sections/reason_for_cancellation_section.dart';
import 'package:poochcare/features/invites/domain/models/invite_type.dart';

@RoutePage()
class AppDisplayScreen extends StatefulWidget {
  const AppDisplayScreen({super.key});

  @override
  State<AppDisplayScreen> createState() => _AppDisplayScreenState();
}

class _AppDisplayScreenState extends State<AppDisplayScreen> {
  final List<Pet> petsList = [
    Pet(
      id: '1',
      name: 'Rudolph',
      imageUrl: 'https://images.unsplash.com/photo-1558788353-f76d92427f16',
    ),
    Pet(
      id: '2',
      name: 'Cadbury',
      imageUrl: 'https://images.unsplash.com/photo-1537151625747-768eb6cf92b2',
    ),
    Pet(
      id: '3',
      name: 'Bella',
      imageUrl: 'https://images.unsplash.com/photo-1598133894008-61f7fdb8cc3a',
    ),
    Pet(
      id: '4',
      name: 'Max',
      imageUrl: 'https://images.unsplash.com/photo-1543466835-00a7907e9de1',
    ),
  ];
  String? appliedCoupon;
  final List<Map<String, dynamic>> dummyCoupons = [
    {
      'title': 'FIRST 15',
      'subtitle': '15% off on first order',
      'code': 'FIRST15',
    },
    {'title': '10% Off', 'subtitle': 'HDFC Life credit card', 'code': 'HDFC10'},
    {'title': '20% Off', 'subtitle': 'Axis bank credit card', 'code': 'AXIS20'},
    {
      'title': 'POOCH 2026',
      'subtitle': 'Flat 10% off for 2026',
      'code': 'POOCH2026',
    },
    {'title': '5% Off', 'subtitle': 'ICICI bank credit card', 'code': 'ICICI5'},
    {
      'title': '25% Off',
      'subtitle': 'First-time pet parent offer',
      'code': 'PETCARE25',
    },
    {
      'title': '₹500 Off',
      'subtitle': 'On purchases above ₹2000',
      'code': 'SAVE500',
    },
    {
      'title': 'FREE Shipping',
      'subtitle': 'Valid for all orders',
      'code': 'SHIPFREE',
    },
    {
      'title': '12% Off',
      'subtitle': 'Loyalty program members',
      'code': 'LOYALTY12',
    },
    {
      'title': '₹300 Off',
      'subtitle': 'On purchases above ₹1500',
      'code': 'SAVE300',
    },
    {
      'title': '18% Off',
      'subtitle': 'Weekend special offer',
      'code': 'WEEKEND18',
    },
    {
      'title': 'Buy 1 Get 1',
      'subtitle': '50% off on second item',
      'code': 'BUY1GET1',
    },
  ];

  DateTime? _selectedDate;
  DateTimeRange? _selectedDateRange;
  DateTime? _defaultPickerSelectedDate;

  static const List<String> _dropdownValues = [
    'Labrador Retriever',
    'Golden Retriever',
    'German Shepherd',
    'French Bulldog',
    'Labrador Retriever2',
    'Golden Retriever2',
    'German Shepherd2',
    'French Bulldog2',
    'Labrador Retriever3',
    'Golden Retriever3',
    'German Shepherd3',
    'French Bulldog3',
    'Labrador Retriever4',
    'Golden Retriever4',
    'German Shepherd4',
    'French Bulldog4',
    'Labrador Retriever5',
    'Golden Retriever5',
    'German Shepherd5',
    'French Bulldog5',
  ];
  final List<Map<String, dynamic>> dummyInvitations = [
    {
      'isRequestSent': true,
      'isAccepted': false,
      'useButterflyImage': true,
      'petName': 'Rudolph',
      'userName': 'Sohail',
      'ageGender': '24, Female',
      'role': 'Co-Parent',
      'imageUrl':
          'https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg?crop=0.752xw:1.00xh;0.175xw,0&resize=1200:*',
    },
    {
      'isRequestSent': true,
      'isAccepted': true,
      'useButterflyImage': true,
      'petName': 'Gin',
      'userName': 'Suraj',
      'ageGender': '24, Female',
      'role': 'Secondary Master Parent',
      'imageUrl':
          'https://hips.hearstapps.com/hmg-prod/images/best-guard-dogs-1650302456.jpeg?crop=0.754xw:1.00xh;0.0651xw,0&resize=1200:*',
    },
    {
      'isRequestSent': false,
      'isAccepted': false,
      'useButterflyImage': false,
      'petName': 'Rudolph',
      'userName': 'Aniket',
      'ageGender': '24, Female',
      'role': 'Co-Parent',
      'imageUrl':
          'https://hips.hearstapps.com/hmg-prod/images/bernese-mountain-dog-royalty-free-image-1581013857.jpg?crop=0.87845xw:1xh;center,top',
    },
    {
      'isRequestSent': false,
      'isAccepted': true,
      'useButterflyImage': true,
      'petName': 'Rudolph',
      'userName': 'Suryakant',
      'ageGender': '24, Female',
      'role': 'Co-Parent',
      'imageUrl':
          'https://m.media-amazon.com/images/I/61DBnhTQ5kL._AC_UF1000,1000_QL80_.jpg',
    },
    {
      'isRequestSent': true,
      'isAccepted': false,
      'useButterflyImage': false,
      'petName': 'Tom',
      'userName': 'Akash',
      'ageGender': '26, Male',
      'role': 'Co-Parent',
      'imageUrl':
          'https://m.media-amazon.com/images/I/61DBnhTQ5kL._AC_UF1000,1000_QL80_.jpg',
    },
  ];

  File? _selectedProfileImage;

  bool _showBreedDropdownError = false;
  List<DropdownItem<String>> get _dropdownItems => _dropdownValues
      .map(
        (item) => DropdownItem<String>(
          value: item,
          height: 40,
          child: Text(item, style: const TextStyle(fontSize: 14)),
        ),
      )
      .toList();
  final ValueNotifier<String?> _selectedDropdownValue = ValueNotifier<String?>(
    null,
  );

  // OrderModel _buildDummyOrder() {
  //   return const OrderModel(
  //     orderId: 'ord_123456',
  //     orderNumber: 'ORD-2026-001',
  //     orderType: 'product',
  //     // subTotal: 2000,
  //     // totalAmount: 2200,
  //     // taxAmount: 200,
  //     // discountAmount: 0,
  //     // discountType: 'none',
  //     // status: 'completed',
  //     // isDeliveryConfirmed: true,
  //     // isOtpVerified: true,
  //     // items: [],
  //     // paymentMethod: 'card',
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 18.h),

                AppText.bodyM('Custom Dropdown'),
                SizedBox(height: 18.h),
                AppErrorContainer(
                  showError: _showBreedDropdownError,
                  errorMessage: 'Please select a breed',
                  child: AppDropdowns<String>(
                    items: _dropdownItems,
                    valueListenable: _selectedDropdownValue,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _showBreedDropdownError = true;
                          _selectedDropdownValue.value = value;
                        });
                      }
                    },
                    isExpanded: true,
                    isSearchable: true,
                    searchHintText: 'Type Breed',
                  ),
                ),

                SizedBox(height: 18.h),

                PetWeightHeightRow(
                  onChanged: (weight, weightUnit, height, heightUnit) {
                    // ignore: avoid_print
                    print('Weight: $weight $weightUnit');
                    // ignore: avoid_print
                    print('Height: $height $heightUnit');
                  },
                ),

                SizedBox(height: 18.h),

                // Container(
                //   padding: const EdgeInsets.symmetric(
                //     vertical: 16,
                //     horizontal: 12,
                //   ),
                //   color: AppColors.white,
                //   child: PincodeValidateView(
                //     onCheckPincode: (pincode) async {
                //       await Future<dynamic>.delayed(const Duration(seconds: 3));
                //       return pincode == '400001';
                //     },
                //   ),
                // ),
                SizedBox(height: 18.h),

                Column(
                  children: [
                    SizedBox(
                      height: 100.h,
                      width: 100.w,
                      child: const AppImageFrame(
                        width: double.infinity,
                        height: double.infinity,
                        imageUrl:
                            'https://images.unsplash.com/photo-1558788353-f76d92427f16',
                        hasBorder: true,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // 200 x 100
                    SizedBox(
                      height: 200.h,
                      width: 250.w,
                      child: const AppImageFrame(
                        width: double.infinity,
                        height: double.infinity,
                        imageUrl:
                            'https://images.unsplash.com/photo-1558788353-f76d92427f16',
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 18.h),
                AppButton(
                  padding: EdgeInsets.symmetric(horizontal: 36.w),
                  width: null,
                  label: 'Validation code',
                  variant: AppButtonVariant.outlined,
                  onPressed: () {
                    OTPDisplayBottomSheet.show(context: context, otp: '14095');
                  },
                ),
                // --- Loader Demo: Single Button ---
                SizedBox(height: 18.h),
                // AppButton(
                //   label: 'Show Order Return Request Sheet',
                //   onPressed: () async {
                //     final dummyOrder = _buildDummyOrder();

                //     OrderCancellationBottomSheet.show(
                //       context: context,
                //       mode: OrderActionBottomSheetMode.confirm,
                //       order: dummyOrder,
                //       refundAmount: '₹1,800',
                //       refundPolicy:
                //           '15-day return policy applies. Items must be unused.',
                //       selectedReason: 'Not satisfied',
                //       currentStep: 1,
                //       orderStatus: 'Return In Progress',
                //     );
                //   },
                // ),
                // SizedBox(height: 18.h),
                // AppButton(
                //   label: 'Show Order Return Status Sheet',
                //   onPressed: () async {
                //     final dummyOrder = _buildDummyOrder();

                //     OrderCancellationBottomSheet.show(
                //       context: context,
                //       mode: OrderActionBottomSheetMode.status,
                //       order: dummyOrder,
                //       refundAmount: '₹1,800',
                //       refundPolicy:
                //           '15-day return policy applies. Items must be unused.',
                //       selectedReason: 'Not satisfied',
                //       currentStep: 1,
                //       orderStatus: 'Return In Progress',
                //       onConfirm: () => {log('Return confirmed')},
                //     );
                //   },
                // ),
                SizedBox(height: 18.h),
                SizedBox(height: 18.h),
                AppButton(
                  label: 'Show Loader (5s)',
                  onPressed: () async {
                    LoaderService.instance.show();
                    await Future<void>.delayed(const Duration(seconds: 5));
                    LoaderService.instance.hide();
                  },
                ),
                SizedBox(height: 18.h),

                AppButton(
                  label: 'Show Success Snack Bar',
                  onPressed: () {
                    AppSnackBar.show(
                      'This is a success message!',
                      type: SnackbarType.success,
                      context: context,
                    );
                  },
                ),
                SizedBox(height: 18.h),
                AppButton(
                  label: 'Show Info Snack Bar',
                  onPressed: () {
                    AppSnackBar.show(
                      'This is an info message!',
                      context: context,
                    );
                  },
                ),
                SizedBox(height: 18.h),
                AppButton(
                  label: 'Show Warning Snack Bar',
                  onPressed: () {
                    AppSnackBar.show(
                      'This is a warning message!',
                      type: SnackbarType.warning,
                      context: context,
                    );
                  },
                ),
                SizedBox(height: 18.h),
                AppButton(
                  label: 'Show Error Snack Bar',
                  onPressed: () {
                    AppSnackBar.show(
                      'This is an error message!',
                      type: SnackbarType.error,
                    );
                  },
                ),

                SizedBox(height: 18.h),
                AppButton(
                  label: 'Show Dialog',
                  size: AppButtonSize.small,
                  onPressed: () => {
                    // Handle action
                    /// 1. SIMPLE DIALOG
                    AppDialog.show(
                      icon: const Icon(
                        Icons.warning,
                        size: 36,
                        color: Colors.red,
                      ),
                      context: context,
                      title: 'Simple Dialog',
                      content:
                          'This is a simple dialog with just a title and content.',
                      primaryLabel: 'Delete',
                      secondaryLabel: 'Cancel',
                      onPrimary: () async {
                        return true;
                      },
                    ),
                  },
                ),
                SizedBox(height: 18.h),

                AppButton(
                  label: 'Show Select Pet Dialog',
                  size: AppButtonSize.small,
                  onPressed: () async {
                    final result = await AppSelectPetDialog.show(
                      context: context,
                      pets: petsList,
                    );
                    if (result != null) {
                      // print(result.selectedPet.name);
                      // print(result.note);
                    }
                  },
                ),
                SizedBox(height: 18.h),
                AppButton(
                  label: 'Show Bottom Sheet',
                  size: AppButtonSize.small,
                  onPressed: () {
                    AppBottomSheet.show<void>(
                      context: context,
                      title: 'Delete Pet',
                      content: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Are you sure you want to delete this pet?'),
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // delete logic
                            Navigator.pop(context);
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    );
                  },
                ),

                SizedBox(height: 18.h),
                const Text('PopUpMenu'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Example 1: Filter Menu',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    // SizedBox(height: 12.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: AppPopupMenu(
                        headerTitle: 'Filter by',
                        showCloseIcon: true,
                        items: [
                          AppPopupMenuItem(
                            title: 'Accepted',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Accepted selected'),
                                ),
                              );
                            },
                          ),
                          AppPopupMenuItem(
                            title: 'Awaiting acceptance',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Awaiting acceptance selected'),
                                ),
                              );
                            },
                          ),
                        ],
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(
                                context,
                              ).colorScheme.outlineVariant,
                            ),
                            borderRadius: BorderRadius.circular(80),
                          ),
                          child: const Icon(Icons.filter_list),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      'Example 2: Action Menu',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 12.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: AppPopupMenu(
                        items: [
                          AppPopupMenuItem(
                            title: 'Unsend Invite',
                            icon: const Icon(Icons.refresh),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Unsend Invite tapped'),
                                ),
                              );
                            },
                          ),
                          AppPopupMenuItem(
                            title: 'Remind',
                            icon: const Icon(Icons.notifications_none),
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Remind tapped')),
                              );
                            },
                          ),
                        ],
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(
                                context,
                              ).colorScheme.outlineVariant,
                            ),
                            borderRadius: BorderRadius.circular(80),
                          ),
                          child: const Icon(Icons.more_vert),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18.h),
                const Text('Action Buttons'),
                SizedBox(height: 6.h),
                PetSeeResultView(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('See Results clicked')),
                    );
                  },
                ),
                SizedBox(height: 18.h),
                const UpcomingAppointmentsView(
                  type: UpcomingType.calendar,
                  // title: 'Calendar',
                  btnLabel: 'View All',
                  // title: 'Updates and Reminders',
                  // btnLabel: 'VIEW ALL REMINDERS'
                ),
                SizedBox(height: 18.h),
                AppButton(
                  label: 'Show Time Slot Selections\'s',
                  size: AppButtonSize.small,
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => const AppTimeSlotSelection(),
                    //   ),
                    // );
                    showDialog<void>(
                      context: context,
                      builder: (context) => const AppTimeSlotSelection(),
                    );
                  },
                ),
                SizedBox(height: 18.h),

                MedicationRepeaterContainer(
                  onChanged: (medications) {
                    // ignore: avoid_print
                    print(
                      'Medications updated: \${medications.map((e) => "\${e.name} (\${e.days} days)").toList()}',
                    );
                  },
                ),

                SizedBox(height: 18.h),

                PoochSymptomsList(
                  onTap: (symptom) {
                    AppSnackBar.show(
                      'Tapped on symptom: \$symptom',
                      context: context,
                    );
                  },
                ),

                SizedBox(height: 18.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AppProfileAvatar(
                      localImageFile: _selectedProfileImage,
                      imageUrl:
                          'https://images.unsplash.com/photo-1543466835-00a7907e9de1?auto=format&fit=crop&w=500&q=80',
                      actionIcon: AppIcons.svg.generic.edit,
                      onFileSelected: (file) async {
                        setState(() {
                          _selectedProfileImage = file;
                        });
                      },
                    ),
                    AppProfileAvatar(
                      actionPosition: ActionPosition.rightCenter,
                      localImageFile: _selectedProfileImage,
                      imageUrl:
                          'https://images.unsplash.com/photo-1543466835-00a7907e9de1?auto=format&fit=crop&w=500&q=80',
                      actionIcon: AppIcons.svg.generic.camera,
                      onFileSelected: (file) async {
                        setState(() {
                          _selectedProfileImage = file;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 18.h),
                AppImagePickerBoxes(
                  onChanged: (value) {
                    log('Selected File - $value');
                  },
                ),
                SizedBox(height: 18.h),
                AppText.bodyL('Show Vet Specialities Container'),

                SizedBox(height: 18.h),
                // Clinic Subscription Pan card's
                AppText.bodyL('Clinic Subscription Pan cards'),
                Column(
                  children: [
                    ClinicSubscriptionPlanCard(
                      subscriptionPlan: SubscriptionPlan(
                        title: 'FREE',
                        isBestValue: false,
                        price: 'INR 0',
                        isSelected: false,
                        isSubscribed: false,
                        features: const [
                          'Basic access with 5 free consultations',
                          'Unlimited wellness consultations',
                          'General health checks',
                          'Weight & body condition review',
                          'Skin & coat assessment',
                          'Ear health check',
                          'Nutrition & lifestyle guidance',
                          '6 grooming & hygiene sessions',
                          'Nail trimming',
                          'Ear cleaning',
                        ],
                      ),
                      variant: SubscriptionPlanVariants.free,
                      onSelect: () {},
                    ),

                    SizedBox(height: 12.h),

                    ClinicSubscriptionPlanCard(
                      subscriptionPlan: SubscriptionPlan(
                        title: 'MONTHLY',
                        isBestValue: false,
                        price: 'INR 399',
                        isSelected: true,
                        isSubscribed: true,
                        features: ['Basic access with 5 free consultations'],
                      ),
                      variant: SubscriptionPlanVariants.monthly,
                    ),

                    SizedBox(height: 12.h),

                    ClinicSubscriptionPlanCard(
                      subscriptionPlan: SubscriptionPlan(
                        title: 'ANNUAL',
                        isBestValue: true,
                        price: 'INR 2999',
                        isSelected: false,
                        isSubscribed: false,
                        features: const [
                          'Basic access with 5 free consultations',
                          'Unlimited wellness consultations',
                          'General health checks',
                        ],
                      ),
                      variant: SubscriptionPlanVariants.yearly,
                      onSelect: () {},
                    ),
                  ],
                ),
                SizedBox(height: 18.h),

                AppText.bodyL('Action Card Icon'),
                ActionCardGrid(
                  items: [
                    ActionCardItem(
                      title: 'Consultations',
                      iconPath: AppIcons.svg.actions.consultation,
                      onTap: () {},
                    ),
                    ActionCardItem(
                      title: 'Records',
                      iconPath: AppIcons.svg.actions.record,
                      onTap: () {},
                    ),
                    ActionCardItem(
                      title: 'Vaccinations',
                      iconPath: AppIcons.svg.actions.vaccination,
                      onTap: () {},
                    ),
                    ActionCardItem(
                      title: 'Community',
                      iconPath: AppIcons.svg.actions.community,
                      onTap: () {},
                    ),
                    ActionCardItem(
                      title: 'Tips & Guides',
                      iconPath: AppIcons.svg.actions.tipsGuide,
                      onTap: () {},
                    ),
                    ActionCardItem(
                      title: 'Events',
                      iconPath: AppIcons.svg.actions.events,
                      onTap: () {},
                    ),
                    ActionCardItem(
                      title: 'Report Missing Pet',
                      iconPath: AppIcons.svg.actions.reportMissing,
                      onTap: () {},
                    ),
                    ActionCardItem(
                      title: 'Report Found Pet',
                      iconPath: AppIcons.svg.actions.reportFound,
                      onTap: () {},
                    ),
                    ActionCardItem(
                      title: 'Chats',
                      iconPath: AppIcons.svg.actions.chat,
                      onTap: () {},
                    ),
                  ],
                ),
                SizedBox(height: 18.h),

                /// CLINIC DETAILS CARD
                AppText.bodyM('Clinic Details Card'),
                SizedBox(height: 12.h),
                ClinicDetailsCard(
                  operatingSchedule: const [],
                  clinic: const ClinicDetailsCardModel(
                    id: 'clinic_1',
                    name: 'Dogs & Cats Veterinary Clinic',
                    image:
                        'https://images.unsplash.com/photo-1558788353-f76d92427f16',
                    vetCount: '12 Vets',
                    experience: '20+ yrs experience',
                    location: 'Kandivali East',
                    status: 'Open',
                    closingTime: '09.00 PM',
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Clinic tapped!')),
                    );
                  },
                ),
                SizedBox(height: 24.h),

                // Cart Item Card
                AppText.bodyM('Cart Item Card'),
                SizedBox(height: 12.h),
                CartItemCard(
                  item: const CartItemModel(
                    expectedDeliveryTime: '',
                    id: 'item_1',
                    name: 'Great Anglo-French White & Orange Hound',
                    age: '2 Yrs',
                    gender: 'Female',
                    isVaccinated: true,
                    price: 2000,
                    deliveryText:
                        'Delivery Fee ₹199 · Expected Tomorrow 8 AM–12 PM',
                    imageUrl:
                        'https://images.unsplash.com/photo-1558788353-f76d92427f16',
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Cart item tapped!')),
                    );
                  },
                  onDelete: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Delete tapped!')),
                    );
                  },
                ),
                SizedBox(height: 18.h),
                const PriceSummarySection(
                  itemCount: 2,
                  rows: [
                    PriceSummaryRow(
                      title: 'Total MRP',
                      value: 'INR 10010',
                      titleColor: Color(0xFF666667),
                      valueColor: Color(0xFF666667),
                    ),
                    PriceSummaryRow(
                      title: 'Delivery Fee',
                      value: 'INR 100',
                      titleColor: Color(0xFF666667),
                      valueColor: Color(0xFF666667),
                    ),
                    PriceSummaryRow(
                      title: 'Tax 2%',
                      value: 'INR 80',
                      titleColor: Color(0xFF666667),
                      valueColor: Color(0xFF666667),
                    ),
                    PriceSummaryRow(
                      title: 'Coupon Discount',
                      value: 'INR -501',
                      titleColor: Color(0xFF22C55E),
                      valueColor: Color(0xFF22C55E),
                    ),
                    PriceSummaryRow(
                      title: 'Pooch Super (Add Ons)',
                      value: 'INR 500',
                      titleColor: Color(0xFFF28A07),
                      valueColor: Color(0xFFF28A07),
                    ),
                    PriceSummaryRow(
                      title: 'Total',
                      value: 'INR 10690',
                      titleColor: Color(0xFF49454F),
                      valueColor: Color(0xFF49454F),
                      isTotal: true,
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                /// REASON FOR RETURN SECTION
                AppText.bodyM('Reason For Return Section'),
                SizedBox(height: 12.h),
                ReasonForCancellationSection(
                  cancellationReasons: const [
                    CancellationReasonOption(
                      id: 'wrong_item',
                      label: 'Received wrong pooch',
                    ),
                    CancellationReasonOption(
                      id: 'damaged',
                      label: 'Item received damaged',
                    ),
                    CancellationReasonOption(
                      id: 'defective',
                      label: 'Pooch is defective or has issues',
                    ),
                    CancellationReasonOption(id: 'others', label: 'Others'),
                  ],
                  refundAmount: 1800,
                  onReasonSelected: (reasonId) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Reason selected: $reasonId')),
                    );
                  },
                  onOtherReasonChanged: (reason) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Other reason: $reason')),
                    );
                  },
                ),
                SizedBox(height: 24.h),

                /// APP INFO TILE (NON-EXPANDABLE)
                AppText.bodyM('App Info Tile - Non Expandable'),
                SizedBox(height: 12.h),
                const AppInfoTile(
                  model: AppInfoTileModel(
                    id: 'info_1',
                    title: 'About The Clinic',
                    description:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  ),
                ),
                SizedBox(height: 24.h),

                /// APP INFO TILE (EXPANDABLE)
                AppText.bodyM('App Info Tile - Expandable'),
                SizedBox(height: 12.h),
                const AppInfoTile(
                  model: AppInfoTileModel(
                    id: 'info_2',
                    title: 'About The Clinic',
                    description:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
                    isExpandable: true,
                  ),
                ),
                SizedBox(height: 24.h),

                /// ORDER ITEM PET CARD
                AppText.bodyM('Order Item Pet Card'),
                SizedBox(height: 12.h),
                OrderItemPetCard(
                  model: const OrderItemPetCardModel(
                    id: 'pet_1',
                    image:
                        'https://images.unsplash.com/photo-1558788353-f76d92427f16',
                    title: 'Great Anglo-French White & Orange hound, 2 yrs',
                    gender: 'Female',
                    healthStatus: 'Vaccinated & Dewormed',
                    price: 6010,
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pet card tapped!')),
                    );
                  },
                ),
                SizedBox(height: 24.h),

                AppButton(
                  label: 'Show invite sheet',
                  onPressed: () {
                    InviteBottomSheet.show(
                      headerVariant: HeaderVariant.titleInCenter,
                      context: context,
                      inviteType: InviteType.coparent,
                    );
                  },
                ),
                SizedBox(height: 18.h),
                AppButton(
                  label: 'Show Toast',
                  onPressed: () {
                    ToastService.showSuccess('Showing toast successfully!');
                  },
                ),
                SizedBox(height: 18.h),

                AppButton(
                  label: getDateString(selectedDate: _selectedDate),
                  onPressed: () {
                    AppDatePicker.show(
                      context: context,
                      currentDate: DateTime.now(),
                      initialDate: _selectedDate,
                      // initialDateRange: _selectedDateRange,
                      onDateConfirmed: (date, _) {
                        log('Selected Date is $date');
                        setState(() {
                          _selectedDate = date;
                        });
                      },
                    );
                  },
                ),
                SizedBox(height: 18.h),

                AppButton(
                  label: getDateRangeString(_selectedDateRange),
                  onPressed: () {
                    AppDatePicker.show(
                      context: context,
                      datePickerType: DatePickerType.range,
                      currentDate: DateTime.now(),
                      // initialDate: _selectedDate,
                      initialDateRange: _selectedDateRange,
                      onDateConfirmed: (_, dateRange) {
                        log('Selected Date Range is $dateRange');
                        setState(() {
                          _selectedDateRange = dateRange;
                        });
                      },
                    );
                  },
                ),
                SizedBox(height: 18.h),
                AppButton(
                  label: getDateString(
                    selectedDate: _defaultPickerSelectedDate,
                    defaultText: 'System Date Picker',
                  ),
                  onPressed: () {
                    AppDatePicker.showSystemDatePicker(
                      context: context,
                      currentDate: DateTime.now(),
                      initialDate: _defaultPickerSelectedDate,
                      onDateConfirmed: (date) {
                        setState(() {
                          _defaultPickerSelectedDate = date;
                        });
                      },
                    );
                  },
                ),

                SizedBox(height: 18.h),

                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dummyInvitations.length,
                  separatorBuilder: (_, _) => SizedBox(height: 16.h),
                  itemBuilder: (context, index) {
                    final invitation = dummyInvitations[index];
                    return InvitationCard(
                      invitation: Invitation(
                        inviteeUserId: '',
                        parentGroupId: '',
                        id: '',
                        isRequestSent: invitation['isRequestSent'] as bool,
                        isAccepted: invitation['isAccepted'] as bool,
                        useButterflyImage:
                            invitation['useButterflyImage'] as bool,
                        petName: invitation['petName'] as String,
                        userName: invitation['userName'] as String,
                        ageGender: invitation['ageGender'] as String,
                        role: invitation['role'] as String,
                        imageUrl: invitation['imageUrl'] as String,
                      ),
                      // onAccept: () => _handleInvitationAccept(index),
                      // onReject: () => _handleInvitationReject(index),
                      // onMenuAction: (action) =>
                      //     _handleInvitationMenuAction(index, action),
                    );
                  },
                ),
                SizedBox(height: 18.h),
                const AppTooltip(
                  message:
                      'This is a sample container for sample and simple use just for testing purpose',
                  child: AppButton(label: 'See A Tool Tip'),
                ),

                SizedBox(height: 18.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Coupons & offers',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    AppButton(
                      width: null,
                      variant: AppButtonVariant.text,
                      size: AppButtonSize.small,
                      onPressed: () async {
                        // final selectedCode = await CouponBottomSheet.show(
                        //   context: context,
                        //   coupons: dummyCoupons,
                        //   currentAppliedCode: appliedCoupon,
                        // );

                        // if (selectedCode != null) {
                        //   await Future<void>.delayed(
                        //     const Duration(milliseconds: 600),
                        //   ); // Simulating apply
                        //   if (mounted) {
                        //     setState(() {
                        //       appliedCoupon = selectedCode;
                        //     });
                        //   }
                        // }
                      },
                      label: 'View All',
                    ),
                  ],
                ),

                appliedCoupon != null
                    ? AppliedCouponWidget(
                        key: ValueKey('applied_$appliedCoupon'),
                        code: appliedCoupon!,
                        onRemove: () {
                          setState(() {
                            appliedCoupon = null;
                          });
                        },
                      )
                    : ApplyCouponSection(
                        key: const ValueKey('apply'),
                        onApply: (code) async {
                          await Future<void>.delayed(
                            const Duration(milliseconds: 600),
                          );
                          if (mounted) {
                            setState(() {
                              appliedCoupon = code;
                            });
                          }
                        },
                      ),

                SizedBox(height: 18.h),

                AppButton(
                  label: 'Comment Bottom Sheet',
                  onPressed: () {
                    CommentsBottomSheet.show(
                      context: context,
                      tipId: '452e83f1-db6b-48f3-8130-741a6f8a584a',
                    );
                  },
                ),

                SizedBox(height: 18.h),

                SizedBox(height: 18.h),

                SizedBox(height: 18.h),

                SizedBox(height: 18.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getDateString({
    required DateTime? selectedDate,
    String defaultText = 'Show Date Picker',
  }) {
    return selectedDate != null
        ? '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}'
        : defaultText;
  }

  String getDateRangeString(DateTimeRange? selectedDateRange) {
    final startDate = selectedDateRange?.start;
    final endDate = selectedDateRange?.end;
    if (selectedDateRange != null) {
      return '${startDate!.day.toString().padLeft(2, '0')}/${startDate.month.toString().padLeft(2, '0')}/${startDate.year} to ${endDate?.day.toString().padLeft(2, '0')}/${endDate?.month.toString().padLeft(2, '0')}/${endDate?.year}';
    } else {
      return 'Select Date Range';
    }
  }
}
