import 'package:json_annotation/json_annotation.dart';
import 'package:kurilki/common/typedefs/json.dart';
import 'package:kurilki/data/api/rest_api/schemas/firestore_schema.dart';
import 'package:kurilki/data/models/items/item_table_model.dart';

part 'disposable_pod_table_model.g.dart';

@JsonSerializable()
class DisposablePodTableModel extends ItemTableModel {
  DisposablePodTableModel(
      {required super.uuid,
      required super.id,
      required super.name,
      required super.price,
      required super.oldPrice,
      required super.category,
      required super.imageLink,
      required super.tags,
      required super.isAvailable,
      required this.puffsCount});

  @JsonKey(name: FirestoreSchema.puffsCount, defaultValue: 0)
  final int puffsCount;

  factory DisposablePodTableModel.fromJson(Map<String, dynamic> json) => _$DisposablePodTableModelFromJson(json);

  @override
  Json toJson() => _$DisposablePodTableModelToJson(this);
}
