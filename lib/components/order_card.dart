import 'package:finalproject/models/order_model.dart';
import 'package:finalproject/view_models/categories_cubit/categories_cubit.dart';
import 'package:finalproject/view_models/profile_cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // Import intl package

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback? onTap;
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
        builder: (context, state1) {
          if (state1 is ProfileInitial) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state1 is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state1 is ProfileLoaded) {
            return BlocProvider(
              create: (context) {
                final cubit = CategoriesCubit();
                cubit.getCategory(order.job);
                return cubit;
              },
              child: BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesInitial ||
                      state is CategoriesLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  if (state is CategoriesError) {
                    return const Center(
                      child: Text('Error loading categories'),
                    );
                  }
                  if (state is CategoryLoaded) {
                    return Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: colorScheme.shadow,
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: onTap,
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 330,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(10)),
                                    child: Image.network(
                                      state.category
                                          .imageUrl, // Replace with your image URL
                                      height: 200,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 30),
                                        Text(
                                          state.category.name,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          '${dateFormat.format(DateTime.parse(order.date))} at ${order.time}',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 10,
                              left: 10,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: order.status == 'Completed'
                                      ? Colors.green
                                      : Colors.red.shade500,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  order.status,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(state1.profile.imageUrl),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            );
            // return Card(
            //   elevation: 4,
            //   margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            //   color: colorScheme.surface,
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: colorScheme.surface,
            //       borderRadius: BorderRadius.circular(5),
            //     ),
            //     child: ListTile(
            //       contentPadding:
            //           const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //       leading: CircleAvatar(
            //         backgroundImage: NetworkImage(state.profile.imageUrl),
            //         backgroundColor: colorScheme.secondary,
            //       ),
            //       title: Text(
            //         order.job,
            //         style: TextStyle(
            //           color: colorScheme.onSurface,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       subtitle: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: <Widget>[
            //           Text('Location: ${order.location}',
            //               style: TextStyle(color: colorScheme.onBackground)),
            //           Text(
            //               'Date: ${dateFormat.format(DateTime.parse(order.date))} at ${order.time}',
            //               style: TextStyle(color: colorScheme.onBackground)),
            //           Text('Cost: \$${order.cost.toStringAsFixed(2)}',
            //               style: TextStyle(color: colorScheme.onBackground)),
            //         ],
            //       ),
            //       trailing: Container(
            //         padding: const EdgeInsets.all(8),
            //         decoration: BoxDecoration(
            //           color: order.status == 'Completed'
            //               ? Colors.green
            //               : Colors.red,
            //           borderRadius: BorderRadius.circular(5),
            //         ),
            //         child: Text(
            //           order.status,
            //           style: const TextStyle(color: Colors.white),
            //         ),
            //       ),
            //       onTap: onTap,
            //     ),
            //   ),
            // );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
