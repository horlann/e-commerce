import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kurilki/data/repositories/user/user_remote_repository.dart';
import 'package:kurilki/domain/entities/order/cart_item.dart';
import 'package:kurilki/domain/entities/order/delivery_details.dart';
import 'package:kurilki/domain/entities/order/order.dart';
import 'package:kurilki/domain/entities/user/history_item.dart';
import 'package:kurilki/domain/entities/user/user_entity.dart';
import 'package:kurilki/main.dart';
import 'package:kurilki/presentation/bloc/account/account_event.dart';
import 'package:kurilki/presentation/bloc/account/account_state.dart';

@injectable
class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final UserRemoteRepository _userRemoteRepository;

  AccountBloc(this._userRemoteRepository) : super(const UnauthorizedState()) {
    on<InitAuthEvent>(_initAuth);
    on<AuthWithGoogleAccountEvent>(_authWithGoogleAccount);
    on<LogoutFromAccountEvent>(_logout);
    on<LoadDataEvent>(_loadData);
    on<SaveDataEvent>(_saveData);
  }

  Future<void> _initAuth(AccountEvent event, Emitter<AccountState> emit) async {
    emit(state.inProgress());
    try {
      final result = await _userRemoteRepository.getAccountEntity();
      emit(state.authorized(entity: result));
    } on Exception {
      emit(state.unauthorized());
    }
  }

  Future<void> _authWithGoogleAccount(AccountEvent event, Emitter<AccountState> emit) async {
    emit(state.inProgress());
    try {
      final result = await _userRemoteRepository.authWithGoogleAccount();
      emit(state.authorized(entity: result));
      add(const LoadDataEvent());
    } on Exception {
      emit(state.failure());
    }
  }

  Future<void> _logout(AccountEvent event, Emitter<AccountState> emit) async {
    emit(state.inProgress());
    try {
      await _userRemoteRepository.logout();
      emit(state.unauthorized());
      add(const LoadDataEvent());
    } on Exception {
      emit(state.failure());
    }
  }

  Future<void> _loadData(LoadDataEvent event, Emitter<AccountState> emit) async {
    emit(state.inProgress());
    try {
      UserEntity user = await _userRemoteRepository.getAccountEntity();
      emit(state.userDataLoaded(user));
    } catch (e) {
      emit(state.localUserDataLoaded());
      logger.e(e);
    }
  }

  Future<void> _saveData(SaveDataEvent event, Emitter<AccountState> emit) async {
    try {
      UserEntity userEntity = await _userRemoteRepository.getAccountEntity();
      userEntity = userEntity.copyWith(
        deliveryDetails: DeliveryDetails(
          deliveryType: event.userData.deliveryType,
          address: event.userData.address,
          name: event.userData.name,
          phone: event.userData.phone,
        ),
      );
      final List<HistoryItem> historyItems = [];
      for (CartItem cartItem in event.cartItems) {
        for (int i = 1; i <= cartItem.count; i++) {
          historyItems.add(HistoryItem(
            item: cartItem.item,
            itemSettings: cartItem.itemSettings,
            createdAt: DateTime.now(),
            orderStatus: OrderStatus.created,
          ));
        }
      }
      userEntity = userEntity.copyWith(items: userEntity.items + historyItems);
      await _userRemoteRepository.setAccountEntity(userEntity);
      add(const LoadDataEvent());
    } catch (e) {
      logger.e(e);
    }
  }
}
