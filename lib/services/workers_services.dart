import 'package:finalproject/models/worker_model.dart';
import 'package:finalproject/routes/api_paths.dart';
import 'package:finalproject/services/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class WorkersServices {
  Future<List<WorkerModel>> getWorkers();
  final user = FirebaseAuth.instance.currentUser;
}

class WorkersServicesImpl extends WorkersServices {
  @override
  Future<List<WorkerModel>> getWorkers() async =>
      await FirestoreService.instance.getCollection(
        path: ApiPaths.workers(),
        builder: (data, documentId) => WorkerModel.fromMap(data),
      );
}
