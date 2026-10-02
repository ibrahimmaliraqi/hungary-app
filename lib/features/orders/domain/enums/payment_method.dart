enum PaymentMethod {
  cash,
  card,
}

extension PaymentMethodExtension on PaymentMethod {
  String get value {
    switch (this) {
      case PaymentMethod.cash:
        return 'COD';
      case PaymentMethod.card:
        return 'CARD';
    }
  }
}