import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/data/repositories/admin/remote_admin_repositiory.dart';
import 'package:kurilki/data/repositories/remote_repository.dart';
import 'package:kurilki/domain/entities/items/item.dart';

import 'package:kurilki/presentation/bloc/admin/item/admin_item_event.dart';
import 'package:kurilki/presentation/bloc/admin/item/admin_item_state.dart';

class AdminItemBloc extends Bloc<AdminItemEvent, AdminItemState> {
  final RemoteRepository _remoteRepository;
  final RemoteAdminRepository _remoteAdminRepository;
  List<Item> items = [];

  AdminItemBloc(this._remoteRepository, this._remoteAdminRepository) : super(const AdminItemState().inProgress()) {
    on<InitItemsEvent>(_initItems);
    on<CreateItemEvent>(_createItem);
    on<EditItemEvent>(_editItem);
    on<UpdateDisposableItemEvent>(_updateItem);
    on<UpdateSnusItemEvent>(_updateItem);
  }

  void _initItems(AdminItemEvent event, Emitter<AdminItemState> emit) async {
    emit(state.inProgress());
    items = await _remoteRepository.loadAllItems();
    emit(state.itemsLoaded(items));
  }

  void _createItem(AdminItemEvent event, Emitter<AdminItemState> emit) async {
    await _remoteAdminRepository.createItem((event as CreateItemEvent).item);
  }

  void _editItem(AdminItemEvent event, Emitter<AdminItemState> emit) async {
    emit(state.editItem((event as EditItemEvent).item));
  }

  void _updateItem(AdminItemEvent event, Emitter<AdminItemState> emit) async {
    emit(state.inProgress());
    if (event is UpdateSnusItemEvent) {
      await _remoteAdminRepository.updateItem(event.item);
    } else if (event is UpdateDisposableItemEvent) {
      await _remoteAdminRepository.updateItem(event.item);
    }
    emit(const SaveEditItemState());
    add(const InitItemsEvent());
  }
}
