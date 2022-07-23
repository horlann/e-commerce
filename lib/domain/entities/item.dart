abstract class Item {
  final String uuid;

  final String id;

  final String name;

  final double price;

  final double oldPrice;

  final String category;

  final String imageLink;

  const Item({
    required this.uuid,
    required this.id,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.category,
    required this.imageLink,
  });
}
