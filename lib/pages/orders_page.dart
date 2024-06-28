import 'package:finalproject/components/order_card.dart';
import 'package:finalproject/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/view_models/orders_cubit/orders_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return BlocProvider(
      create: (context) {
        final cubit = OrdersCubit();
        cubit.getOrders(user!.uid);
        return cubit;
      },
      child: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state is OrdersInitial || state is OrdersLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is OrdersError) {
            return Scaffold(
              appBar: AppBar(
                title: const Row(
                  children: [
                    Icon(
                      Icons.error,
                    ),
                    SizedBox(width: 8),
                    Text('My Orders'),
                  ],
                ),
              ),
              body: const Center(
                child: Text('Error loading orders'),
              ),
            );
          }
          if (state is OrdersLoaded) {
            if (state.orders.isEmpty) {
              // Displaying message when there are no orders
              return Scaffold(
                appBar: AppBar(
                  title: Row(
                    children: [
                      Icon(Icons.shopping_cart_outlined,
                          color: Theme.of(context).colorScheme.secondary),
                      const SizedBox(width: 8),
                      const Text('My Orders'),
                    ],
                  ),
                ),
                body: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox, size: 50, color: Colors.grey),
                      SizedBox(height: 10),
                      Text('You have no orders'),
                    ],
                  ),
                ),
              );
            }
            // Displaying orders if they exist
            return Scaffold(
              appBar: AppBar(
                title: const Row(
                  children: [
                    Icon(Icons.shopping_cart, color: Colors.white),
                    SizedBox(width: 8),
                    Text('My Orders'),
                  ],
                ),
              ),
              body: ListView.builder(
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  final order = state.orders[index];
                  return OrderCard(
                    order: order,
                    onTap: order.status == 'Completed'
                        ? null
                        : () async {
                            Navigator.of(context).pushNamed(
                              AppRoutes.orderDetails,
                              arguments: order,
                            );
                          },
                  );
                },
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
