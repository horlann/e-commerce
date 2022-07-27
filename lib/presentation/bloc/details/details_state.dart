import 'package:kurilki/domain/entities/items/item.dart';

class DetailsState {
  DetailsState init() {
    return DetailsState();
  }

  DetailsState clone() {
    return DetailsState();
  }

  DetailsState loaded(List<Item> list) {
    return DetailsLoadedState(list);
  }
}

class DetailsLoadedState extends DetailsState {
  final List<Item> list;

  DetailsLoadedState(this.list);
}
