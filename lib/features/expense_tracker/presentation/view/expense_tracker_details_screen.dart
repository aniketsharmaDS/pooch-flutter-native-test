import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/features/expense_tracker/presentation/bloc/expense_tracker_bloc.dart';
import 'package:poochcare/features/expense_tracker/presentation/bloc/expense_tracker_event.dart';
import 'package:poochcare/features/expense_tracker/presentation/bloc/expense_tracker_state.dart';
import 'package:poochcare/features/expense_tracker/presentation/widgets/expense_tracker_list_item_card.dart';
import 'package:poochcare/features/expense_tracker/presentation/widgets/shimmers/expense_tracker_list_item_card_shimmer.dart';

@RoutePage()
class ExpenseTrackerDetailsScreen extends StatefulWidget {
  const ExpenseTrackerDetailsScreen({
    super.key,
    this.month,
    required this.year,
    required this.type,
    this.petId,
  });

  final int? month;

  final int year;

  final String type;

  final String? petId;

  @override
  State<ExpenseTrackerDetailsScreen> createState() =>
      _ExpenseTrackerDetailsScreenState();
}

class _ExpenseTrackerDetailsScreenState
    extends State<ExpenseTrackerDetailsScreen> {
  late final ScrollController _scrollController;
  late final ExpenseTrackerBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = getIt<ExpenseTrackerBloc>();

    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    if (widget.type != 'yearly') return;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _bloc.add(LoadYearlyTransactions(year: widget.year, loadMore: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc
        ..add(
          widget.type == 'monthly'
              ? LoadMonthlyTransactions(
                  month: widget.month!,
                  year: widget.year,
                  petId: widget.petId,
                )
              : LoadYearlyTransactions(year: widget.year, petId: widget.petId),
        ),
      child: BlocBuilder<ExpenseTrackerBloc, ExpenseTrackerState>(
        builder: (context, state) {
          final monthlyDetails = state.monthlyTransactions;

          final yearlyDetails = state.yearlyTransactions;
          return Scaffold(
            body: AppPrimaryBgContainer(
              child: SafeArea(
                child: Column(
                  children: [
                    PoochScreenAppBar(
                      title: widget.type == 'monthly'
                          ? monthlyDetails == null
                                ? 'Expense Breakdown'
                                : 'Expense Breakdown for '
                                      '${monthlyDetails.month} '
                                      '${monthlyDetails.year}'
                          : yearlyDetails == null
                          ? 'Expense Breakdown'
                          : 'Expense Breakdown for '
                                '${yearlyDetails.year}',
                    ),
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          final transactions = widget.type == 'monthly'
                              ? (monthlyDetails?.transactions ?? [])
                              : (yearlyDetails?.transactions ?? []);
                          if (state.isLoading) {
                            return ListView.separated(
                              padding: EdgeInsets.all(AppSpacing.s16.w),
                              itemCount: 10,
                              separatorBuilder: (_, _) =>
                                  SizedBox(height: 12.h),
                              itemBuilder: (context, index) =>
                                  const ExpenseTrackerListItemCardShimmer(),
                            );
                          }

                          if (transactions.isEmpty) {
                            return const Center(
                              child: Text('No transactions found'),
                            );
                          }
                          return ListView.separated(
                            padding: EdgeInsets.all(AppSpacing.s16.w),
                            itemCount:
                                transactions.length +
                                (state.isLoadingMoreYearlyTransactions ? 1 : 0),
                            controller: _scrollController,
                            separatorBuilder: (_, _) => SizedBox(height: 12.h),
                            itemBuilder: (context, index) {
                              // final item = expenses[index];

                              if (index >= transactions.length) {
                                return const ExpenseTrackerListItemCardShimmer();
                              }

                              final item = transactions[index];

                              return ExpenseTrackerListItemCard(
                                title: item.name,

                                dateTimeText: item.formattedDateTime,

                                amount: item.formattedAmount,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
