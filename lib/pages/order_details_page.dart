import 'package:finalproject/models/order_model.dart';
import 'package:finalproject/models/review_model.dart';
import 'package:finalproject/services/order_services.dart';
import 'package:finalproject/view_models/reviews_cubit/reviews_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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

  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context)!.settings.arguments as OrderModel;
    final theme = Theme.of(context);
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Job: ${order.job}',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 20),
            _buildDropdownButton(theme),
            const SizedBox(height: 20),
            TextField(
              controller: reviewController,
              decoration: const InputDecoration(
                labelText: 'Write a review',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            Text(
              'Rate the job:',
              style: theme.textTheme.titleMedium,
            ),
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
                });
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: isDropdownChanged
                    ? () {
                        // Handle the save operation with new status, review, and rating
                        saveOrderDetails();
                        Navigator.pop(
                            context, 'updated'); // Return result when popping
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
            ),
          ],
        ),
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

  void saveOrderDetails() {
    // Save the order details
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
