import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/widgets/list_items/my_chats_list_item_card.dart';
import 'package:poochcare/core/widgets/screen/app_primary_screen_container.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class PoochParentChatListScreen extends StatefulWidget {
  const PoochParentChatListScreen({super.key});

  @override
  State<PoochParentChatListScreen> createState() =>
      _PoochParentChatListScreenState();
}

class _PoochParentChatListScreenState extends State<PoochParentChatListScreen> {
  static const List<MyChatItemModel> _chatsItems = <MyChatItemModel>[
    MyChatItemModel(
      id: 'chat_1',
      name: 'Maitri Shah',
      avatarUrl: 'https://i.pravatar.cc/150?img=12',
      messagePreview: 'Looking forward to seeing you and your pup there.',
      time: '1:30 PM',
    ),
    MyChatItemModel(
      id: 'chat_2',
      name: 'Ajit Dayal',
      avatarUrl: 'https://i.pravatar.cc/150?img=25',
      messagePreview: 'Looking forward to see you...',
      time: '1:30 PM',
    ),
    MyChatItemModel(
      id: 'chat_3',
      name: 'Event Enquirer',
      avatarUrl: 'https://i.pravatar.cc/150?img=33',
      messagePreview: 'Hi!',
      time: '1:30 PM',
    ),
    MyChatItemModel(
      id: 'chat_4',
      name: 'Event Organizer',
      avatarUrl: 'https://i.pravatar.cc/150?img=41',
      messagePreview: 'Can I bring my Sphinx cat too ?',
      time: '1:30 PM',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppPrimaryScreenContainer(
      title: 'community.poochParentChatListScreen.title'.tr(),
      child: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          itemCount: _chatsItems.length,
          itemBuilder: (context, index) {
            final item = _chatsItems[index];
            return MyChatListItemCard(
              item: item,
              onTap: () {
                context.router.push(
                  PoochParentChatRoute(
                    userName: item.name,
                    source: 'community_screen',
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
