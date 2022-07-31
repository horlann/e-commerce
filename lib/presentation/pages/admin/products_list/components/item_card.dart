import 'package:flutter/material.dart';
import 'package:kurilki/domain/entities/items/item.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
    required this.item,
    required this.callback,
  }) : super(key: key);
  final Item item;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Material(
        child: InkWell(
          onTap: callback,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(item.name),
              Text(item.category),
            ],
          ),
        ),
      ),
    );
  }
}
