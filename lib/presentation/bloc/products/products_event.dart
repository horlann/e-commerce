import 'package:kurilki/domain/entities/items/item.dart';

abstract class ProductsEvent {
  const ProductsEvent();
}

class InitEvent extends ProductsEvent {
  const InitEvent();
}

class ShowPageEvent extends ProductsEvent {
  const ShowPageEvent();
}

class ShowAllProductsEvent extends ProductsEvent {
  const ShowAllProductsEvent();
}

class ShowDisposableProductsEvent extends ProductsEvent {
  const ShowDisposableProductsEvent();
}

class ShowSnusProductsEvent extends ProductsEvent {
  const ShowSnusProductsEvent();
}

class SearchProductEvent extends ProductsEvent {
  const SearchProductEvent(this.request);

  final String request;
}
