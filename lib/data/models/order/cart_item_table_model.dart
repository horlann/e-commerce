import 'package:json_annotation/json_annotation.dart';
import 'package:kurilki/common/typedefs/json.dart';
import 'package:kurilki/data/api/rest_api/schemas/firestore_schema.dart';
import 'package:kurilki/data/models/items/item_table_model.dart';
import 'package:kurilki/domain/entities/order/cart_item.dart';

part 'cart_item_table_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CartItemTableModel {
  @JsonKey(name: FirestoreSchema.item)
  final ItemTableModel item;
  @JsonKey(name: FirestoreSchema.count, defaultValue: 0)
  final int count;

  const CartItemTableModel({
    required this.item,
    required this.count,
  });

  factory CartItemTableModel.fromJson(Map<String, dynamic> json) => _$CartItemTableModelFromJson(json);

  factory CartItemTableModel.fromEntity(CartItem cartItem) => CartItemTableModel(
      item: ItemTableModel.fromEntity(
        cartItem.item,
      ),
      count: cartItem.count);

  Json toJson() => _$CartItemTableModelToJson(this);
}
