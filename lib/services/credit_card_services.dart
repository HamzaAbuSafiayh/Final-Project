import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/models/credit_card_model.dart';
import 'package:finalproject/routes/api_paths.dart';
import 'package:finalproject/services/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class CreditCardServices {
  Future<void> addCreditCard(CreditCardModel card);
  Future<void> removeCreditCard(String cardNumber);
  Future<void> updateCreditCard(
      String cardNumber, String expiryDate, String cardHolderName, String cvv);
  Future<List<CreditCardModel>> getCreditCardList();
  Stream<List<CreditCardModel>> creditCardStream();
}

class CreditCardServicesImpl implements CreditCardServices {
  final firestoreServices = FirestoreService.instance;
  final user = FirebaseAuth.instance.currentUser;
  @override
  Future<void> addCreditCard(CreditCardModel card) async {
    await firestoreServices
        .setData(path: ApiPaths.creditCard(user!.uid, card.cardNumber), data: {
      'cardNumber': card.cardNumber,
      'expiryDate': card.expiryDate,
      'cardHolderName': card.cardHolder,
      'cvv': card.cvvCode,
    });
  }

  @override
  Future<void> removeCreditCard(String cardNumber) async {
    final user = FirebaseAuth.instance.currentUser;
    await firestoreServices.deleteData(
        path: ApiPaths.creditCard(user!.uid, cardNumber));
  }

  @override
  Future<void> updateCreditCard(String cardNumber, String expiryDate,
      String cardHolderName, String cvv) async {
    final user = FirebaseAuth.instance.currentUser;
    await firestoreServices
        .setData(path: ApiPaths.creditCard(user!.uid, cardNumber), data: {
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'cardHolderName': cardHolderName,
      'cvv': cvv,
    });
  }

  @override
  Future<List<CreditCardModel>> getCreditCardList() async {
    return await firestoreServices.getCollection(
      path: ApiPaths.creditCards(user!.uid),
      builder: (data, documentId) => CreditCardModel.fromMap(data),
    );
  }

  @override
  Stream<List<CreditCardModel>> creditCardStream() {
    if (user == null) {
      throw Exception("User not logged in");
    }

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('creditCards')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CreditCardModel.fromMap(doc.data()))
            .toList());
  }
}
