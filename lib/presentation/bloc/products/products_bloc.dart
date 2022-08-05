import 'package:bloc/bloc.dart';
import 'package:kurilki/data/repositories/remote_repository.dart';
import 'package:kurilki/domain/entities/items/disposable_pod_entity.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/domain/entities/items/snus.dart';

import 'products_event.dart';
import 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final RemoteRepository _remoteRepository;

  ProductsBloc(this._remoteRepository) : super(const ProductsLoadingState()) {
    on<InitEvent>(_init);
    on<ShowPageEvent>(_showPage);
    on<ShowAllProductsEvent>(_showProduct);
    on<ShowDisposableProductsEvent>(_showProduct);
    on<ShowSnusProductsEvent>(_showProduct);
    on<SearchProductEvent>(_searchProduct);
  }

  List<Item> productsList = [];

  void _init(InitEvent event, Emitter<ProductsState> emit) async {
    emit(const ProductsLoadingState());
    productsList = await _remoteRepository.loadAllItems();
    emit(ProductsLoadedState(productsList, productsList));
  }

  void _showPage(ShowPageEvent event, Emitter<ProductsState> emit) {
    emit(ProductsLoadedState(productsList, productsList));
  }

  void _showProduct(ProductsEvent event, Emitter<ProductsState> emit) {
    if (event is ShowAllProductsEvent) {
      emit(ProductsLoadedState(productsList, productsList));
    } else if (event is ShowDisposableProductsEvent) {
      final List<DisposablePodEntity> list = productsList.whereType<DisposablePodEntity>().toList();
      emit(ProductsLoadedState(list, productsList));
    } else if (event is ShowSnusProductsEvent) {
      final List<Snus> list = productsList.whereType<Snus>().toList();
      emit(ProductsLoadedState(list, productsList));
    }
  }

  void _searchProduct(SearchProductEvent event, Emitter<ProductsState> emit) {
    final List<Item> foundItems = [];
    for (Item item in productsList) {
      for (String element in item.tags) {
        if (element.contains(event.request)) {
          foundItems.add(item);
        }
      }
    }
    emit(SearchProductState(foundItems));
  }
}
