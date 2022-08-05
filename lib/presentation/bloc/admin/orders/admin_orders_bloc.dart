import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurilki/data/repositories/admin/remote_admin_repositiory.dart';
import 'package:kurilki/domain/entities/order/order.dart';
import 'package:kurilki/presentation/bloc/admin/orders/admin_orders_event.dart';
import 'package:kurilki/presentation/bloc/admin/orders/admin_orders_state.dart';

class AdminOrdersBloc extends Bloc<AdminOrdersEvent, AdminOrdersState> {
  final RemoteAdminRepository _remoteAdminRepository;
  List<OrderEntity> orders = [];

  AdminOrdersBloc(this._remoteAdminRepository) : super(const AdminOrdersState().inProgress()) {
    on<InitOrdersEvent>(_listenOrdersStream);
  }

  Future<void> _listenOrdersStream(AdminOrdersEvent event, Emitter<AdminOrdersState> emit) async {
    await emit.onEach(_remoteAdminRepository.ordersStream(), onData: (message) {
      emit(NewOrderState(message as List<OrderEntity>));
    });
  }
}
