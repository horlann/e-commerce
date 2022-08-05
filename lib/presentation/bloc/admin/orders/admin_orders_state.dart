import 'package:kurilki/domain/entities/order/order.dart';

class AdminOrdersState {
  const AdminOrdersState();

  AdminOrdersState inProgress() {
    return const InProgressLoadingState();
  }

  AdminOrdersState failure() {
    return const AdminFailureState();
  }
}

class InProgressLoadingState extends AdminOrdersState {
  const InProgressLoadingState();
}

class AdminFailureState extends AdminOrdersState {
  const AdminFailureState();
}

class NewOrderState extends AdminOrdersState {
  const NewOrderState(this.orders);

  final List<OrderEntity> orders;
}
