// ignore_for_file: unused_import, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/chips/app_chip.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/list_items/found_pooch_hlist_item_card.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/community/presentation/widgets/confirm_action_card.dart';
import 'package:poochcare/features/community/presentation/widgets/pet_photo_card.dart';
import 'package:poochcare/features/test_screen/community/events_list_screen.dart';
import 'package:poochcare/features/test_screen/community/found_pooch_list_screen.dart';
import 'package:poochcare/features/test_screen/community/missing_pooch_list_screen.dart';
import 'package:poochcare/features/test_screen/community/tips_info_list_screen.dart';

class CommunityHorizontalListScreen extends StatefulWidget {
  const CommunityHorizontalListScreen({super.key});

  @override
  State<CommunityHorizontalListScreen> createState() =>
      _CommunityHorizontalListScreenState();
}

class _CommunityHorizontalListScreenState
    extends State<CommunityHorizontalListScreen> {
  static const List<TipsInfoItemModel> _tipsItems = <TipsInfoItemModel>[
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
      description:
          'Always transition your pet to new food gradually over 5–7 days.',
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
      userName: 'Kamal Singh',
      userImage:
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=400&auto=format&fit=crop',
      timeAgo: '5 mins ago',
      badge: 'Health',
      postImage:
          'https://images.unsplash.com/photo-1601758174114-e711c0cbaa69?q=80&w=1200&auto=format&fit=crop',
      title: 'Do puppies need supplements daily?',
      description:
          'Always transition your pet to new food gradually over 5–7 days.',
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

  static const List<EventsItemModel> _eventsItems = <EventsItemModel>[
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
      location: 'Lodhi Gardens, New Delhi',
      date: 'Sat, 20 Jan',
      time: '6:00 AM',
      likesCount: 58,
      commentsCount: 22,
      isLiked: false,
      showEventsBadge: true,
      eventsLongDescription:
          'Participate in our annual 5K walk & pet run, the perfect opportunity to exercise with your furry companion. Our event features a dedicated track for pet runs, professional timing services, and a celebration of pet wellness. After the run, enjoy our treat zone with refreshments and pet snacks. Meet other pet lovers, compete in friendly challenges, and support local pet charities. All fitness levels welcome!',
    ),
  ];

  static const List<MissingPoochItemModel>
  _missingPoochItems = <MissingPoochItemModel>[
    MissingPoochItemModel(
      id: 'missing_1',
      userName: 'Sohail Shaikh',
      userImage: 'https://i.pravatar.cc/150?img=12',
      timeAgo: '1 week ago',
      badge: 'Missing',
      postImages: [
        'https://images.pexels.com/photos/5731866/pexels-photo-5731866.jpeg',
        'https://images.unsplash.com/photo-1525253086316-d0c936c814f8?q=80&w=1200&auto=format&fit=crop',
      ],
      petSpecifications: 'Dog . 2 yrs . Bella . Female',
      breedSpecifications: 'Husky . Dark Brown',
      description:
          'My pet Bella is missing since 2 days. She has a mark on her left leg.',
      location: 'Jio World Garden, Mumbai',
      lastSeen: 'Sat, 13 Jan at 4:00 PM',
      showMissingBadge: true,
      disclaimer:
          'Any reward mentioned is at the discretion of the reporter. The app is not involved in or responsible for reward exchanges.',
      reward: 'INR 15,000',
    ),
    MissingPoochItemModel(
      id: 'missing_2',
      userName: 'Suraj Maurya',
      userImage: 'https://i.pravatar.cc/150?img=25',
      timeAgo: '2 days ago',
      badge: 'Missing',
      postImages: [
        'https://images.unsplash.com/photo-1525253086316-d0c936c814f8?q=80&w=1200&auto=format&fit=crop',
        'https://images.unsplash.com/photo-1548767797-d8c844163c4c?q=80&w=1200&auto=format&fit=crop',
      ],
      petSpecifications: 'Dog . 3 yrs . Max . Male',
      breedSpecifications: 'Golden Retriever . Light Brown',
      description:
          'Missing our beloved dog Max for 3 days now. Any information appreciated!',
      location: 'Lodhi Gardens, New Delhi',
      lastSeen: 'Wed, 10 Jan at 6:30 PM',
      showMissingBadge: true,
      disclaimer:
          'Any reward mentioned is at the discretion of the reporter. The app is not involved in or responsible for reward exchanges.',
      reward: 'INR 10,000',
    ),
  ];

  static const List<FoundPoochItemModel>
  _foundPoochItems = <FoundPoochItemModel>[
    FoundPoochItemModel(
      id: 'found_1',
      userName: 'Priya Patel',
      userImage: 'https://i.pravatar.cc/150?img=33',
      timeAgo: '3 days ago',
      badge: 'Found',
      postImages: [
        'https://images.pexels.com/photos/5731866/pexels-photo-5731866.jpeg',
      ],
      petSpecifications: 'Dog . Male',
      breedSpecifications: 'Labrador . Black',
      description:
          'Found this sweet boy near the park. Very friendly and well-behaved. Help reunite with owner!',
      location: 'Central Park, Manhattan',
      lastSeen: 'Mon, 15 Jan at 2:30 PM',
      showFoundBadge: true,
      disclaimer:
          'If this is your dog or you know the owner, please contact immediately with proof of ownership.',
    ),
    FoundPoochItemModel(
      id: 'found_2',
      userName: 'Raj Kumar',
      userImage: 'https://i.pravatar.cc/150?img=41',
      timeAgo: '1 day ago',
      badge: 'Found',
      postImages: [
        'https://images.unsplash.com/photo-1543466835-00a7907e9de1?q=80&w=1200&auto=format&fit=crop',
      ],
      petSpecifications: 'Dog . Female',
      breedSpecifications: 'Pug . Fawn',
      description:
          'Found this adorable pug wandering alone. Wearing a collar. Looking for the owner.',
      location: 'Bandra, Mumbai',
      lastSeen: 'Tue, 16 Jan at 5:45 PM',
      showFoundBadge: true,
      disclaimer:
          'Please reach out if you recognize this pug or know the owner. She is in good condition.',
    ),
  ];

  static const List<PetPhotoCardModel> _petPhotoItems = <PetPhotoCardModel>[
    PetPhotoCardModel(
      id: 'pet_1',
      imageUrl:
          'https://images.unsplash.com/photo-1543466835-00a7907e9de1?q=80&w=400&auto=format&fit=crop',
      petInfo: 'Dog . Female . 2 yrs . Bella . Female',
    ),
  ];

  void _switchToTipsTab() {
    DefaultTabController.of(context).animateTo(1);
  }

  void _switchToEventsTab() {
    DefaultTabController.of(context).animateTo(2);
  }

  void _switchToMissingPoochTab() {
    DefaultTabController.of(context).animateTo(3);
  }

  void _switchToFoundPoochTab() {
    DefaultTabController.of(context).animateTo(4);
  }

  late Map<String, bool> _selectedCategories;

  @override
  void initState() {
    super.initState();
    _selectedCategories = {
      'Health': false,
      'Care': false,
      'Diet': false,
      'Exercise': false,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarybackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// SELECT CATEGORY SECTION
              AppText.h2(
                'Select Category',
                color: const Color(0xFF3F3C36),
                fontSize: 16.sp,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  AppChip(
                    label: 'Health',
                    isSelected: _selectedCategories['Health'] ?? false,
                    onSelected: (value) {
                      setState(() {
                        _selectedCategories['Health'] = value;
                      });
                    },
                  ),
                  AppChip(
                    label: 'Care',
                    isSelected: _selectedCategories['Care'] ?? false,
                    onSelected: (value) {
                      setState(() {
                        _selectedCategories['Care'] = value;
                      });
                    },
                  ),
                  AppChip(
                    label: 'Diet',
                    isSelected: _selectedCategories['Diet'] ?? false,
                    onSelected: (value) {
                      setState(() {
                        _selectedCategories['Diet'] = value;
                      });
                    },
                  ),
                  AppChip(
                    label: 'Exercise',
                    isSelected: _selectedCategories['Exercise'] ?? false,
                    onSelected: (value) {
                      setState(() {
                        _selectedCategories['Exercise'] = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 32.h),

              /// FEATURED PETS SECTION
              SizedBox(
                height: 395.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _petPhotoItems.length,
                  separatorBuilder: (_, _) => SizedBox(width: 12.w),
                  itemBuilder: (context, index) {
                    final pet = _petPhotoItems[index];
                    return PetPhotoCard(
                      pet: pet,
                      onTap: () {
                        // Handle pet card tap
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 32.h),

              /// LATEST TIPS AND GUIDE SECTION
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText.h1(
                    'Latest Tips and Guide',
                    color: const Color(0xFF3F3C36),
                    fontSize: 18.sp,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: _switchToTipsTab,
                    child: AppText.h3(
                      'View All >',
                      color: AppColors.textSecondary,
                      fontSize: 12.sp,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 11.h),
              // SizedBox(
              //   height: 100.h,
              //   child: ListView.separated(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: _tipsItems.length,
              //     separatorBuilder: (_, _) => SizedBox(width: 12.w),
              //     itemBuilder: (context, index) {
              //       final item = _tipsItems[index];
              //       return TipsInfoHlistItemCard(
              //         item: item,
              //         onTap: _switchToTipsTab,
              //       );
              //     },
              //   ),
              // ),
              SizedBox(height: 10.h),
              AppButton(
                label: 'Add Tips & Guide',
                width: 156.w,
                height: 32.h,
                trailingIcon: AppIcon(
                  AppIcons.svg.generic.plusSign,
                  color: AppColors.white,
                  size: 12.sp,
                ),
                onPressed: () {
                  // Handle add tips action
                },
                customTextStyle: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText.h1(
                    'Upcoming Events',
                    color: const Color(0xFF3F3C36),
                    fontSize: 18.sp,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: _switchToEventsTab,
                    child: AppText.h3(
                      'View All >',
                      color: AppColors.textSecondary,
                      fontSize: 12.sp,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 11.h),
              // SizedBox(
              //   height: 310.h,
              //   child: ListView.separated(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: _eventsItems.length,
              //     separatorBuilder: (_, _) => SizedBox(width: 12.w),
              //     itemBuilder: (context, index) {
              //       final item = _eventsItems[index];
              //       return EventHlistItemCard(
              //         item: item,
              //         onCardTap: _switchToEventsTab,
              //       );
              //     },
              //   ),
              // ),
              SizedBox(height: 10.h),
              AppButton(
                label: 'Add Your Event',
                width: 156.w,
                height: 32.h,
                trailingIcon: AppIcon(
                  AppIcons.svg.generic.plusSign,
                  color: AppColors.white,
                  size: 12.sp,
                ),
                onPressed: () {
                  // Handle create event action
                },
                customTextStyle: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText.h1(
                    'Missing Pooches',
                    color: const Color(0xFF3F3C36),
                    fontSize: 18.sp,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: _switchToMissingPoochTab,
                    child: AppText.h3(
                      'View All >',
                      color: AppColors.textSecondary,
                      fontSize: 12.sp,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 11.h),
              // SizedBox(
              //   height: 329.h,
              //   child: ListView.separated(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: _missingPoochItems.length,
              //     separatorBuilder: (_, _) => SizedBox(width: 10.w),
              //     itemBuilder: (context, index) {
              //       final item = _missingPoochItems[index];
              //       return MissingPoochHlistItemCard(
              //         item: item,
              //         onCardTap: _switchToMissingPoochTab,
              //       );
              //     },
              //   ),
              // ),
              SizedBox(height: 10.h),
              AppButton(
                label: 'Add Report Missing',
                width: 167.w,
                height: 32.h,
                trailingIcon: AppIcon(
                  AppIcons.svg.generic.plusSign,
                  color: AppColors.white,
                  size: 12.sp,
                ),
                onPressed: () {
                  // Handle report missing action
                },
                customTextStyle: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText.h1(
                    'Found Pooches',
                    color: const Color(0xFF3F3C36),
                    fontSize: 18.sp,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: _switchToFoundPoochTab,
                    child: AppText.h3(
                      'View All >',
                      color: AppColors.textSecondary,
                      fontSize: 12.sp,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 11.h),
              // SizedBox(
              //   height: 275.h,
              //   child: ListView.separated(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: _foundPoochItems.length,
              //     separatorBuilder: (_, _) => SizedBox(width: 10.w),
              //     itemBuilder: (context, index) {
              //       final item = _foundPoochItems[index];
              //       return FoundPoochHlistItemCard(
              //         item: item,
              //         onCardTap: _switchToFoundPoochTab,
              //       );
              //     },
              //   ),
              // ),
              SizedBox(height: 10.h),
              AppButton(
                label: 'Add Report Found',
                width: 162.w,
                height: 32.h,
                trailingIcon: AppIcon(
                  AppIcons.svg.generic.plusSign,
                  color: AppColors.white,
                  size: 12.sp,
                ),
                onPressed: () {
                  // Handle report found action
                },
                customTextStyle: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 32.h),

              /// CONFIRM ACTION CARD
              ConfirmActionCard(
                model: ConfirmActionCardModel(
                  id: 'confirm_submit',
                  disclaimerText:
                      'By submitting this tip, you agree to our Terms & Conditions and Privacy Policy.',
                  primaryButtonLabel: 'Submit',
                  secondaryButtonLabel: 'Save As Draft',
                  onPrimaryPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tip submitted successfully!'),
                      ),
                    );
                  },
                  onSecondaryPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Tip saved as draft!')),
                    );
                  },
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
