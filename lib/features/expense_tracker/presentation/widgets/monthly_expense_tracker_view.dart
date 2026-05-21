import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/forms/medical_form/pet_selection_form_field.dart';
import 'package:poochcare/core/widgets/selectors/app_date_selector.dart';
import 'package:poochcare/core/widgets/selectors/app_month_year_picker_sheet.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/expense_tracker/presentation/bloc/expense_tracker_bloc.dart';
import 'package:poochcare/features/expense_tracker/presentation/bloc/expense_tracker_event.dart';
import 'package:poochcare/features/expense_tracker/presentation/bloc/expense_tracker_state.dart';
import 'package:poochcare/features/expense_tracker/presentation/widgets/expense_breakdown_section.dart';
import 'package:poochcare/features/expense_tracker/presentation/widgets/expense_calendar_section.dart';
import 'package:poochcare/features/expense_tracker/presentation/widgets/expense_donut_chart.dart';
import 'package:poochcare/features/expense_tracker/presentation/widgets/shimmers/expense_tracker_view_shimmer.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:poochcare/router/app_router.dart';

class MonthlyExpenseTrackerView extends StatefulWidget {
  const MonthlyExpenseTrackerView({super.key});

  @override
  State<MonthlyExpenseTrackerView> createState() =>
      _MonthlyExpenseTrackerViewState();
}

class _MonthlyExpenseTrackerViewState extends State<MonthlyExpenseTrackerView> {
  final ValueNotifier<String?> selectedPetNotifier = ValueNotifier(null);

  late final DateTime profileCreatedAt;

  String _formatMonthLabel(BuildContext context, int year, int month) {
    final localeName = context.locale.toString();

    return DateFormat.MMM(localeName).format(DateTime(year, month));
  }

  @override
  void initState() {
    super.initState();
    selectedPetNotifier.value = context
        .read<ExpenseTrackerBloc>()
        .state
        .selectedPetId;

    profileCreatedAt = DateTime.parse(
      context.read<UserProfileBloc>().state.profile!.createdAt,
    );
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
            expenseTracker?.breakdown.total == 0 &&
            expenseTracker?.breakdown.categories.isEmpty == true &&
            expenseTracker?.dailyExpenses.isEmpty == true;

        if (expenseTracker == null) {
          return Center(
            child: AppText.bodyM('expense.noDataForSelectedMonth'.tr()),
          );
        }
        final monthLabel = _formatMonthLabel(
          context,
          state.selectedYear,
          state.selectedMonth,
        );

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.s100),
            child: Column(
              children: [
                /// HEADER ROW (Month + Pet)
                Container(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: AppDateSelector(
                                label: '$monthLabel ${state.selectedYear}',

                                onTap: () async {
                                  final result =
                                      await AppMonthYearPickerSheet.show(
                                        context: context,

                                        initialMonth: state.selectedMonth,

                                        initialYear: state.selectedYear,

                                        accountCreatedAt: profileCreatedAt,
                                      );

                                  if (result == null || !context.mounted) {
                                    return;
                                  }

                                  final bloc = context
                                      .read<ExpenseTrackerBloc>();

                                  // Only dispatch month/year changes if they are actually different
                                  final monthChanged =
                                      result.month != bloc.state.selectedMonth;
                                  final yearChanged =
                                      result.year != bloc.state.selectedYear;

                                  // If nothing changed, do nothing
                                  if (!monthChanged && !yearChanged) return;

                                  // Dispatch changes
                                  if (monthChanged) {
                                    bloc.add(
                                      ChangeExpenseTrackerMonth(result.month),
                                    );
                                  }

                                  if (yearChanged) {
                                    bloc.add(
                                      ChangeExpenseTrackerYear(result.year),
                                    );
                                  }
                                },
                              ),
                            ),

                            /// Pet Selector
                            Align(
                              alignment: Alignment.centerRight,
                              child: PetSelectionFormField(
                                selectedPetNotifier: selectedPetNotifier,
                                variant: PetSelectionVariant.popup,
                                onPetChanged: (petId) {
                                  context.read<ExpenseTrackerBloc>().add(
                                    ChangeExpenseTrackerPet(petId),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// DONUT CHART
                      if (isEmpty) ...[
                        SizedBox(
                          height: 320.h,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.s32,
                            ),
                            child: Center(
                              child: AppText.bodyM(
                                'expense.noExpensesForMonth'.tr(),
                              ),
                            ),
                          ),
                        ),
                      ] else ...[
                        /// DONUT CHART
                        ExpenseDonutChart(
                          totalAmount: expenseTracker.breakdown.total,
                          sections: expenseTracker.breakdown.categories.map((
                            e,
                          ) {
                            final colors = [
                              const Color(0xFFFBC62B),
                              const Color(0xFFF5D87A),
                              const Color(0xFFD2A21A),
                              const Color(0xFF8D6800),
                            ];

                            final index = expenseTracker.breakdown.categories
                                .indexOf(e);

                            return ExpenseChartSection(
                              title: e.category,
                              amount: e.amount,
                              color: colors[index % colors.length],
                            );
                          }).toList(),
                        ),

                        /// BREAKDOWN
                        ExpenseBreakdownSection(
                          items: expenseTracker.breakdown.categories.map((e) {
                            final colors = [
                              const Color(0xFFFBC62B),
                              const Color(0xFFF5D87A),
                              const Color(0xFFD2A21A),
                              const Color(0xFF8D6800),
                            ];

                            final index = expenseTracker.breakdown.categories
                                .indexOf(e);

                            return ExpenseBreakdownItemData(
                              title: e.category,
                              amount: e.formattedAmount,
                              color: colors[index % colors.length],
                            );
                          }).toList(),
                        ),

                        AppSpacing.s15.hBox,

                        /// VIEW DETAILS BUTTON
                        AppButton(
                          label: 'common.viewDetails'.tr(),
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
                                month: state.selectedMonth,
                                year: state.selectedYear,
                                petId: state.selectedPetId,
                                type: 'monthly',
                              ),
                            );
                          },
                        ),
                        AppSpacing.s12.hBox,
                      ],
                    ],
                  ),
                ),

                AppSpacing.s20.hBox,

                ExpenseCalendarSection(
                  monthIndex: state.selectedMonth,
                  year: state.selectedYear,

                  highlightedDates: expenseTracker.dailyExpenses
                      .map((e) => e.day)
                      .toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
