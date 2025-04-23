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
        userData.forEach((key, value) {
        });
      }

      if (userData != null) {
        isRegistered = userData[SharedKeys.isRegisteredUser] ?? false;
        email = userData[SharedKeys.userEmail] ?? userData[SharedKeys.email];
        phone = userData[SharedKeys.userPhone] ?? userData[SharedKeys.phone];
        fullName = userData[SharedKeys.userFullName];

        await _storageService.setIsChecked(SharedKeys.isRegisteredUser, isRegistered);

        if (fullName != null && fullName.isNotEmpty) {
          await _storageService.setString(SharedKeys.userFullName, fullName);
        }

        if (email != null && email.isNotEmpty) {
          await _storageService.setString(SharedKeys.userEmail, email);
          await _storageService.setString(SharedKeys.email, email);
        }

        if (phone != null && phone.isNotEmpty) {
          await _storageService.setString(SharedKeys.userPhone, phone);
          await _storageService.setString(SharedKeys.phone, phone);
        }
      } else {
        isRegistered = _storageService.getIsChecked(SharedKeys.isRegisteredUser) ?? false;
        fullName = _storageService.getString(SharedKeys.userFullName);

        email = _storageService.getString(SharedKeys.userEmail);
        if (email == null || email.isEmpty) {
          email = _storageService.getString(SharedKeys.email);
        }

        phone = _storageService.getString(SharedKeys.userPhone);
        if (phone == null || phone.isEmpty) {
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
      final emailRememberMe = _storageService.getIsChecked(SharedKeys.emailRememberMe) ?? false;
      final phoneRememberMe = _storageService.getIsChecked(SharedKeys.phoneRememberMe) ?? false;

      await _storageService.setIsChecked(SharedKeys.isRegisteredUser, false);
      await _storageService.remove(SharedKeys.userFullName);
      await _storageService.remove(SharedKeys.userEmail);
      await _storageService.remove(SharedKeys.userPhone);

      if (!emailRememberMe) {
        await _storageService.remove(SharedKeys.email);
      }

      if (!phoneRememberMe) {
        await _storageService.remove(SharedKeys.phone);
      }

      emit(HomeInitial());
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}