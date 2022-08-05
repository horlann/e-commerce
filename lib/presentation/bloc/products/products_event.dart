import 'package:kurilki/domain/entities/items/item.dart';

abstract class ProductsEvent {
  const ProductsEvent();
}

class InitEvent extends ProductsEvent {
  const InitEvent();
}

class ShowAllProducts extends ProductsEvent {
  const ShowAllProducts();
}

class ShowDisposableProducts extends ProductsEvent {
  const ShowDisposableProducts();

}

class ShowSnusProducts extends ProductsEvent {
  const ShowSnusProducts();
}
