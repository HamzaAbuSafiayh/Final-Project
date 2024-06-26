import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/models/order_model.dart';
import 'package:finalproject/models/worker_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

abstract class OrderService {
  Future<void> createOrder(WorkerModel worker, String date, String time);
  Stream<List<OrderModel>> getOrders(String userID);
  Stream<List<OrderModel>> getWorkerOrders(String workerID);
  Future<void> updateOrderStatus(String orderID, String status);
  final user = FirebaseAuth.instance.currentUser;
}

class OrderServiceImpl extends OrderService {
  @override
  Future<String> createOrder(
      WorkerModel worker, String date, String time) async {
    String orderId = const Uuid().v4();

    await FirebaseFirestore.instance.collection('orders').doc(orderId).set({
      'orderId': orderId,
      'userId': user!.uid,
      'status': 'Pending',
      'workerId': worker.uid,
      'job': worker.job,
      'location': worker.location,
      'cost': worker.cost + 10,
      'date': date,
      'time': time,
    });

    await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
      'orders': FieldValue.arrayUnion([orderId]),
    }, SetOptions(merge: true));
    await FirebaseFirestore.instance.collection('workers').doc(worker.uid).set({
      'orders': FieldValue.arrayUnion([orderId]),
    }, SetOptions(merge: true));
    return orderId;
  }

  @override
  Stream<List<OrderModel>> getOrders(String userID) {
    return FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: userID)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => OrderModel.fromMap(doc.data()))
          .toList();
    });
  }

  @override
  Stream<List<OrderModel>> getWorkerOrders(String workerID) {
    return FirebaseFirestore.instance
        .collection('orders')
        .where('workerId', isEqualTo: workerID)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => OrderModel.fromMap(doc.data()))
          .toList();
    });
  }

  @override
  Future<void> updateOrderStatus(String orderID, String status) async {
    await FirebaseFirestore.instance.collection('orders').doc(orderID).update({
      'status': status,
    });
  }
}
