part of '../profile_imports.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final LocalStorageService _storageService = getIt<LocalStorageService>();
  String? _appVersion;

  ProfileCubit() : super(ProfileInitial());

  Future<void> loadUserInfo([Map<String, dynamic>? userData]) async {
    emit(ProfileLoading());

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

        await _storageService.setIsChecked(
          SharedKeys.isRegisteredUser,
          isRegistered,
        );
      } else {
        isRegistered =
            _storageService.getIsChecked(SharedKeys.isRegisteredUser) ?? false;

        final bool emailRememberMe =
            _storageService.getIsChecked(SharedKeys.emailRememberMe) ?? false;
        final bool phoneRememberMe =
            _storageService.getIsChecked(SharedKeys.phoneRememberMe) ?? false;

        if (emailRememberMe) {
          email = _storageService.getString(SharedKeys.email);
        }

        if (phoneRememberMe) {
          phone = _storageService.getString(SharedKeys.phone);
        }
      }

      emit(
        ProfileLoaded(
          isRegisteredUser: isRegistered,
          userFullName: fullName,
          userEmail: email,
          userPhone: phone,
        ),
      );
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  void updateSelectedIndex(int index) {
    if (state is ProfileLoaded) {
      final currentState = state as ProfileLoaded;
      emit(currentState.copyWith(selectedIndex: index));
    }
  }

  Future<void> signOut() async {
    try {
      await _storageService.setIsChecked(SharedKeys.isRegisteredUser, false);

      emit(ProfileInitial());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  void shareApp(String link) {
    SharePlus.instance.share(ShareParams(text: link));
  }

  void fetchAppVersion() async {
    final info = await PackageInfo.fromPlatform();
    _appVersion = info.version;

    if (state is ProfileLoaded) {
      emit((state as ProfileLoaded).copyWith(appVersion: _appVersion));
    }
  }
}