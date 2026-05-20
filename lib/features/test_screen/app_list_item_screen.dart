import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/cards/app_medical_explorer_card.dart';
import 'package:poochcare/core/widgets/feedback/app_snack_bar.dart';
import 'package:poochcare/core/widgets/list_grid/pet_report_history_hlist.dart';
import 'package:poochcare/core/widgets/list_items/medical_history_list_item_card.dart';
import 'package:poochcare/features/ecommerce/data/models/orders/order_item_model.dart';
import 'package:poochcare/features/ecommerce/domain/models/product.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/buy_pet/most_popular_section.dart';

@RoutePage()
class AppListItemScreen extends StatefulWidget {
  const AppListItemScreen({super.key});

  @override
  State<AppListItemScreen> createState() => _AppListItemScreenState();
}

class _AppListItemScreenState extends State<AppListItemScreen> {
  late List<OrderItemModel> orders;
  final List<Map<String, dynamic>> dummyOrders = [
    {
      'orderId': '1234567889',
      'title': 'Great Anglo-French White & Orange Hound',
      'gender': 'Female',
      'dateTime': 'Nov 14th, 12:00 PM',
      'price': 6010,
      'originalPrice': 13000,
      'status': 'On time',
      'image': 'https://images.unsplash.com/photo-1558788353-f76d92427f16?',
    },
    {
      'orderId': '1234567890',
      'title': 'Beagle, 5 yrs',
      'gender': 'Female',
      'dateTime': 'Nov 14th, 12:00 PM',
      'price': 5040,
      'originalPrice': 13000,
      'status': 'On time',
      'image': 'https://images.unsplash.com/photo-1558788353-f76d92427f16?',
    },
  ];

  final List<Map<String, dynamic>> dummyTips = [
    {
      'id': 'tip1',
      'user': {
        'name': 'John Doe',
        'profile': {'profilePicture': 'https://example.com/profile.jpg'},
      },
      'createdAt': DateTime.now()
          .subtract(const Duration(minutes: 30))
          .toIso8601String(),
      'title': 'How to Train Your Dog',
      'description': 'Here are some tips on training your dog effectively...',
      'category': {'name': 'Training'},
      'attachmentUrls': ['https://example.com/image1.jpg'],
      'isLiked': false,
      'likesCount': 10,
      'commentsCount': 5,
    },
    {
      'id': 'tip2',
      'user': {
        'name': 'Jane Smith',
        'profile': {'profilePicture': 'https://example.com/profile2.jpg'},
      },
      'createdAt': DateTime.now()
          .subtract(const Duration(hours: 2))
          .toIso8601String(),
      'title': 'Best Dog Foods in 2024',
      'description':
          'I have tried several dog foods and here are my top picks...',
      'category': {'name': 'Nutrition'},
      'attachmentUrls': ['https://example.com/image2.jpg'],
      'isLiked': true,
      'likesCount': 25,
      'commentsCount': 8,
    },
    {
      'id': 'tip3',
      'user': {
        'name': 'Emily Johnson',
        'profile': {'profilePicture': 'https://example.com/profile3.jpg'},
      },
      'createdAt': DateTime.now()
          .subtract(const Duration(days: 1))
          .toIso8601String(),
      'title': 'Top 5 Dog Parks in NYC',
      'description': 'If you are in NYC, these dog parks are a must-visit...',
      'category': {'name': 'Lifestyle'},
      'attachmentUrls': ['https://example.com/image3.jpg'],
      'isLiked': false,
      'likesCount': 15,
      'commentsCount': 3,
    },
  ];

