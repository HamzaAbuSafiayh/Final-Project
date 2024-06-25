import 'package:finalproject/models/order_model.dart';
import 'package:finalproject/view_models/profile_cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // Import intl package

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onTap;
  const OrderCard({super.key, required this.order, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    // Create a DateFormat to format the date strings
    final dateFormat = DateFormat('yyyy-MM-dd'); // Format for date

    return BlocProvider(
      create: (context) {
        final cubit = ProfileCubit();
        cubit.getProfileWorker(order.workerId);
        return cubit;
      },
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileInitial) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is ProfileLoaded) {
            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              color: colorScheme.surface,
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(state.profile.imageUrl),
                    backgroundColor: colorScheme.secondary,
                  ),
                  title: Text(
                    order.job,
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Location: ${order.location}',
                          style: TextStyle(color: colorScheme.onBackground)),
                      Text(
                          'Date: ${dateFormat.format(DateTime.parse(order.date))} at ${order.time}',
                          style: TextStyle(color: colorScheme.onBackground)),
                      Text('Cost: \$${order.cost.toStringAsFixed(2)}',
                          style: TextStyle(color: colorScheme.onBackground)),
                    ],
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: order.status == 'Completed'
                          ? Colors.green
                          : Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      order.status,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  onTap: onTap,
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
