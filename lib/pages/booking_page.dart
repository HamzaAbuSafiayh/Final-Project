import 'package:flutter/material.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Page'),
      ),
      body: const Column(
        children: [
          Text('Booking Page'),
        ],
      ),
    );  
  }
}
