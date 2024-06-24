import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/models/worker_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class OrderService {
  Future<void> createOrder(WorkerModel worker, String date, String time);
  final user = FirebaseAuth.instance.currentUser;
}

class OrderServiceImpl extends OrderService {
  @override
  Future<void> createOrder(WorkerModel worker, String date, String time) async {
    String orderId = DateTime.now().toIso8601String();
    await FirebaseFirestore.instance.collection('orders').doc(orderId).set({
      'userId': user!.uid,
      'status': 'pending',
      'workerId': worker.uid,
      'job': worker.job,
      'location': worker.location,
      'cost': worker.cost,
      'date': date,
      'time': time,
    });

    await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
      'orders': FieldValue.arrayUnion([orderId]),
    }, SetOptions(merge: true));
    await FirebaseFirestore.instance.collection('workers').doc(worker.uid).set({
      'orders': FieldValue.arrayUnion([orderId]),
    }, SetOptions(merge: true));
  }
}
