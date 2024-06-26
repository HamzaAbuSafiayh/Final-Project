part of 'credit_card_cubit.dart';

sealed class CreditCardState {}

final class CreditCardInitial extends CreditCardState {}

final class CreditCardLoading extends CreditCardState {}

final class CreditCardSuccess extends CreditCardState {}

final class CreditCardFailure extends CreditCardState {
  final String message;

  CreditCardFailure(this.message);
}

final class CreditCardAdded extends CreditCardState {
  final CreditCardModel creditCard;

  CreditCardAdded(this.creditCard);
}

final class CreditCardsInitial extends CreditCardState {}

final class CreditCardsLoading extends CreditCardState {}

final class CreditCardsFailure extends CreditCardState {
  final String message;

  CreditCardsFailure(this.message);
}

final class CreditCardsLoaded extends CreditCardState {
  final List<CreditCardModel> creditCards;

  CreditCardsLoaded(this.creditCards);
}
