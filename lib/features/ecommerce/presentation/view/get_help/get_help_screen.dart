import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/appbar/pooch_assistant_app_bar.dart';
import 'package:poochcare/core/widgets/cards/app_wave_card.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/get_help/get_help_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/get_help/get_help_event.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/get_help/get_help_state.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/wishlist/wishlist_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/wishlist/wishlist_event.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/buy_pet/product_grid_item_card.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/get_help/chat_message_tile.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/get_help/progress_section.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/shimmers/product_grid_item_card_shimmer.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class GetHelpScreen extends StatefulWidget {
  const GetHelpScreen({super.key});

  @override
  State<GetHelpScreen> createState() => _GetHelpScreenState();
}

class _GetHelpScreenState extends State<GetHelpScreen> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _recommendationKey = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // void _scrollToRecommendations() {
  //   final context = _recommendationKey.currentContext;

  //   if (context != null) {
  //     Scrollable.ensureVisible(
  //       context,
  //       duration: const Duration(milliseconds: 400),
  //       curve: Curves.easeInOut,
  //       alignment: 0.1, // 👈 IMPORTANT (not 0, better UX)
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GetHelpBloc>()..add(StartGetHelp()),
      child: Scaffold(
        body: AppPrimaryBgContainer(
          child: SafeArea(
            child: Column(
              children: [
                const PoochAssistantAppBar(),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned(
                        top: 55, // adjust this to control how much shows
                        right: -10, // adjust this to control how much shows
                        child: Padding(
                          padding: EdgeInsets.only(left: AppSpacing.s6.w),
                          child: SizedBox(
                            height: AppSize.cs130.csh,
                            width: AppSize.cs130.csw,
                            child: AppIcon(
                              AppIcons.png.generic.poochPetBg,
                              // height: AppSize.cs200.csh ,
                              // width: AppSize.cs200.csw,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.s8.w,
                        ),
                        child: AppWaveCard(
                          isGlass: true,
                          isElevated: true,
                          child: Padding(
                            padding: EdgeInsets.only(top: AppSpacing.s12.h),
                            child: BlocListener<GetHelpBloc, GetHelpState>(
                              listenWhen: (previous, current) {
                                // 🔹 Trigger listener if the number of messages changed
                                if (previous.messages.length !=
                                    current.messages.length) {
                                  return true;
                                }

                                // 🔹 Trigger listener if any message text or typing status changed
                                for (
                                  int i = 0;
                                  i < previous.messages.length;
                                  i++
                                ) {
                                  if (previous.messages[i].text !=
                                          current.messages[i].text ||
                                      previous.messages[i].isTyping !=
                                          current.messages[i].isTyping) {
                                    return true;
                                  }
                                }

                                // 🔹 Trigger listener if recommendations changed
                                if (previous.recommendations.length !=
                                    current.recommendations.length) {
                                  return true;
                                }

                                return false; // otherwise, do not trigger
                              },
                              listener: (context, state) {
                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) {
                                  if (!_scrollController.hasClients) return;

                                  if (state.recommendations.isNotEmpty &&
                                      state.hasOpenedRecommendations) {
                                    // 🔹 Scroll to recommendations grid
                                    final contextRec =
                                        _recommendationKey.currentContext;
                                    if (contextRec != null) {
                                      final box =
                                          contextRec.findRenderObject()
                                              as RenderBox;
                                      final position = box.localToGlobal(
                                        Offset.zero,
                                      );
                                      final offset =
                                          _scrollController.offset +
                                          position.dy -
                                          100;
                                      _scrollController.animateTo(
                                        offset,
                                        duration: const Duration(
                                          milliseconds: 400,
                                        ),
                                        curve: Curves.easeInOut,
                                      );
                                      return;
                                    }
                                  }

                                  // 🔹 Normal chat flow → scroll to bottom
                                  _scrollController.animateTo(
                                    _scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeOut,
                                  );
                                });
                              },
                              child: BlocBuilder<GetHelpBloc, GetHelpState>(
                                builder: (context, state) {
                                  if (state.isLoading &&
                                      state.messages.isEmpty) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return Column(
                                    children: [
                                      GetHelpProgressSection(
                                        // currentStep: state.currentQuestionIndex + 1,
                                        currentStep: state.answers.length,
                                        totalSteps: state.questions.length,
                                        isFinding:
                                            state.isLoadingRecommendations,
                                        // isEmpty:
                                        //     state.hasRequestedRecommendations &&
                                        //     !state.isLoadingRecommendations &&
                                        //     state.recommendations.isEmpty,
                                        isEmpty: state.messages.any(
                                          (m) => m.isEmpty,
                                        ),
                                      ),

                                      SizedBox(height: AppSpacing.s18.h),

                                      /// 🔹 Chat List
                                      Expanded(
                                        child: ListView(
                                          controller: _scrollController,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: AppSpacing.s16.w,
                                            vertical: AppSpacing.s12.h,
                                          ),
                                          children: [
                                            ...List.generate(
                                              state.messages.length,
                                              (index) {
                                                final message =
                                                    state.messages[index];

                                                final isAnswered = state.answers
                                                    .containsKey(message.id);

                                                return GetHelpChatMessageTile(
                                                  message: message,
                                                  isAnswered: isAnswered,
                                                  onOptionSelected:
                                                      message.options == null
                                                      ? null
                                                      : (option) {
                                                          // final question =
                                                          //     state.questions[state
                                                          //         .currentQuestionIndex];

                                                          final question = state
                                                              .questions
                                                              .firstWhere(
                                                                (q) =>
                                                                    q.id ==
                                                                    message.id,
                                                              );

                                                          context
                                                              .read<
                                                                GetHelpBloc
                                                              >()
                                                              .add(
                                                                SelectOption(
                                                                  question,
                                                                  option,
                                                                ),
                                                              );

                                                          _scrollToBottom();
                                                        },
                                                );
                                              },
                                            ),

                                            /// 🔥 LOADING SHIMMER
                                            if (state
                                                .isLoadingRecommendations) ...[
                                              SizedBox(
                                                height: AppSpacing.s16.h,
                                              ),
                                              GridView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      mainAxisSpacing: 14,
                                                      crossAxisSpacing: 14,
                                                      childAspectRatio: 0.58,
                                                    ),
                                                itemCount:
                                                    6, // Number of shimmer items
                                                itemBuilder: (context, _) =>
                                                    const ProductGridItemCardShimmer(),
                                              ),
                                            ] else if (state
                                                    .recommendations
                                                    .isNotEmpty &&
                                                state
                                                    .hasOpenedRecommendations) ...[
                                              SizedBox(
                                                height: AppSpacing.s16.h,
                                              ),
                                              Container(
                                                key: _recommendationKey,
                                                child:
                                                    _buildRecommendationsGrid(
                                                      state,
                                                    ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -AppSize.cs1.csh,
                        right: AppSize.cs10.csh,
                        child: SizedBox(
                          height: 90,
                          width: 90,
                          child: Lottie.asset(
                            AppIcons.lottie.poochPetDog,
                            repeat: true,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendationsGrid(GetHelpState state) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.58,
      ),
      itemCount: state.recommendations.length,
      itemBuilder: (context, index) {
        final product = state.recommendations[index];

        final pet = ProductItem(
          id: product.id,
          name: (product.petDetails?.breedName ?? '').trim().isEmpty
              ? product.name
              : (product.petDetails?.breedName ?? ''),
          age: product.petDetails?.age ?? '',
          price: product.price.round(),
          originalPrice: product.finalDiscountedPrice?.round(),
          isVaccinated: product.petDetails?.isVaccinated ?? false,
          isWishlisted: product.inWishlist,
          image: product.tileImage.isNotEmpty ? product.tileImage.first : '',
        );

        return ProductGridCard(
          product: pet,
          onTap: () async {
            await context.router.push(
              BuyPetDetailRoute(productId: product.id, isFromGetHelp: true),
            );
          },
          onWishlistTap: () {
            context.read<WishlistBloc>().add(ToggleWishlistEvent(product.id));
          },
        );
      },
    );
  }
}
