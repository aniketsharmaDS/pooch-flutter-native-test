import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_icons.dart';
// import 'package:poochcare/core/widgets/nudges/find_me_vet_pooch_nudge.dart';
import 'package:poochcare/core/widgets/nudges/pooch_super_offer_nudge.dart';
// import 'package:poochcare/core/widgets/nudges/report_a_lost_pet_nudge.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/nudges/app_nudge_card.dart';
// import 'package:poochcare/features/ecommerce/presentation/widgets/nudges/buy_or_adopt_pooch_nudge.dart';
// import 'package:poochcare/features/ecommerce/presentation/widgets/nudges/help_me_find_pooch_nudge.dart';
// import 'package:poochcare/features/ecommerce/presentation/widgets/nudges/join_pooch_community_nudge.dart';

@RoutePage()
class AppNudgesScreen extends StatefulWidget {
  const AppNudgesScreen({super.key});

  @override
  State<AppNudgesScreen> createState() => _AppNudgesScreenState();
}

class _AppNudgesScreenState extends State<AppNudgesScreen> {
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
                Text(
                  'Nudges',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 16.h),

                Text(
                  'Get Help finding a pooch nudge',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 12.h),

                AppNudgeCard(
                  cardTitle: 'Help me find or discover a Pooch',
                  cardDescription:
                      'A pooch is family - let us help you find the right one.',
                  cardButtonTitle: 'Get Help',
                  cardBackgroundImage:
                      AppIcons.png.nudges.helpDiscoverPoochCardBg,
                  cardAction: () {},
                ),

                SizedBox(height: 12.h),

                AppNudgeCard(
                  cardTitle: 'Your Vet Support, Anytime You Need It',
                  cardDescription: 'Quick, trusted care for your pooch.',
                  cardButtonTitle: 'Find vet clinics',
                  cardBackgroundImage:
                      AppIcons.png.nudges.vetSupportPoochCardBg,
                  cardTextInverse: true,
                  cardVariantVet: true,
                  cardAction: () {},
                ),

                SizedBox(height: 12.h),

                Text(
                  'Join pooch community nudge',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 12.h),

                AppNudgeCard(
                  cardTitle: 'Join the Pooch Community',
                  cardDescription:
                      'Find advice, share stories, and grow together',
                  cardButtonTitle: 'Join Now',
                  cardBackgroundImage:
                      AppIcons.png.nudges.joinPoochCommunityCardBg,
                  cardAction: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Join Now clicked')),
                    );
                  },
                ),

                SizedBox(height: 12.h),

                AppNudgeCard(
                  cardTitle: 'Buy or adopt a pooch you love',
                  cardDescription:
                      'Find the perfect pup and give them a loving home',
                  cardButtonTitle: 'See Pets',
                  cardBackgroundImage: AppIcons.png.nudges.buyAdoptPoochCardBg,
                  cardAction: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Buy or Adopt clicked')),
                    );
                  },
                ),

                SizedBox(height: 12.h),

                AppNudgeCard(
                  cardTitle: 'Report a Lost Pet',
                  cardDescription:
                      'Help the community spot your pooch and bring them home safely.',
                  cardButtonTitle: 'Report Now',
                  cardBackgroundImage: AppIcons.png.nudges.reportPetPoochCardBg,
                  cardTextInverse: true,
                  cardAction: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Report a Lost Pet clicked'),
                      ),
                    );
                  },
                ),

                SizedBox(height: 12.h),
                Text(
                  'Pooch super offer nudge',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 12.h),

                PoochSuperOfferNudge(
                  discountTitle: 'Get 10%',
                  discountSubText: 'On next 5 purchases.',
                  price: 'INR 500',
                  btnTitle: 'Add',
                  onAdd: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pooch Super Add clicked')),
                    );
                  },
                ),

                SizedBox(height: 24.h),
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
}
