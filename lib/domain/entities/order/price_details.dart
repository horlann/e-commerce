class PriceDetails {
  final double fullPrice;
  final double deliveryPrice;
  final double coupon;
  final double salePercent;
  final double totalPrice;
  final double itemsPrice;
  final PayType type;

  PriceDetails({
    double? coupon,
    double? salePercent,
    required this.fullPrice,
    required this.deliveryPrice,
    required this.totalPrice,
    required this.itemsPrice,
    required this.type,
  })  : coupon = coupon ?? 0,
        salePercent = salePercent ?? 0;

  PriceDetails copyWith({
    double? fullPrice,
    double? deliveryPrice,
    double? coupon,
    double? salePercent,
    double? totalPrice,
    double? itemsPrice,
    PayType? type,
  }) {
    return PriceDetails(
      fullPrice: fullPrice ?? this.fullPrice,
      deliveryPrice: deliveryPrice ?? this.deliveryPrice,
      coupon: coupon ?? this.coupon,
      salePercent: salePercent ?? this.salePercent,
      totalPrice: totalPrice ?? this.totalPrice,
      itemsPrice: itemsPrice ?? this.itemsPrice,
      type: type ?? this.type,
    );
  }
}

enum PayType { bank, cashOnDelivery, none }
