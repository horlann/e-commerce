import 'package:kurilki/domain/entities/items/item.dart';

class ProductsState {
  const ProductsState();

  ProductsState init() {
    return const ProductsState();
  }

  ProductsState loading() {
    return const ProductsLoadingState();
  }

  ProductsState productsLoaded(List<Item> items) {
    return ProductsLoadedState(items);
  }
}

class ProductsLoadingState extends ProductsState {
  const ProductsLoadingState();
}

class ProductsLoadedState extends ProductsState {
  const ProductsLoadedState(this.items);

  final List<Item> items;
}
