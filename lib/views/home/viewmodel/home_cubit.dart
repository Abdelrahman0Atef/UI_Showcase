part of '../home_imports.dart';

class HomeCubit extends Cubit<HomeState> {
  final LocalStorageService _storageService = getIt<LocalStorageService>();

  HomeCubit() : super(HomeInitial());

  Future<void> loadUserInfo([Map<String, dynamic>? userData]) async {
    emit(HomeLoading());

    try {
      bool isRegistered = false;
      String? fullName;
      String? email;
      String? phone;

      if (userData != null) {
        isRegistered = userData[SharedKeys.isRegisteredUser] ?? false;
        email = userData[SharedKeys.userEmail] ?? userData[SharedKeys.email];
        phone = userData[SharedKeys.userPhone] ?? userData[SharedKeys.phone];
        fullName = userData[SharedKeys.userFullName];

        await _storageService.setIsChecked(SharedKeys.isRegisteredUser, isRegistered);
      } else {
        isRegistered = _storageService.getIsChecked(SharedKeys.isRegisteredUser) ?? false;

        final bool emailRememberMe = _storageService.getIsChecked(SharedKeys.emailRememberMe) ?? false;
        final bool phoneRememberMe = _storageService.getIsChecked(SharedKeys.phoneRememberMe) ?? false;

        if (emailRememberMe) {
          email = _storageService.getString(SharedKeys.email);
        }

        if (phoneRememberMe) {
          phone = _storageService.getString(SharedKeys.phone);
        }
      }

      emit(HomeLoaded(
        isRegisteredUser: isRegistered,
        userFullName: fullName,
        userEmail: email,
        userPhone: phone,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void updateSelectedIndex(int index) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      emit(currentState.copyWith(selectedIndex: index));
    }
  }

  Future<void> signOut() async {
    try {
      await _storageService.setIsChecked(SharedKeys.isRegisteredUser, false);

      emit(HomeInitial());
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}