import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kurilki/data/repositories/remote_repository.dart';
import 'package:kurilki/domain/entities/order/delivery_details.dart';
import 'package:kurilki/domain/entities/user/user_entity.dart';
import 'package:kurilki/main.dart';
import 'package:kurilki/presentation/bloc/account/account_event.dart';
import 'package:kurilki/presentation/bloc/account/account_state.dart';

@injectable
class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final RemoteRepository _remoteRepository;

  AccountBloc(this._remoteRepository) : super(const UnauthorizedState()) {
    on<InitAuthEvent>(_initAuth);
    on<AuthWithGoogleAccountEvent>(_authWithGoogleAccount);
    on<LogoutFromAccountEvent>(_logout);
    on<LoadDataEvent>(_loadData);
    on<SaveDataEvent>(_saveData);
  }

  Future<void> _initAuth(AccountEvent event, Emitter<AccountState> emit) async {
    emit(state.inProgress());
    try {
      final result = await _remoteRepository.getAccountEntity();
      emit(state.authorized(entity: result));
    } on Exception {
      emit(state.unauthorized());
    }
  }

  Future<void> _authWithGoogleAccount(AccountEvent event, Emitter<AccountState> emit) async {
    emit(state.inProgress());
    try {
      final result = await _remoteRepository.authWithGoogleAccount();
      emit(state.authorized(entity: result));
    } on Exception {
      emit(state.failure());
    }
  }

  Future<void> _logout(AccountEvent event, Emitter<AccountState> emit) async {
    emit(state.inProgress());
    try {
      await _remoteRepository.logout();
      emit(state.unauthorized());
    } on Exception {
      emit(state.failure());
    }
  }

  Future<void> _loadData(LoadDataEvent event, Emitter<AccountState> emit) async {
    emit(state.inProgress());
    try {
      UserEntity user = await _remoteRepository.getAccountEntity();
      emit(state.userDataLoaded(user));
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> _saveData(SaveDataEvent event, Emitter<AccountState> emit) async {
    try {
      UserEntity userEntity = await _remoteRepository.getAccountEntity();
      userEntity = userEntity.copyWith(
        deliveryDetails: DeliveryDetails(
          deliveryType: event.userData.deliveryType,
          address: event.userData.address,
          name: event.userData.name,
          phone: event.userData.phone,
        ),
      );
      await _remoteRepository.setAccountEntity(userEntity);
    } catch (e) {
      logger.e(e);
    }
  }
}
