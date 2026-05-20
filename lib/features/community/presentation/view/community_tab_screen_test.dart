import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/features/test_screen/community/community_horizontal_list_screen.dart';
import 'package:poochcare/features/test_screen/community/events_list_screen.dart';
import 'package:poochcare/features/test_screen/community/found_pooch_list_screen.dart';
import 'package:poochcare/features/test_screen/community/missing_pooch_list_screen.dart';
import 'package:poochcare/features/test_screen/community/my_chat_list_screen.dart';
import 'package:poochcare/features/test_screen/community/pet_shelter_list_screen.dart';
import 'package:poochcare/features/test_screen/community/tips_info_list_screen.dart';

@RoutePage()
class CommunityTabScreen extends StatefulWidget {
  const CommunityTabScreen({super.key});

  @override
  State<CommunityTabScreen> createState() => _CommunityTabScreenState();
}

class _CommunityTabScreenState extends State<CommunityTabScreen> {
  static const List<Widget> _pages = <Widget>[
    CommunityHorizontalListScreen(),
    TipsInfoListScreen(),
    EventsListScreen(),
    MissingPoochListScreen(),
    FoundPoochListScreen(),
    MyChatListScreen(),
    PetShelterListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _pages.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Community'),
          backgroundColor: AppColors.primarybackground,
          elevation: 0,
          bottom: const TabBar(
            indicatorColor: AppColors.primary,
            labelColor: AppColors.textPrimary,
            unselectedLabelColor: AppColors.textSecondary,
            isScrollable: true,
            tabs: [
              Tab(text: 'Discover', icon: Icon(Icons.explore)),
              Tab(text: 'Tips & Info', icon: Icon(Icons.lightbulb_outline)),
              Tab(text: 'Events', icon: Icon(Icons.event_note)),
              Tab(text: 'Missing Pooch', icon: Icon(Icons.pets)),
              Tab(text: 'Found Pooch', icon: Icon(Icons.search)),
              Tab(text: 'My Chats', icon: Icon(Icons.chat_bubble_outline)),
              Tab(text: 'Pet Shelters', icon: Icon(Icons.business)),
            ],
          ),
        ),
        body: Column(
          children: [
            const Expanded(child: TabBarView(children: _pages)),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}
