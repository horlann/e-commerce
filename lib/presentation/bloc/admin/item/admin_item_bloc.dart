import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/data/repositories/admin/remote_admin_repositiory.dart';
import 'package:kurilki/data/repositories/remote_repository.dart';
import 'package:kurilki/domain/entities/items/disposable_pod_entity.dart';
import 'package:kurilki/domain/entities/items/item.dart';
import 'package:kurilki/domain/entities/items/snus.dart';
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

  Future<void> _initItems(AdminItemEvent event, Emitter<AdminItemState> emit) async {
    emit(state.inProgress());
    items = await _remoteRepository.loadAllItems();
    emit(state.itemsLoaded(items));
  }

  Future<void> _createItem(CreateItemEvent event, Emitter<AdminItemState> emit) async {
    Item item = event.item;
    List<String> tags = [item.name, item.description, item.category, ...item.itemSettings.map((e) => e.name).toList()];
    if (item.runtimeType == DisposablePodEntity) {
      tags.add((item as DisposablePodEntity).puffsCount.toString());
      item = (item).copyWith(tags: tags);
    } else if (item.runtimeType == DisposablePodEntity) {
      tags.add((item as Snus).strength.toString());
      item = (item).copyWith(tags: tags);
    }
    await _remoteAdminRepository.createItem(item);
  }

  Future<void> _editItem(AdminItemEvent event, Emitter<AdminItemState> emit) async {
    emit(state.editItem((event as EditItemEvent).item));
  }

  Future<void> _updateItem(AdminItemEvent event, Emitter<AdminItemState> emit) async {
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
