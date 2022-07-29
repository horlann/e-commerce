import 'package:kurilki/domain/entities/category/category_entity.dart';
import 'package:kurilki/domain/entities/order/order.dart';

class AdminState {
  const AdminState();

  AdminState init() {
    return const AdminState();
  }

  AdminState clone() {
    return const AdminState();
  }

  AdminState inProgress() {
    return const InProgressLoadingState();
  }

  AdminState categoriesLoaded(List<CategoryEntity> categories) {
    return CategoriesLoadedState(categories);
  }

  AdminState newOrder(List<OrderEntity> orders) {
    return NewOrderState(orders);
  }

  AdminState failure() {
    return const AdminFailureState();
  }
}

class InProgressLoadingState extends AdminState {
  const InProgressLoadingState();
}

class CategoriesLoadedState extends AdminState {
  const CategoriesLoadedState(this.categories);

  final List<CategoryEntity> categories;
}

class AdminFailureState extends AdminState {
  const AdminFailureState();
}

class NewOrderState extends AdminState {
  const NewOrderState(this.orders);

  final List<OrderEntity> orders;
}
