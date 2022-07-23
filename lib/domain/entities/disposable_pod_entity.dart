import 'package:kurilki/domain/entities/item.dart';

class DisposablePodEntity extends Item {
  DisposablePodEntity(
      {required super.uuid,
      required super.id,
      required super.name,
      required super.price,
      required super.oldPrice,
      required super.category,
      required super.imageLink});
}
