import 'package:kurilki/data/models/admin/category_table_model.dart';
import 'package:uuid/uuid.dart';

class CategoryEntity {
  final String name;

  final String uuid;

  CategoryEntity({
    String? uuid,
    required this.name,
  }) : uuid = uuid ?? const Uuid().v4();

  factory CategoryEntity.fromTableModel(CategoryTableModel model) => CategoryEntity(
        name: model.name,
        uuid: model.uuid,
      );
}
