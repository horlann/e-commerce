import 'package:bloc/bloc.dart';
import 'package:kurilki/data/repositories/remote_repository.dart';

import 'products_event.dart';
import 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final RemoteRepository _remoteRepository;

  ProductsBloc(this._remoteRepository) : super(ProductsState().init()) {
    on<InitEvent>(_init);
    on<CreateItemEvent>(_createItem);
  }

  void _init(InitEvent event, Emitter<ProductsState> emit) async {
    emit(state.clone());
  }

  void _createItem(CreateItemEvent event, Emitter<ProductsState> emit) async {
    _remoteRepository.createItem();
  }

  Future<void> _loadAllItems() async {}
}
