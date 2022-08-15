import 'package:kurilki/domain/entities/order/order.dart';

abstract class AdminOrdersEvent {
  const AdminOrdersEvent();
}

class InitOrdersEvent extends AdminOrdersEvent {
  const InitOrdersEvent();
}

class ChangeOrderStatusEvent extends AdminOrdersEvent {
  const ChangeOrderStatusEvent(this.orderEntity);

  final OrderEntity orderEntity;
}
