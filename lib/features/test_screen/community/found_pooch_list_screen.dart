// ignore_for_file: unused_element, unused_import, unused_local_variable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/widgets/list_items/found_pooch_list_item_card.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/community/presentation/widgets/community_header_card.dart';

// COMMUNITY
@RoutePage()
class FoundPoochListScreen extends StatefulWidget {
  const FoundPoochListScreen({super.key});

  @override
  State<FoundPoochListScreen> createState() => _FoundPoochListScreenState();
}

class _FoundPoochListScreenState extends State<FoundPoochListScreen> {
  late List<FoundPoochItemModel> _items;

  static const List<FoundPoochItemModel> _seedItems = <FoundPoochItemModel>[
    FoundPoochItemModel(
      id: 'found_1',
      userName: 'Sohail Shaikh',
      userImage: 'https://i.pravatar.cc/150?img=12',
      timeAgo: '1 week ago',
      badge: 'Found',
      postImages: [
        'https://images.pexels.com/photos/5731866/pexels-photo-5731866.jpeg',
        'https://images.unsplash.com/photo-1525253086316-d0c936c814f8?q=80&w=1200&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1548767797-d8c844163c4c?q=80&w=1200&auto=format&fit=crop',
      ],
      petSpecifications: 'Dog . 2 yrs . Bella . Female',
      breedSpecifications: 'Husky  .  Dark Brown',
      description:
          'My pet Bella is found since 2 days. She has a mark on her left leg.My pet Bella is found since 2 days. She has a mark on her left leg.My pet Bella is found since 2 days. She has a mark on her left leg.',
      location: 'Jio World Garden, Mumbai',
      lastSeen: 'Sat, 13 Jan at 4:00 PM',
      showFoundBadge: true,
      disclaimer:
          'Any reward mentioned is at the discretion of the reporter. The app is not involved in or responsible for reward exchanges.',
      reward: 'INR 15,000',
    ),
    FoundPoochItemModel(
      id: 'found_2',
      userName: 'Suraj Maurya',
      userImage: 'https://i.pravatar.cc/150?img=25',
      timeAgo: '2 days ago',
      badge: 'Found',
      postImages: [
        'https://images.unsplash.com/photo-1525253086316-d0c936c814f8?q=80&w=1200&auto=format&fit=crop',
      ],
      petSpecifications: 'Dog . 2 yrs . Max . Male',
      breedSpecifications: 'Golden Retriever  .  Light Brown',
      description:
          'My dog Max has been missing since yesterday. He is a golden retriever with a blue collar. He was last seen near Riverfront Plaza. Please contact me if you have any information.',
      location: 'Riverfront Plaza',
      lastSeen: 'Fri, 12 Jan at 6:30 PM',
      showFoundBadge: true,
      disclaimer:
          'Any reward mentioned is at the discretion of the reporter. The app is not involved in or responsible for reward exchanges.',
      reward: 'INR 10,000',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _items = List<FoundPoochItemModel>.from(_seedItems);
  }

  void _openDetail(int index) {
    final FoundPoochItemModel item = _items[index];

    Navigator.of(context).push(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 260),
        reverseTransitionDuration: const Duration(milliseconds: 220),
        pageBuilder: (_, _, _) => _FoundPoochDetailScreen(item: item),
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
            final FoundPoochItemModel item = _items[index];
            return Container();
            // return FoundPoochListItemCard(
            //   item: item,
            //   onCardTap: () => _openDetail(index),
            // );
          },
        ),
      ),
    );
  }
}

class _FoundPoochDetailScreen extends StatelessWidget {
  final FoundPoochItemModel item;

  const _FoundPoochDetailScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarybackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primarybackground,
        title: AppText.h3(
          'Found Pooches',
          color: AppColors.textPrimary,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
        child: Column(
          children: [
            CommunityHeaderCard(
              title: 'Happy Update',
              message:
                  'Bella has been safely found by ${item.userName}\nand is now in loving care.',
            ),
            SizedBox(height: 16.h),
            // FoundPoochListItemCard(item: item, isDetailView: true),
          ],
        ),
      ),
    );
  }
}

class FoundPoochItemModel {
  final String id;
  final String userName;
  final String? userImage;
  final String timeAgo;
  final String badge;
  final List<String> postImages;
  final String? petSpecifications;
  final String? breedSpecifications;
  final String description;
  final String location;
  final String lastSeen;
  final bool showFoundBadge;
  final String disclaimer;
  final String? reward;

  const FoundPoochItemModel({
    required this.id,
    required this.userName,
    required this.userImage,
    required this.timeAgo,
    required this.badge,
    required this.postImages,
    required this.petSpecifications,
    required this.breedSpecifications,
    required this.description,
    required this.location,
    required this.lastSeen,
    required this.showFoundBadge,
    required this.disclaimer,
    this.reward,
  });

  FoundPoochItemModel copyWith({
    String? id,
    String? userName,
    String? userImage,
    String? timeAgo,
    String? badge,
    List<String>? postImages,
    String? petSpecifications,
    String? breedSpecifications,
    String? description,
    String? location,
    String? lastSeen,
    bool? showFoundBadge,
    String? disclaimer,
    String? reward,
  }) {
    return FoundPoochItemModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      userImage: userImage ?? this.userImage,
      timeAgo: timeAgo ?? this.timeAgo,
      badge: badge ?? this.badge,
      postImages: postImages ?? this.postImages,
      petSpecifications: petSpecifications ?? this.petSpecifications,
      breedSpecifications: breedSpecifications ?? this.breedSpecifications,
      description: description ?? this.description,
      location: location ?? this.location,
      lastSeen: lastSeen ?? this.lastSeen,
      showFoundBadge: showFoundBadge ?? this.showFoundBadge,
      disclaimer: disclaimer ?? this.disclaimer,
      reward: reward ?? this.reward,
    );
  }
}