  @override
  void initState() {
    super.initState();
    // orders = dummyOrders.map((e) {
    //   return OrderItemModel.fromJson(e, () {
    //     // ignore: avoid_print
    //     print("Track clicked for order ${e['orderId']}");
    //   });
    // }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List Item Screen')),
      backgroundColor: const Color.fromARGB(255, 249, 246, 237),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                'Pet Medical Explorer Card',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6.h),
              Row(
                children: [
                  Expanded(
                    child: AppMedicalExplorerCard(
                      title: 'Lab Test',
                      buttonText: 'Explore Now',
                      imagePath: AppIcons.png.explore.labTest,
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppMedicalExplorerCard(
                      title: 'Vaccinations',
                      buttonText: 'Explore Now',
                      imagePath: AppIcons.png.explore.vaccination,
                      onTap: () {},
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),
              Text(
                'Medical History Item List Card',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 18.h),
              MedicalHistoryListItemCard(
                item: MedicalHistoryItem(
                  type: ItemType.consultation,
                  title: 'Online consultation',
                  data: MedicalData(
                    recordId: 'record1',
                    appointmentId: 'appointment1',
                    title: 'Modern Vet Clinic',
                    subtitle: 'Nov 14th, 12:00 pm',
                    dateTime: 'INR 2010',
                    documents: [],
                  ),
                ),
                onItemClick: () {
                  // ignore: avoid_print
                  print('Card clicked');
                },
              ),
              SizedBox(height: 6.h),
              MedicalHistoryListItemCard(
                item: MedicalHistoryItem(
                  type: ItemType.vaccination,
                  title: 'Vaccination',
                  data: MedicalData(
                    recordId: 'record2',
                    appointmentId: 'appointment2',
                    title: 'Vaccination certificate',
                    subtitle: 'Modern Vet clinic',
                    dateTime: 'Nov 14th, 12:00 pm',
                    documents: [],
                  ),
                ),
                onItemClick: () {
                  // ignore: avoid_print
                  print('Card clicked');
                },
              ),
              SizedBox(height: 6.h),
              MedicalHistoryListItemCard(
                item: MedicalHistoryItem(
                  type: ItemType.labReport,
                  title: 'Lab Reports',
                  data: MedicalData(
                    recordId: 'record3',
                    appointmentId: 'appointment3',
                    title: 'CBC Report',
                    subtitle: 'Zodiac lab',
                    dateTime: 'Nov 14th, 12:00 pm',
                    documents: [
                      MedicalDocument(
                        fileName: 'CBC_Report.pdf',
                        fileSize: '256 KB',
                        // localPath: 'testing/local/path/CBC_Report.pdf',
                        onDownload: () async {
                          await Future<dynamic>.delayed(
                            const Duration(seconds: 1),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                onItemClick: () {
                  // ignore: avoid_print
                  print('Card clicked');
                },
              ),
              SizedBox(height: 40.h),
              PetReportHistoryHlist(
                onTap: (symptom) {
                  AppSnackBar.show(
                    'Tapped on symptom: \$symptom',
                    context: context,
                  );
                },
              ),
              SizedBox(height: 18.h),
              Text(
                'Order\'d Item List Card',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 18.h),

              // ListView.separated(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemCount: orders.length,
              //   separatorBuilder: (BuildContext context, int index) =>
              //       SizedBox(height: 12.h),
              //   itemBuilder: (context, index) {
              //     final order = orders[index];
              //     return OrderListCard(
              //       item: order,
              //       actionLabel: _getActionLabel(),
              //       onAction: () {
              //         ScaffoldMessenger.of(context).showSnackBar(
              //           SnackBar(content: Text('Track order ${order.orderId}')),
              //         );
              //       },
              //     );
              //   },
              // ),
              SizedBox(height: 16.h),
              Text(
                'Clinic Grid Card',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
              // SizedBox(height: 12.h),
              // SizedBox(
              //   height: 270.h,
              //   child: ListView.separated(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: dummyClinics.length,
              //     separatorBuilder: (BuildContext context, int index) =>
              //         SizedBox(width: 12.w),
              //     itemBuilder: (context, index) {
              //       final clinic = dummyClinics[index];
              //       return ClinicGridItemCard(
              //         clinic: clinic,
              //         onTap: () {
              //           ScaffoldMessenger.of(context).showSnackBar(
              //             SnackBar(content: Text('Tapped ${clinic.name}')),
              //           );
              //         },
              //       );
              //     },
              //   ),
              // ),
              SizedBox(height: 20.h),
              Text(
                'Clinic List Card',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),

              SizedBox(height: 12.h),
              MostPopularSection(
                products: const <Product>[],
                isLoading: false,
                error: null,
                onRetry: () {},
                onTap: (symptom) {
                  AppSnackBar.show(
                    'Tapped on symptom: \$symptom',
                    context: context,
                  );
                },
              ),
              SizedBox(height: 12.h),
              SizedBox(height: 12.h),
              SizedBox(height: 40.h),

              // ListView.separated(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemCount: dummyTips.length,
              //   separatorBuilder: (BuildContext context, int index) =>
              //       SizedBox(height: 12.h),
              //   itemBuilder: (context, index) {
              //     final tip = dummyTips[index];
              //     final tipsModel = TipsInfoItemModel(
              //       id: tip['id'] as String? ?? '',
              //       userName: tip['user']?['name'] as String? ?? 'Unknown User',
              //       userImage:
              //           tip['user']?['profile']?['profilePicture'] as String? ??
              //           '',
              //       timeAgo: formatRelativeTime(
              //         tip['createdAt'] as String? ?? '',
              //       ),
              //       badge: tip['category']?['name'] as String? ?? 'Tips',
              //       postImage:
              //           (tip['attachmentUrls'] as List<dynamic>? ?? const [])
              //               .isNotEmpty
              //           ? (tip['attachmentUrls'] as List<dynamic>).first
              //                     as String? ??
              //                 ''
              //           : '',
              //       title: tip['title'] as String? ?? 'No Title',
              //       description:
              //           tip['description'] as String? ??
              //           'No description available.',
              //       hashtags: const <String>[
              //         'DogNutrition',
              //         'PuppyDiet',
              //         'PetHealth',
              //         'VetAdvice',
              //       ],
              //       likesCount: tip['likesCount'] as int? ?? 0,
              //       commentsCount: tip['commentsCount'] as int? ?? 0,
              //       isLiked: tip['isLiked'] as bool? ?? false,
              //       showTipsBadge: true,
              //       tipsList: const <String>[],
              //     );
              //     return TipsInfoListItemCard(
              //       item: tipsModel,
              //       onCardTap: () {
              //         ScaffoldMessenger.of(context).showSnackBar(
              //           SnackBar(
              //             content: Text('Tapped on tip: ${tip['title']}'),
              //           ),
              //         );
              //       },
              //       onCommentTap: () {},
              //       onLikeChanged: (_) {},
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
