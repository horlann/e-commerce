import 'package:bloc/bloc.dart';
import 'package:kurilki/data/repositories/remote_repository.dart';
import 'package:kurilki/domain/entities/items/item.dart';

import 'products_event.dart';
import 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final RemoteRepository _remoteRepository;

  ProductsBloc(this._remoteRepository) : super(const ProductsLoadingState()) {
    on<InitEvent>(_init);
    on<CreateItemEvent>(_createItem);
  }

  List<Item> productsList = [];

  void _init(InitEvent event, Emitter<ProductsState> emit) async {
    emit(const ProductsLoadingState());
    productsList = await _remoteRepository.loadAllItems();
    emit(ProductsLoadedState(productsList));
  }

  void _createItem(CreateItemEvent event, Emitter<ProductsState> emit) async {
    _remoteRepository.createItem();
  }
}
