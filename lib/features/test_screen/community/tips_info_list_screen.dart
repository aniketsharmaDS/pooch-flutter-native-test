import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

// COMMUNITY
@RoutePage()
class TipsInfoListScreen extends StatefulWidget {
  const TipsInfoListScreen({super.key});

  @override
  State<TipsInfoListScreen> createState() => _TipsInfoListScreenState();
}

class _TipsInfoListScreenState extends State<TipsInfoListScreen> {
  late List<TipsInfoItemModel> _items;

  static const List<TipsInfoItemModel> _seedItems = <TipsInfoItemModel>[
    TipsInfoItemModel(
      id: 'tip_1',
      userName: 'Nidhi Vora',
      userImage:
          'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?q=80&w=400&auto=format&fit=crop',
      timeAgo: '7 days ago',
      badge: 'Care',
      postImage:
          'https://images.unsplash.com/photo-1548767797-d8c844163c4c?q=80&w=1200&auto=format&fit=crop',
      title: "What's the best diet for a 6-month-old dog?",
      description: 'Looking for vet-approved food suggestions.',
      hashtags: <String>['DogNutrition', 'PuppyDiet', 'PetHealth', 'VetAdvice'],
      likesCount: 20,
      commentsCount: 6,
      isLiked: true,
      showTipsBadge: true,
      tipsList: <String>[
        'High-Quality Puppy Kibble - Complete nutrition formulated for growth.',
        'Wet Puppy Food Mix - Adds moisture and palatability.',
        'Raw Meaty Bones (Supervised) - Natural chewing + nutrition.',
        'Lean Protein (Boiled Chicken/Turkey) - Easy to digest muscle meat.',
        'Cooked Sweet Potato or Pumpkin - Good fiber and digestion support.',
        'Puppy-Specific High-Protein Formula - Supports bone and muscle development.',
      ],
    ),
    TipsInfoItemModel(
      id: 'tip_2',
      userName: 'Nidhi Shah',
      userImage:
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=400&auto=format&fit=crop',
      timeAgo: '5 mins ago',
      badge: 'Health',
      postImage:
          'https://images.unsplash.com/photo-1601758174114-e711c0cbaa69?q=80&w=1200&auto=format&fit=crop',
      title: 'Do puppies need supplements daily?',
      description:
          'Trying to avoid overfeeding while still supporting immunity.',
      hashtags: <String>['PuppyCare', 'Nutrition', 'DogHealth'],
      likesCount: 8,
      commentsCount: 2,
      isLiked: false,
      showTipsBadge: true,
      tipsList: <String>[
        'Check with your vet before introducing supplements.',
        'Use breed and age-specific recommendations.',
        'Prioritize complete puppy food before add-ons.',
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _items = List<TipsInfoItemModel>.from(_seedItems);
  }

  void _onLikeChanged({required int index, required bool isLiked}) {
    setState(() {
      final TipsInfoItemModel current = _items[index];
      final bool wasLiked = current.isLiked;

      int nextLikesCount = current.likesCount;
      if (!wasLiked && isLiked) {
        nextLikesCount += 1;
      }
      if (wasLiked && !isLiked) {
        nextLikesCount = (nextLikesCount - 1).clamp(0, 1 << 31);
      }

      _items[index] = current.copyWith(
        isLiked: isLiked,
        likesCount: nextLikesCount,
      );
    });
  }

  // ignore: unused_element
  void _openDetail(int index) {
    final TipsInfoItemModel item = _items[index];

    Navigator.of(context).push(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 260),
        reverseTransitionDuration: const Duration(milliseconds: 220),
        pageBuilder: (_, _, _) => _TipsInfoDetailScreen(
          item: item,
          onLikeChanged: (bool isLiked) {
            _onLikeChanged(index: index, isLiked: isLiked);
          },
        ),
        transitionsBuilder: (_, animation, _, child) {
          final Animation<Offset> offsetAnimation =
              Tween<Offset>(
                begin: const Offset(0.0, 0.08),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              );

          return FadeTransition(
            opacity: animation,
            child: SlideTransition(position: offsetAnimation, child: child),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarybackground,
      body: SafeArea(
        child: ListView.separated(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
          itemCount: _items.length,
          separatorBuilder: (_, _) => SizedBox(height: 13.h),
          itemBuilder: (BuildContext context, int index) {
            // final TipsInfoItemModel item = _items[index];
            return Container(
              // child: TipsInfoListItemCard(
              //   item: item,
              //   onLikeChanged: (bool isLiked) {
              //     _onLikeChanged(index: index, isLiked: isLiked);
              //   },
              //   onCardTap: () => _openDetail(index),
              // ),
            );
          },
        ),
      ),
    );
  }
}

class _TipsInfoDetailScreen extends StatelessWidget {
  final TipsInfoItemModel item;
  final ValueChanged<bool> onLikeChanged;

  const _TipsInfoDetailScreen({
    required this.item,
    required this.onLikeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarybackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primarybackground,
        title: AppText.h3(
          'Tips & Info',
          color: AppColors.textPrimary,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
        child: Container(
          // child: TipsInfoListItemCard(
          //   item: item,
          //   isDetailView: true,
          //   onLikeChanged: onLikeChanged,
          // ),
        ),
      ),
    );
  }
}

class TipsInfoItemModel {
  final String id;
  final String userName;
  final String? userImage;
  final String timeAgo;
  final String badge;
  final String postImage;
  final String title;
  final String description;
  final List<String> hashtags;
  final int likesCount;
  final int commentsCount;
  final bool isLiked;
  final bool showTipsBadge;
  final List<String> tipsList;

  const TipsInfoItemModel({
    required this.id,
    required this.userName,
    required this.userImage,
    required this.timeAgo,
    required this.badge,
    required this.postImage,
    required this.title,
    required this.description,
    required this.hashtags,
    required this.likesCount,
    required this.commentsCount,
    required this.isLiked,
    required this.showTipsBadge,
    required this.tipsList,
  });

  TipsInfoItemModel copyWith({
    String? id,
    String? userName,
    String? userImage,
    String? timeAgo,
    String? badge,
    String? postImage,
    String? title,
    String? description,
    List<String>? hashtags,
    int? likesCount,
    int? commentsCount,
    bool? isLiked,
    bool? showTipsBadge,
    List<String>? tipsList,
  }) {
    return TipsInfoItemModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      userImage: userImage ?? this.userImage,
      timeAgo: timeAgo ?? this.timeAgo,
      badge: badge ?? this.badge,
      postImage: postImage ?? this.postImage,
      title: title ?? this.title,
      description: description ?? this.description,
      hashtags: hashtags ?? this.hashtags,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      isLiked: isLiked ?? this.isLiked,
      showTipsBadge: showTipsBadge ?? this.showTipsBadge,
      tipsList: tipsList ?? this.tipsList,
    );
  }
}
