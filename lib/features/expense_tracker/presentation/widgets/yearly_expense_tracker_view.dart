import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/forms/medical_form/pet_selection_form_field.dart';
import 'package:poochcare/core/widgets/selectors/app_date_selector.dart';
import 'package:poochcare/core/widgets/selectors/app_year_picker_sheet.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/expense_tracker/presentation/bloc/expense_tracker_bloc.dart';
import 'package:poochcare/features/expense_tracker/presentation/bloc/expense_tracker_event.dart';
import 'package:poochcare/features/expense_tracker/presentation/bloc/expense_tracker_state.dart';
import 'package:poochcare/features/expense_tracker/presentation/widgets/expense_breakdown_section.dart';
import 'package:poochcare/features/expense_tracker/presentation/widgets/expense_donut_chart.dart';
import 'package:poochcare/features/expense_tracker/presentation/widgets/expense_yearly_chart.dart';
import 'package:poochcare/features/expense_tracker/presentation/widgets/shimmers/expense_tracker_view_shimmer.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:poochcare/router/app_router.dart';

class YearlyExpenseTrackerView extends StatefulWidget {
  const YearlyExpenseTrackerView({super.key});

  @override
  State<YearlyExpenseTrackerView> createState() =>
      _YearlyExpenseTrackerViewState();
}

class _YearlyExpenseTrackerViewState extends State<YearlyExpenseTrackerView> {
  final ValueNotifier<String?> selectedPetNotifier = ValueNotifier(null);

  late final DateTime profileCreatedAt;

  @override
  void initState() {
    super.initState();

    final createdAt = context.read<UserProfileBloc>().state.profile!.createdAt;

    profileCreatedAt = DateTime.parse(createdAt);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseTrackerBloc, ExpenseTrackerState>(
      builder: (context, state) {
        if (state.isLoading) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight, // fill parent height
                  ),
                  child: const IntrinsicHeight(
                    child: ExpenseTrackerShimmer(isMonthly: true),
                  ),
                ),
              );
            },
          );
        }

        final expenseTracker = state.expenseTracker;

        final isEmpty =
            expenseTracker == null ||
            expenseTracker.monthlyExpenses.every((e) => e.amount == 0);

        if (expenseTracker == null) {
          return Center(
            child: AppText.bodyM('No data available for the selected year.'),
          );
        }
        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight, // fill the tab's height
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.s100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        /// HEADER ROW (Year + Pet)
                        Container(
                          // color: const Color(0xFFF2EDDD),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(AppRadiusSize.r16),
                              bottomRight: Radius.circular(AppRadiusSize.r16),
                            ),
                            color: Color(0xFFF2EDDD),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: AppSpacing.s8,
                                  right: AppSpacing.s12,
                                  top: AppSpacing.s16,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: AppDateSelector(
                                        label: state.selectedYear.toString(),

                                        onTap: () async {
                                          final selectedYear =
                                              await AppYearPickerSheet.show(
                                                context: context,

                                                initialYear: state.selectedYear,

                                                accountCreatedAt:
                                                    profileCreatedAt,
                                              );

                                          if (selectedYear == null ||
                                              !context.mounted) {
                                            return;
                                          }

                                          final bloc = context
                                              .read<ExpenseTrackerBloc>();

                                          // Only dispatch if the year changed
                                          if (selectedYear !=
                                              bloc.state.selectedYear) {
                                            bloc.add(
                                              ChangeExpenseTrackerYear(
                                                selectedYear,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),

                                    /// Pet Selector
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: PetSelectionFormField(
                                        selectedPetNotifier:
                                            selectedPetNotifier,
                                        variant: PetSelectionVariant.popup,
                                        onPetChanged: (petId) {
                                          context
                                              .read<ExpenseTrackerBloc>()
                                              .add(
                                                ChangeExpenseTrackerPet(petId),
                                              );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              /// DONUT CHART
                              if (isEmpty)
                                SizedBox(
                                  height: 320,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: AppSpacing.s32,
                                    ),
                                    child: Center(
                                      child: AppText.bodyM(
                                        'No expenses found for this year.',
                                      ),
                                    ),
                                  ),
                                )
                              else ...[
                                ExpenseDonutChart(
                                  totalAmount: expenseTracker.breakdown.total,
                                  sections: expenseTracker.breakdown.categories
                                      .map((e) {
                                        final colors = [
                                          const Color(0xFFFBC62B),
                                          const Color(0xFFF5D87A),
                                          const Color(0xFFD2A21A),
                                          const Color(0xFF8D6800),
                                        ];

                                        final index = expenseTracker
                                            .breakdown
                                            .categories
                                            .indexOf(e);

                                        return ExpenseChartSection(
                                          title: e.category,
                                          amount: e.amount,
                                          color: colors[index % colors.length],
                                        );
                                      })
                                      .toList(),
                                ),

                                /// BREAKDOWN
                                ExpenseBreakdownSection(
                                  items: expenseTracker.breakdown.categories
                                      .map((e) {
                                        final colors = [
                                          const Color(0xFFFBC62B),
                                          const Color(0xFFF5D87A),
                                          const Color(0xFFD2A21A),
                                          const Color(0xFF8D6800),
                                        ];

                                        final index = expenseTracker
                                            .breakdown
                                            .categories
                                            .indexOf(e);

                                        return ExpenseBreakdownItemData(
                                          title: e.category,
                                          amount: e.formattedAmount,
                                          color: colors[index % colors.length],
                                        );
                                      })
                                      .toList(),
                                ),

                                AppSpacing.s15.hBox,

                                /// VIEW REPORT BUTTON
                                AppButton(
                                  label: 'View Details',
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.s16,
                                  ),
                                  customTextStyle: TextStyle(
                                    fontSize: AppFontSize.fs12,
                                  ),
                                  width: AppSize.cs110,
                                  height: AppSize.cs32,
                                  onPressed: () {
                                    context.pushRoute(
                                      ExpenseTrackerDetailsRoute(
                                        year: state.selectedYear,
                                        petId: state.selectedPetId,
                                        type: 'yearly',
                                      ),
                                    );
                                  },
                                ),

                                AppSpacing.s13.hBox,
                              ],
                            ],
                          ),
                        ),

                        if (!isEmpty) ...[
                          AppSpacing.s30.hBox,
                          ExpenseYearlyChart(
                            year: state.selectedYear,
                            data: expenseTracker.monthlyExpenses.map((e) {
                              return ExpenseBarData(
                                month: e.shortMonthName,
                                amount: e.amount,
                                color: e.amount > 0
                                    ? const Color(0xFF3B0A00)
                                    : const Color(0xFFD7D3CB),
                              );
                            }).toList(),
                          ),
                          AppSpacing.s13.hBox,
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
