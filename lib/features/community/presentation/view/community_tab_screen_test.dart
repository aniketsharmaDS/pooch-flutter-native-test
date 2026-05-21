import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
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
          title: Text('community.communityTabTest.title'.tr()),
          backgroundColor: AppColors.primarybackground,
          elevation: 0,
          bottom: TabBar(
            indicatorColor: AppColors.primary,
            labelColor: AppColors.textPrimary,
            unselectedLabelColor: AppColors.textSecondary,
            isScrollable: true,
            tabs: [
              Tab(
                text: 'community.communityTabTest.discover'.tr(),
                icon: const Icon(Icons.explore),
              ),
              Tab(
                text: 'community.communityTabTest.tipsAndInfo'.tr(),
                icon: const Icon(Icons.lightbulb_outline),
              ),
              Tab(
                text: 'community.communityTabTest.events'.tr(),
                icon: const Icon(Icons.event_note),
              ),
              Tab(
                text: 'community.communityTabTest.missingPooch'.tr(),
                icon: const Icon(Icons.pets),
              ),
              Tab(
                text: 'community.communityTabTest.foundPooch'.tr(),
                icon: const Icon(Icons.search),
              ),
              Tab(
                text: 'community.communityTabTest.myChats'.tr(),
                icon: const Icon(Icons.chat_bubble_outline),
              ),
              Tab(
                text: 'community.communityTabTest.petShelters'.tr(),
                icon: const Icon(Icons.business),
              ),
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
