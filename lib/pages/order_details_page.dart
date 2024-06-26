import 'package:finalproject/components/details_field.dart';
import 'package:finalproject/models/order_model.dart';
import 'package:finalproject/models/review_model.dart';
import 'package:finalproject/services/order_services.dart';
import 'package:finalproject/view_models/profile_cubit/profile_cubit.dart';
import 'package:finalproject/view_models/reviews_cubit/reviews_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  late ReviewModel review;
  String dropdownValue = 'Pending';
  final TextEditingController reviewController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  late String workerID;
  late String orderID;
  final orderServices = OrderServiceImpl();
  double rating = 0.0;
  bool isDropdownChanged = false;
  bool isReviewProvided = false;
  bool isRatingProvided = false;
  final dateFormat = DateFormat('yyyy-MM-dd'); // Format for date

  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context)!.settings.arguments as OrderModel;
    final theme = Theme.of(context);
    final user = FirebaseAuth.instance.currentUser;

    workerID = order.workerId;
    orderID = order.orderId;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, 'updated');
          },
        ),
        title: Text(order.job),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: user!.uid == order.workerId
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOrderDetailsCard(order),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOrderDetailsCard(order),
                    const SizedBox(height: 16),
                    _buildDropdownButton(theme),
                    const SizedBox(height: 16),
                    _buildReviewSection(),
                    const SizedBox(height: 16),
                    _buildRatingSection(theme),
                    const SizedBox(height: 16),
                    _buildSaveButton(context),
                  ],
                )),
    );
  }

  Widget _buildOrderDetailsCard(OrderModel order) {
    return BlocProvider(
      create: (context) {
        final cubit = ProfileCubit();
        cubit.getProfileWorker(order.workerId);
        return cubit;
      },
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileInitial || state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is ProfileLoaded) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailsField(
                        label: 'Order ID:',
                        value: '#${order.orderId.split('-').first}'),
                    BlocProvider(
                      create: (context) {
                        final cubit = ProfileCubit();
                        cubit.getProfileWorker(order.userId);
                        return cubit;
                      },
                      child: BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (context, state1) {
                        if (state1 is ProfileInitial ||
                            state is ProfileLoading) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }
                        if (state1 is ProfileLoaded) {
                          return DetailsField(
                              label: user!.uid == order.workerId
                                  ? 'Client:'
                                  : 'Worker:',
                              value: user!.uid == order.workerId
                                  ? state1.profile.username
                                  : state.profile.username);
                        }
                        return const Center(
                          child: Text('Error loading profile'),
                        );
                      }),
                    ),
                    DetailsField(label: 'Job:', value: order.job),
                    DetailsField(label: 'Location:', value: order.location),
                    DetailsField(
                        label: 'Cost:',
                        value: '\$${order.cost.toStringAsFixed(2)}'),
                    DetailsField(
                        label: 'Date:',
                        value: dateFormat.format(DateTime.parse(order.date))),
                    DetailsField(label: 'Time:', value: order.time),
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: Text('Error loading profile'),
          );
        },
      ),
    );
  }

  Widget _buildDropdownButton(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.onSurface),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: Icon(Icons.arrow_downward, color: theme.colorScheme.secondary),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: theme.colorScheme.onSurface),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
              isDropdownChanged = dropdownValue == 'Completed';
            });
          },
          items: const [
            DropdownMenuItem(value: 'Pending', child: Text('Pending')),
            DropdownMenuItem(value: 'Completed', child: Text('Completed')),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewSection() {
    return TextField(
      controller: reviewController,
      decoration: const InputDecoration(
        labelText: 'Write a review',
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
      onChanged: (text) {
        setState(() {
          isReviewProvided = text.isNotEmpty;
        });
      },
    );
  }

  Widget _buildRatingSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rate the job:',
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        RatingBar.builder(
          initialRating: rating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (newRating) {
            setState(() {
              rating = newRating;
              isRatingProvided = rating > 0;
            });
          },
        ),
      ],
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    bool isSaveEnabled =
        isDropdownChanged && isReviewProvided && isRatingProvided;

    return Center(
      child: ElevatedButton(
        onPressed: isSaveEnabled
            ? () {
                saveOrderDetails();
                Navigator.pop(context);
              }
            : null,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.grey; // Disabled color
              }
              return Theme.of(context).primaryColor; // Enabled color
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.white; // Text color when disabled
              }
              return Colors.white; // Text color when enabled
            },
          ),
        ),
        child: Text(
          'Save Changes',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }

  void saveOrderDetails() {
    review = ReviewModel(
      timestamp: DateTime.now().toIso8601String(),
      userID: user!.uid,
      review: reviewController.text,
      rating: rating,
    );
    BlocProvider.of<ReviewsCubit>(context).addReview(workerID, review);
    orderServices.updateOrderStatus(orderID, dropdownValue);
  }

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }
}
