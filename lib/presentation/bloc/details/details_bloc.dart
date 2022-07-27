import 'package:bloc/bloc.dart';
import 'package:kurilki/data/repositories/remote_repository.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/presentation/bloc/products/products_bloc.dart';

import 'details_event.dart';
import 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final Item _item;
  final ProductsBloc _productsBloc;
  final RemoteRepository _remoteRepository;

  DetailsBloc(this._item, this._productsBloc, this._remoteRepository) : super(DetailsState().init()) {
    on<InitDetailsPageEvent>(_init);
  }

  List<Item> sameItems = [];

  void _init(InitDetailsPageEvent event, Emitter<DetailsState> emit) async {
    sameItems = await _remoteRepository.loadItemsWithSameId(_item);
    emit(state.loaded(sameItems));
  }
}
