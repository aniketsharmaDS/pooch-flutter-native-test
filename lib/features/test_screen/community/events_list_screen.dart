// ignore_for_file: unused_element, unused_import

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/widgets/list_items/event_list_item_card.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

// COMMUNITY
@RoutePage()
class EventsListScreen extends StatefulWidget {
  const EventsListScreen({super.key});

  @override
  State<EventsListScreen> createState() => _EventsListScreenState();
}

class _EventsListScreenState extends State<EventsListScreen> {
  late List<EventsItemModel> _items;

  static const List<EventsItemModel> _seedItems = <EventsItemModel>[
    EventsItemModel(
      id: 'event_1',
      userName: 'Sohail Shaikh',
      userImage: 'https://i.pravatar.cc/150?img=12',
      timeAgo: '1 week ago',
      postImage:
          'https://images.pexels.com/photos/5731866/pexels-photo-5731866.jpeg',
      title: 'Paws & Claws Mini Pet Expo',
      description:
          'Join us for an inclusive day of pet health workshops and local vendor stalls.',
      location: 'Jio World Garden, Mumbai',
      date: 'Sun, 14 Jan',
      time: '1:00 PM',
      likesCount: 42,
      commentsCount: 14,
      isLiked: true,
      showEventsBadge: true,
      eventsLongDescription:
          'Discover the latest in pet care at our inclusive mini expo, designed for all pet parents. Engage in expert-led workshops covering nutrition, grooming, and health. Explore stalls from local vendors offering everything from organic treats to stylish accessories. Connect with fellow pet lovers and share experiences in a welcoming environment. A perfect day out for you and your furry friend to learn, shop, and socialize.',
    ),
    EventsItemModel(
      id: 'event_2',
      userName: 'Suraj Maurya',
      userImage: 'https://i.pravatar.cc/150?img=25',
      timeAgo: '2 days ago',
      postImage:
          'https://images.unsplash.com/photo-1525253086316-d0c936c814f8?q=80&w=1200&auto=format&fit=crop',
      title: 'Annual 5K Walk & Pet Run',
      description:
          'Bring your pet for a fun 5K, with a post-run treat zone and charity stalls.',
      location: 'Riverfront Plaza',
      date: 'Sun, 10 Jan',
      time: '10:00 AM - 1:00 PM',
      likesCount: 26,
      commentsCount: 5,
      isLiked: false,
      showEventsBadge: true,
      eventsLongDescription:
          'Pet and parents can have a day out in Mumbai’s cozy outdoor space designed for fun and connection.Spend quality time bonding with your furry companion in a relaxed, pet-friendly environment.Enjoy playful activities, socialisation, and light games for pets.Meet fellow pet parents and share experiences.Discover helpful tips from local pet experts.A perfect weekend plan for you and your pet.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _items = List<EventsItemModel>.from(_seedItems);
  }

  void _onLikeChanged({required int index, required bool isLiked}) {
    setState(() {
      final EventsItemModel current = _items[index];
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

  void _openDetail(int index) {
    final EventsItemModel item = _items[index];

    Navigator.of(context).push(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 260),
        reverseTransitionDuration: const Duration(milliseconds: 220),
        pageBuilder: (_, _, _) => _EventsDetailScreen(
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
            // final EventsItemModel item = _items[index];
            return Container(
              // child: EventListItemCard(
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

class _EventsDetailScreen extends StatelessWidget {
  final EventsItemModel item;
  final ValueChanged<bool> onLikeChanged;

  const _EventsDetailScreen({required this.item, required this.onLikeChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarybackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primarybackground,
        title: AppText.h3(
          'Events',
          color: AppColors.textPrimary,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
        child: Container(
          // child: EventListItemCard(
          //   item: item,
          //   isDetailView: true,
          //   onLikeChanged: onLikeChanged,
          // ),
        ),
      ),
    );
  }
}

class EventsItemModel {
  final String id;
  final String userName;
  final String? userImage;
  final String timeAgo;
  final String postImage;
  final String title;
  final String description;
  final String location;
  final String date;
  final String time;
  final int likesCount;
  final int commentsCount;
  final bool isLiked;
  final bool showEventsBadge;
  final String eventsLongDescription;

  const EventsItemModel({
    required this.id,
    required this.userName,
    required this.userImage,
    required this.timeAgo,
    required this.postImage,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    required this.time,
    required this.likesCount,
    required this.commentsCount,
    required this.isLiked,
    required this.showEventsBadge,
    required this.eventsLongDescription,
  });

  EventsItemModel copyWith({
    String? id,
    String? userName,
    String? userImage,
    String? timeAgo,
    String? postImage,
    String? title,
    String? description,
    String? location,
    String? date,
    String? time,
    int? likesCount,
    int? commentsCount,
    bool? isLiked,
    bool? showEventsBadge,
    String? eventsLongDescription,
  }) {
    return EventsItemModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      userImage: userImage ?? this.userImage,
      timeAgo: timeAgo ?? this.timeAgo,
      postImage: postImage ?? this.postImage,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      date: date ?? this.date,
      time: time ?? this.time,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      isLiked: isLiked ?? this.isLiked,
      showEventsBadge: showEventsBadge ?? this.showEventsBadge,
      eventsLongDescription:
          eventsLongDescription ?? this.eventsLongDescription,
    );
  }
}
