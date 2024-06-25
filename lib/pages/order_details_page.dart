import 'package:finalproject/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  String dropdownValue = 'Pending';
  final TextEditingController reviewController = TextEditingController();
  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    final order = ModalRoute.of(context)!.settings.arguments as OrderModel;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
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
            Text(
              'Worker ID: ${order.workerId}',
              style: theme.textTheme.titleMedium,
            ),
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
                onPressed: () {
                  // Handle the save operation with new status, review, and rating
                  saveOrderDetails();
                },
                child: const Text('Save Changes'),
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
    // Implement your save logic here, e.g., updating the order in the database
  }

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }
}
