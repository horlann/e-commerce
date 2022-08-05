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
    on<ShowAllProducts>(_showProduct);
    on<ShowDisposableProducts>(_showProduct);
    on<ShowSnusProducts>(_showProduct);
  }

  List<Item> productsList = [];

  void _init(InitEvent event, Emitter<ProductsState> emit) async {
    emit(const ProductsLoadingState());
    productsList = await _remoteRepository.loadAllItems();
    emit(ProductsLoadedState(productsList));
  }

  void _showProduct(ProductsEvent event, Emitter<ProductsState> emit) {
    if (event is ShowAllProducts) {
      emit(ProductsLoadedState(productsList));
    } else if (event is ShowDisposableProducts) {
      final List<DisposablePodEntity> list = productsList.whereType<DisposablePodEntity>().toList();
      emit(ProductsLoadedState(list));
    } else if (event is ShowSnusProducts) {
      final List<Snus> list = productsList.whereType<Snus>().toList();

      emit(ProductsLoadedState(list));
    }
  }
}
