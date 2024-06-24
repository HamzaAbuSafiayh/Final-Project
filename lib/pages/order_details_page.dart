import 'package:finalproject/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  late OrderModel order; // The order model
  late String currentStatus; // Ensure it's initialized properly
  final TextEditingController reviewController = TextEditingController();
  double rating = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    order = ModalRoute.of(context)!.settings.arguments as OrderModel;
    currentStatus = (order.status == 'Pending' || order.status == 'Completed')
        ? order.status
        : 'Pending'; // Initialize with the current status or default to 'Pending'
  }

  @override
  Widget build(BuildContext context) {
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
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'Worker ID: ${order.workerId}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: currentStatus,
              items: <String>['Pending', 'Completed']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  currentStatus = newValue!;
                });
              },
            ),
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
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Slider(
              min: 0.0,
              max: 5.0,
              divisions: 10,
              label: '${rating.toStringAsFixed(1)} Stars',
              value: rating,
              onChanged: (newRating) {
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
                  // For example, you might update the order in a database
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

  void saveOrderDetails() {}

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }
}
