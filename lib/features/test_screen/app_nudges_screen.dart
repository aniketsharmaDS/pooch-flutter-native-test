import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/widgets/nudges/find_me_vet_pooch_nudge.dart';
import 'package:poochcare/core/widgets/nudges/pooch_super_offer_nudge.dart';
import 'package:poochcare/core/widgets/nudges/report_a_lost_pet_nudge.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/nudges/buy_or_adopt_pooch_nudge.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/nudges/help_me_find_pooch_nudge.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/nudges/join_pooch_community_nudge.dart';

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

                HelpMeFindPoochNudge(
                  onGetHelp: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Get Help clicked')),
                    );
                  },
                ),

                SizedBox(height: 12.h),

                FindMeVetPoochNudge(
                  onGetHelp: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Get Help clicked')),
                    );
                  },
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

                JoinPoochCommunityNudge(
                  onJoinNow: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Join Now clicked')),
                    );
                  },
                ),

                SizedBox(height: 12.h),

                BuyOrAdoptPoochNudge(
                  onBuyOrAdopt: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Buy or Adopt clicked')),
                    );
                  },
                ),

                SizedBox(height: 12.h),

                ReportALostPetNudge(
                  onReport: () {
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
