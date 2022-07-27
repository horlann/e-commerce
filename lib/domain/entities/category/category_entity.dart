import 'package:kurilki/data/models/category_table_model.dart';
import 'package:uuid/uuid.dart';

class CategoryEntity {
  final String name;
  final int id;
  final String imageLink;
  final String uuid;

  CategoryEntity({
    String? uuid,
    required this.name,
    required this.id,
    required this.imageLink,
  }) : uuid = uuid ?? const Uuid().v4();

  factory CategoryEntity.fromTableModel(CategoryTableModel model) => CategoryEntity(
        id: model.id,
        name: model.name,
        imageLink: model.imageLink,
        uuid: model.uuid,
      );
}
