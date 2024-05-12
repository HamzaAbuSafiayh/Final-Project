import 'package:finalproject/models/user_model.dart';
import 'package:finalproject/routes/api_paths.dart';
import 'package:finalproject/services/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ProfileServices {
  Future<UserModel> getProfile();

  final user = FirebaseAuth.instance.currentUser;
}

class ProfileServicesImpl extends ProfileServices {
  @override
  Future<UserModel> getProfile() async =>
      await FirestoreService.instance.getDocument<UserModel>(
        path: ApiPaths.user(user!.uid),
        builder: (data, documentID) => UserModel.fromMap(data),
      );


}
