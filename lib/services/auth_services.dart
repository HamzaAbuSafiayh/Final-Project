import 'package:finalproject/routes/api_paths.dart';
import 'package:finalproject/services/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthServices {
  Future<bool> signInWithEmailAndPassword(String email, String password);
  Future<bool> signUpWithEmailAndPassword(
      String email, String password, String username, String imageUrl);
  Future<void> signOut();
  Future<User?> currentUser();
  Future<String?> getUserID();
}

class AuthServicesImpl implements AuthServices {
  // Singleton Design Pattern
  final firebaseAuth = FirebaseAuth.instance;
  final firestoreServices = FirestoreService.instance;

  @override
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = userCredential.user;
    if (user != null) {
      return true;
    }
    return false;
  }

  @override
  Future<void> signOut() async {
    firebaseAuth.signOut();
  }

  @override
  Future<bool> signUpWithEmailAndPassword(
      String email, String password, String username, String imageUrl) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = userCredential.user;
    if (user != null) {
      await firestoreServices.setData(path: ApiPaths.user(user.uid), data: {
        'email': user.email,
        'username': username,
        'imageUrl': imageUrl,
        'role': 'customer',
      });
      return true;
    }
    return false;
  }

  @override
  Future<User?> currentUser() {
    return Future.value(firebaseAuth.currentUser);
  }

  @override
  Future<String?> getUserID() async {
    final User? user = firebaseAuth.currentUser;
    return user?.uid;
  }
}
