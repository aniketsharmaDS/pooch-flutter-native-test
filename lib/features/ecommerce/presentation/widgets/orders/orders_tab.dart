import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/orders/order_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/orders/order_event.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/orders/order_state.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/orders/order_card_factory.dart';

class OrdersTab extends StatefulWidget {
  final String? status;
  const OrdersTab({super.key, this.status});

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      final bloc = context.read<OrderBloc>();

      if (_controller.position.pixels >=
              _controller.position.maxScrollExtent - 200 &&
          !bloc.state.isLoadingMore &&
          !bloc.state.hasReachedMax) {
        bloc.add(LoadMoreOrders());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state.isLoading && state.orders.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.error != null && state.orders.isEmpty) {
          return Center(child: AppText.h3(state.error!));
        }

        if (state.orders.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<OrderBloc>().add(
                LoadOrders(status: widget.status, isRefresh: true),
              );
            },
            child: ListView.separated(
              controller: _controller,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: state.orders.length + (state.isLoadingMore ? 1 : 0),
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                if (index >= state.orders.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final item = state.orders[index];
                return OrderCardFactory(item: item);
              },
            ),
          );
        }

        return Center(child: AppText.h3('No Orders'));
      },
    );
  }
}
