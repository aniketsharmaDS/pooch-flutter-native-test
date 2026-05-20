import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/widgets/Tabs/app_default_tab_bar.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/orders/order_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/orders/order_event.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/orders_tab.dart';

@RoutePage()
class OrdersListingScreen extends StatefulWidget {
  const OrdersListingScreen({super.key});

  @override
  State<OrdersListingScreen> createState() => _OrdersListingScreenState();
}

class _OrdersListingScreenState extends State<OrdersListingScreen> {
  String? _mapTabToStatus(int index) {
    switch (index) {
      case 0:
        return null; // All
      case 1:
        return 'active';
      case 2:
        return 'completed';
      case 3:
        return 'cancelled';
      default:
        return null;
    }
  }

  @override
  void initState() {
    super.initState();

    /// ✅ Called ONLY once
    context.read<OrderBloc>().add(LoadOrders());
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (context.read<OrderBloc>().state.orders.isEmpty) {
    //     context.read<OrderBloc>().add(LoadOrders());
    //   }
    // });
    return Scaffold(
      body: AppPrimaryBgContainer(
        child: SafeArea(
          child: Column(
            children: [
              const PoochScreenAppBar(title: 'My Orders'),
              Expanded(
                child: AppDefaultRouteTabs(
                  tabNames: const ['All', 'Active', 'Completed', 'Cancelled'],
                  // isScrollable: true,
                  onTabChanged: (index) {
                    final status = _mapTabToStatus(index);

                    // context.read<OrderBloc>().add(LoadOrders(status: status));

                    if (context.read<OrderBloc>().state.status != status) {
                      context.read<OrderBloc>().add(LoadOrders(status: status));
                    }
                  },
                  children: const [
                    OrdersTab(),
                    OrdersTab(status: 'active'),
                    OrdersTab(status: 'completed'),
                    OrdersTab(status: 'cancelled'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
