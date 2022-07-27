class PriceDetails {
  final double fullPrice;
  final double deliveryPrice;
  final double coupon;
  final double salePercent;
  final double totalPrice;
  final double itemsPrice;

  PriceDetails copyWith({
    double? fullPrice,
    double? deliveryPrice,
    double? coupon,
    double? salePercent,
    double? totalPrice,
    double? itemsPrice,
  }) {
    return PriceDetails(
      fullPrice: fullPrice ?? this.fullPrice,
      deliveryPrice: deliveryPrice ?? this.deliveryPrice,
      coupon: coupon ?? this.coupon,
      salePercent: salePercent ?? this.salePercent,
      totalPrice: totalPrice ?? this.totalPrice,
      itemsPrice: itemsPrice ?? this.itemsPrice,
    );
  }

  PriceDetails({
    double? coupon,
    double? salePercent,
    required this.fullPrice,
    required this.deliveryPrice,
    required this.totalPrice,
    required this.itemsPrice,
  })  : coupon = coupon ?? 0,
        salePercent = salePercent ?? 0;
}
