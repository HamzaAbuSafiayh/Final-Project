import 'package:finalproject/models/user_model.dart';
import 'package:finalproject/models/worker_model.dart';
import 'package:flutter/material.dart';

class WorkerProfile extends StatelessWidget {
  const WorkerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final profile = arguments['profile'] as UserModel;
    final worker = arguments['worker'] as WorkerModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasker Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                      profile.imageUrl), // Replace with your image asset
                ),
                const SizedBox(width: 16),
                Text(
                  profile.username,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 4),
                Text('${worker.sumofratings} (${worker.reviews} ratings)'),
              ],
            ),
            const SizedBox(height: 4),
            const Row(
              children: [
                Icon(Icons.check_circle_outline),
                SizedBox(width: 4),
                Text('117 Furniture Assembly tasks'),
              ],
            ),
            const SizedBox(height: 4),
            const Row(
              children: [
                Icon(Icons.directions_car),
                SizedBox(width: 4),
                Text('Vehicles: Car, Minivan/SUV'),
              ],
            ),
            const SizedBox(height: 4),
            const Row(
              children: [
                Icon(Icons.build),
                SizedBox(width: 4),
                Text('Tools: Dolly, Ladder, Power drill, Power washer'),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'Skills & experience',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'I have 5 years of furniture assembly. I have my own tools and am willing and able to help you.',
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'Photos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Image.network(
                      'https://canvaspiece.com/cdn/shop/products/L_1_52362845_xxl_5000x.jpg'),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Image.network(
                      'https://m.media-amazon.com/images/I/81LIuMNM08L.jpg'),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Image.network(
                      'https://randomstudio.in/wp-content/uploads/2023/10/RAC-1449-1-300x300.jpg'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'Ratings & reviews',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        '${worker.sumofratings} (${worker.reviews} ratings)',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildRatingBar('5 star', 99),
            _buildRatingBar('4 star', 0),
            _buildRatingBar('3 star', 1),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text('Select'),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                '\$41.29/hr',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingBar(String label, int percentage) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(label),
        ),
        Expanded(
          flex: 5,
          child: LinearProgressIndicator(
            value: percentage / 100.0,
            backgroundColor: Colors.grey[300],
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 8),
        Text('$percentage%'),
      ],
    );
  }
}
