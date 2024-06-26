import 'package:finalproject/models/credit_card_model.dart';
import 'package:finalproject/services/credit_card_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'credit_card_state.dart';

class CreditCardCubit extends Cubit<CreditCardState> {
  CreditCardCubit() : super(CreditCardInitial());
  final creditcardServices = CreditCardServicesImpl();

  Future<void> addCreditCard(CreditCardModel creditCard) async {
    emit(CreditCardLoading());
    try {
      await creditcardServices.addCreditCard(creditCard);
      emit(CreditCardAdded(creditCard));
    } catch (e) {
      emit(CreditCardFailure(e.toString()));
    }
  }

  Future<void> removeCreditCard(String cardNumber) async {
    emit(CreditCardLoading());
    try {
      await creditcardServices.removeCreditCard(cardNumber);
      emit(CreditCardSuccess());
    } catch (e) {
      emit(CreditCardFailure(e.toString()));
    }
  }

   void getCreditCardList() {
    emit(CreditCardsLoading());
    creditcardServices.creditCardStream().listen((creditCards) {
      emit(CreditCardsLoaded(creditCards));
    }).onError((error) {
      emit(CreditCardsFailure(error.toString()));
    });
  }

  Future<void> getCreditCardListnormal() async {
    emit(CreditCardsLoading());
    try {
      final creditCards = await creditcardServices.getCreditCardList();
      emit(CreditCardsLoaded(creditCards));
    } catch (e) {
      emit(CreditCardsFailure(e.toString()));
    }
  }
}
