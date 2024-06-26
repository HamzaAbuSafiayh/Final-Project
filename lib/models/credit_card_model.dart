import 'dart:convert';

class CreditCardModel {
  String cardNumber;
  String cardHolder;
  String expiryDate;
  String cvvCode;


  CreditCardModel({
    required this.cardNumber,
    required this.cardHolder,
    required this.expiryDate,
    required this.cvvCode,

  });

  CreditCardModel copyWith({
    String? cardNumber,
    String? cardHolder,
    String? expiryDate,
    String? cvvCode,
  }) {
    return CreditCardModel(
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolder: cardHolder ?? this.cardHolder,
      expiryDate: expiryDate ?? this.expiryDate,
      cvvCode: cvvCode ?? this.cvvCode,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'cardNumber': cardNumber});
    result.addAll({'cardHolder': cardHolder});
    result.addAll({'expiryDate': expiryDate});
    result.addAll({'cvvCode': cvvCode});
  
    return result;
  }

  factory CreditCardModel.fromMap(Map<String, dynamic> map) {
    return CreditCardModel(
      cardNumber: map['cardNumber'] ?? '',
      cardHolder: map['cardHolder'] ?? '',
      expiryDate: map['expiryDate'] ?? '',
      cvvCode: map['cvvCode'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CreditCardModel.fromJson(String source) => CreditCardModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreditCardModel(cardNumber: $cardNumber, cardHolder: $cardHolder, expiryDate: $expiryDate, cvvCode: $cvvCode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CreditCardModel &&
      other.cardNumber == cardNumber &&
      other.cardHolder == cardHolder &&
      other.expiryDate == expiryDate &&
      other.cvvCode == cvvCode;
  }

  @override
  int get hashCode {
    return cardNumber.hashCode ^
      cardHolder.hashCode ^
      expiryDate.hashCode ^
      cvvCode.hashCode;
  }
}
