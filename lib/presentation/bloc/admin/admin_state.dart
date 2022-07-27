import 'package:kurilki/domain/entities/category/category_entity.dart';

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

  AdminState dataLoaded(List<CategoryEntity> categories) {
    return DataLoadedState(categories);
  }

  AdminState failure() {
    return const AdminFailureState();
  }
}

class InProgressLoadingState extends AdminState {
  const InProgressLoadingState();
}

class DataLoadedState extends AdminState {
  const DataLoadedState(this.categories);

  final List<CategoryEntity> categories;
}

class AdminFailureState extends AdminState {
  const AdminFailureState();
}
