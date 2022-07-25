import 'package:uuid/uuid.dart';

abstract class Item {
  final String uuid;

  final String id;

  final String name;

  final double price;

  final double oldPrice;

  final String category;

  final String imageLink;

  final List<String> tags;

  final bool isAvailable;

  Item({
    String? uuid,
    required this.id,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.category,
    required this.imageLink,
    required this.tags,
    required this.isAvailable,
  }) : uuid = uuid ?? const Uuid().v4();
}

enum ProductCategory { disposablePod, snus, unidentified }
