import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/Tabs/app_top_tab_bar.dart';
import 'package:poochcare/features/expense_tracker/presentation/bloc/expense_tracker_bloc.dart';
import 'package:poochcare/features/expense_tracker/presentation/bloc/expense_tracker_event.dart';
import 'package:poochcare/features/expense_tracker/presentation/widgets/monthly_expense_tracker_view.dart';
import 'package:poochcare/features/expense_tracker/presentation/widgets/yearly_expense_tracker_view.dart';

@RoutePage()
class ExpenseTrackerScreen extends StatelessWidget {
  const ExpenseTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final currentMonth = now.month;
    final currentYear = now.year;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppSpacing.s5,
          right: AppSpacing.s7,
        ),
        child: AppTopTabBar(
          leftTitle: 'Monthly',
          rightTitle: 'Yearly',
          leftScreen: BlocProvider(
            create: (_) => getIt<ExpenseTrackerBloc>()
              ..add(
                LoadExpenseTracker(
                  type: 'monthly',
                  month: currentMonth,
                  year: currentYear,
                ),
              ),
            child: const MonthlyExpenseTrackerView(),
          ),
          rightScreen: BlocProvider(
            create: (_) =>
                getIt<ExpenseTrackerBloc>()
                  ..add(LoadExpenseTracker(type: 'yearly', year: currentYear)),
            child: const YearlyExpenseTrackerView(),
          ),
        ),
      ),
    );
  }
}
