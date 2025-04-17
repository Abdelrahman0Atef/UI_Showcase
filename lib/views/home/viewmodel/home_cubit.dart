part of '../home_imports.dart';


class HomeCubit extends Cubit<HomeState> {
  final LocalStorageService _storageService = getIt<LocalStorageService>();

  HomeCubit() : super(HomeInitial());

  Future<void> loadUserInfo() async {
    emit(HomeLoading());

    try {
      final isRegistered =
          _storageService.getIsChecked(SharedKeys.isRegisteredUserKey) ?? false;

      if (isRegistered) {
        final fullName = _storageService.getString(SharedKeys.userFullNameKey);
        final email = _storageService.getString(SharedKeys.userEmailKey);
        final phone = _storageService.getString(SharedKeys.userPhoneKey);

        emit(HomeLoaded(
          isRegisteredUser: isRegistered,
          userFullName: fullName,
          userEmail: email,
          userPhone: phone,
        ));
      } else {
        final emailRememberMe =
            _storageService.getIsChecked(SharedKeys.emailRememberMeKey) ?? false;
        final phoneRememberMe =
            _storageService.getIsChecked(SharedKeys.phoneRememberMeKey) ?? false;

        String? email;
        String? phone;

        if (emailRememberMe) {
          email = _storageService.getString(SharedKeys.emailKey);
        } else if (phoneRememberMe) {
          phone = _storageService.getString(SharedKeys.phoneKey);
        }

        emit(HomeLoaded(
          userEmail: email,
          userPhone: phone,
        ));
      }
    } catch (e) {
      emit(HomeError(MyStrings.loadDataError));
    }
  }

  Future<void> logout() async {
    try {
      await _storageService.remove(SharedKeys.emailKey);
      await _storageService.remove(SharedKeys.passwordKey);
      await _storageService.remove(SharedKeys.phoneKey);
      await _storageService.remove(SharedKeys.userFullNameKey);
      await _storageService.remove(SharedKeys.userEmailKey);
      await _storageService.remove(SharedKeys.userPhoneKey);
      await _storageService.remove(SharedKeys.isRegisteredUserKey);
      await _storageService.setIsChecked(SharedKeys.emailRememberMeKey, false);
      await _storageService.setIsChecked(SharedKeys.phoneRememberMeKey, false);

      emit(HomeInitial());
    } catch (e) {
      emit(HomeError(MyStrings.signOutError));
    }
  }
}