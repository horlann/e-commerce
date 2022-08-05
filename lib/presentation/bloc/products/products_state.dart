import 'package:kurilki/domain/entities/items/item.dart';

class ProductsState {
  const ProductsState();

  ProductsState init() {
    return const ProductsState();
  }

  ProductsState loading() {
    return const ProductsLoadingState();
  }

  ProductsState productsLoaded(List<Item> items, List<Item> popularItems) {
    return ProductsLoadedState(items, popularItems);
  }
}

class ProductsLoadingState extends ProductsState {
  const ProductsLoadingState();
}

class ProductsLoadedState extends ProductsState {
  const ProductsLoadedState(this.items, this.popularItems);

  final List<Item> items;
  final List<Item> popularItems;
}

class SearchProductState extends ProductsState {
  const SearchProductState(this.items);

  final List<Item> items;
}
