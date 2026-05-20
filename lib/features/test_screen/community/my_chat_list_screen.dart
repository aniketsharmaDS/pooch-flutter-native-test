import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/widgets/list_items/my_chats_list_item_card.dart';

class MyChatListScreen extends StatefulWidget {
  const MyChatListScreen({super.key});

  @override
  State<MyChatListScreen> createState() => _MyChatListScreenState();
}

class _MyChatListScreenState extends State<MyChatListScreen> {
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
    return Scaffold(
      backgroundColor: AppColors.primarybackground,
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          itemCount: _chatsItems.length,
          itemBuilder: (context, index) {
            final item = _chatsItems[index];
            return MyChatListItemCard(
              item: item,
              onTap: () {
                // Handle tap to open detailed chat
              },
            );
          },
        ),
      ),
    );
  }
}
