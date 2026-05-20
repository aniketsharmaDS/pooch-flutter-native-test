import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/images/app_image_cached_widget.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/fun/presentation/bloc/leaderboard_bloc/leaderboard_bloc.dart';
import 'package:poochcare/features/fun/presentation/bloc/leaderboard_bloc/leaderboard_event.dart';
import 'package:poochcare/features/fun/presentation/bloc/leaderboard_bloc/leaderboard_state.dart';
import 'package:poochcare/features/fun/presentation/widgets/slant_painter.dart';
import 'package:poochcare/features/fun/repository/accessories_repository.dart';
import 'package:poochcare/features/insight/presentation/widgets/state_wrapper.dart';

@RoutePage()
class LeaderboardScreen extends StatefulWidget implements AutoRouteWrapper {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(
      value: LeaderboardBloc(getIt<AccessoriesRepository>())
        ..add(const FetchLeaderboardEvent(1, true)),
      child: this,
    );
  }
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppPrimaryBgContainer(
        child: SafeArea(
          child: Column(
            children: [
              const PoochScreenAppBar(title: 'Leaderboard'),

              Expanded(
                child: BlocBuilder<LeaderboardBloc, LeaderboardState>(
                  builder: (context, state) {
                    final leaderboardItems = state.leaderboardSortedList ?? [];
                    int leaderboardLen = (leaderboardItems).length;

                    return StateWrapper(
                      isLoading:
                          state.leaderboardStatus == LeaderBoardStatus.loading,
                      isError:
                          state.leaderboardStatus == LeaderBoardStatus.failure,
                      isEmpty: (state.leaderboardSortedList ?? []).isEmpty,
                      title: 'Leaderboard',
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.s10,
                              ),
                              alignment: Alignment.bottomCenter,
                              height: 314.h,
                              width: MediaQuery.sizeOf(context).width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    AppIcons.png.leaderboard.leaderboardBg,
                                  ),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (leaderboardLen >= 2) ...[
                                    RankingBar(
                                      userImage:
                                          leaderboardItems[1].profilePicture,
                                      userName: leaderboardItems[1].name,
                                      userPoints:
                                          '${leaderboardItems[1].points} pt',
                                      heigh: 104.h,
                                      text: leaderboardItems[1].rank
                                          .toString()
                                          .padLeft(2, '0'),

                                      type: SlantType.left,
                                      colors: const [
                                        Color(0xFF188C43),
                                        AppColors.a1_100,
                                      ],
                                    ),
                                    const SizedBox(width: AppSpacing.s2),
                                  ],

                                  if (leaderboardLen >= 1) ...[
                                    RankingBar(
                                      userImage:
                                          leaderboardItems.first.profilePicture,
                                      userName: leaderboardItems.first.name,
                                      userPoints:
                                          '${leaderboardItems.first.points} pt',
                                      heigh: 144.h,
                                      text: leaderboardItems.first.rank
                                          .toString()
                                          .padLeft(2, '0'),
                                      type: SlantType.both,
                                      colors: [
                                        AppColors.leaderboardYellowPrimary,
                                        AppColors.leaderboardYellowFade
                                            .withValues(alpha: 0.5),
                                      ],
                                    ),
                                    const SizedBox(width: AppSpacing.s2),
                                  ],
                                  if (leaderboardLen >= 3)
                                    RankingBar(
                                      userImage:
                                          leaderboardItems[2].profilePicture,
                                      userName: leaderboardItems[2].name,
                                      userPoints:
                                          '${leaderboardItems[2].points} pt',
                                      heigh: 104.h,
                                      text: leaderboardItems[2].rank
                                          .toString()
                                          .padLeft(2, '0'),
                                      type: SlantType.right,
                                      colors: [
                                        AppColors.leaderBoardOrange,
                                        AppColors.leaderBoardOrangeFade
                                            .withValues(alpha: 0.8),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withValues(
                                      alpha: 0.5,
                                    ), // Shadow color
                                    spreadRadius:
                                        30, // How much the shadow expands
                                    blurRadius: 20, // How soft the shadow looks
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.s16,
                                ),
                                child: Column(
                                  children: [
                                    if (leaderboardLen < 3) ...[
                                      Center(
                                        child: AppText.bodyS(
                                          'No more leaderboard score available',
                                        ),
                                      ),
                                    ] else
                                      ...List.generate(
                                        leaderboardLen > 3
                                            ? leaderboardLen - 3
                                            : 0,
                                        (index) {
                                          final item =
                                              (state.leaderboardSortedList
                                                  ?.getRange(2, leaderboardLen)
                                                  .toList() ??
                                              [])[index];
                                          return Container(
                                            margin: const EdgeInsets.only(
                                              bottom: AppSpacing.s10,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: AppSpacing.s12,
                                            ),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFFFEFD),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    AppRadiusSize.r16,
                                                  ),
                                            ),
                                            height: 50.h,
                                            child: Row(
                                              children: [
                                                AppText.h1(
                                                  '${item.rank.toString().padLeft(2, '0')}.',
                                                  fontSize: AppFontSize.fs14,
                                                  color: AppColors.p5_200,
                                                ),
                                                const SizedBox(
                                                  width: AppSpacing.s6,
                                                ),
                                                Container(
                                                  height: 35.h,
                                                  width: 35.h,
                                                  clipBehavior: Clip.hardEdge,
                                                  decoration:
                                                      const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                  child: AppImageCachedWidget(
                                                    imageUrl:
                                                        item.profilePicture ??
                                                        '',
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: AppSpacing.s6,
                                                ),
                                                AppText.h3(
                                                  item.name,
                                                  fontSize: AppFontSize.fs14,
                                                  color: AppColors.p5_900,
                                                ),
                                                const Spacer(),
                                                AppText.h1(
                                                  '${item.points} pt',
                                                  fontSize: AppFontSize.fs14,
                                                  color: AppColors.a3,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RankingBar extends StatelessWidget {
  final double heigh;
  final String text;
  final SlantType type;
  final List<Color> colors;
  final String? userImage;
  final String userName;
  final String? userPoints;
  const RankingBar({
    required this.userImage,
    required this.userName,
    required this.userPoints,
    required this.heigh,
    required this.text,
    required this.type,
    required this.colors,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 65,
          width: 65,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: AppIcon(fit: BoxFit.cover, userImage ?? '', size: 65),
        ),
        const SizedBox(height: AppSpacing.s4),
        AppText.h3(userName, fontSize: AppFontSize.fs14),
        AppText.h1(
          userPoints ?? '0',
          fontSize: AppFontSize.fs14,
          color: AppColors.a3,
        ),

        const SizedBox(height: AppSpacing.s12),
        if (type == SlantType.left)
          CustomPaint(
            size: Size(113.h, 24.w),
            painter: GradientSlantPainter(type: SlantType.left, colors: colors),
          )
        else if (type == SlantType.both)
          CustomPaint(
            size: Size(113.h, 24.w),
            painter: GradientSlantPainter(type: SlantType.both, colors: colors),
          )
        else if (type == SlantType.right)
          CustomPaint(
            size: Size(113.h, 24.w),
            painter: GradientSlantPainter(
              type: SlantType.right,
              colors: colors,
            ),
          ),
        const SizedBox(height: AppSpacing.s2),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.topCenter,
          height: heigh,
          width: 113.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: AlignmentGeometry.topCenter,
              end: AlignmentGeometry.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.only(top: AppSpacing.s25),
          child: AppText.displayXL(text, color: AppColors.white),
        ),
      ],
    );
  }
}
