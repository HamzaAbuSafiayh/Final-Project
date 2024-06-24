import 'package:finalproject/components/order_card.dart';
import 'package:finalproject/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/view_models/orders_cubit/orders_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return BlocProvider(
      create: (context) {
        final cubit = OrdersCubit();
        cubit.getOrdersworker(user!.uid);
        return cubit;
      },
      child: BlocBuilder<OrdersCubit, OrdersState>(builder: (context, state) {
        if (state is OrdersInitial || state is OrdersLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (state is OrdersError) {
          return const Center(
            child: Text('Error loading orders'),
          );
        }
        if (state is OrdersLoaded) {
          if (state.orders.isEmpty) {
            // Displaying message when there are no orders
            return Scaffold(
              appBar: AppBar(
                title: const Text('Tasks'),
              ),
              body: const Center(
                child: Text('You have no orders'),
              ),
            );
          }
          // Displaying orders if they exist
          return Scaffold(
            appBar: AppBar(
              title: const Text('Tasks'),
            ),
            body: ListView.builder(
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                final order = state.orders[index];
                return OrderCard(order: order,onTap: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.orderDetails,
                    arguments: order,
                  );
                  
                },);
              },
            ),
          );
        }
        return const SizedBox();
      }),
    );
  }
}
