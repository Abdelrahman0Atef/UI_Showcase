part of '../profile_imports.dart';

class ProfileViewModel {
  final GenericCubit<int> _selectedIndexCubit = GenericCubit(0);
  final GenericCubit<String?> _versionCubit = GenericCubit(null);
  final GenericCubit<String?> _phoneCubit = GenericCubit(null);
  final GenericCubit<String?> _emailCubit = GenericCubit(null);
  final GenericCubit<String?> _firstNameCubit = GenericCubit(null);
  final GenericCubit<String?> _lastNameCubit = GenericCubit(null);
  final LocalStorageService _storageService = getIt<LocalStorageService>();

  final SignUpViewModel vm = SignUpViewModel();

  void _init() {
    _getPhone();
    _getVersion();
    _getEmail();
    _getFirstName();
    _getLastName();
    vm.loadUserData();
  }

  void _signOut(BuildContext context) async {
    await _storageService.setIsChecked(SharedKeys.isRegisteredUser, false);
    final isRegistered = _storageService.getIsChecked(
      SharedKeys.isRegisteredUser,
    );
    if (isRegistered == false) {
      context.pushReplacementNamed(MyRouts.signIn);
    }
  }

  void _shareApp(BuildContext context) {
    final platform = Theme.of(context).platform;
    if (platform == TargetPlatform.iOS) {
      _shareAppLink(MyStrings.iosLink);
    } else if (platform == TargetPlatform.android) {
      _shareAppLink(MyStrings.androidLink);
    } else {
      _shareAppLink(MyStrings.webSiteLink);
    }
  }

  void _shareAppLink(String link) {
    SharePlus.instance.share(ShareParams(text: link));
  }

  void _getVersion() async {
    final info = await PackageInfo.fromPlatform();
    final String version = info.version;
    if (kDebugMode) {
      print(version);
    }
    _versionCubit.onUpdateData(version);
  }

  void _getPhone() {
    final String? phone = _storageService.getString(SharedKeys.phone) ?? '';
    _phoneCubit.onUpdateData(phone);
  }

  void _getEmail() {
    final String? email = _storageService.getString(SharedKeys.email) ?? '';
    _emailCubit.onUpdateData(email);
  }

  void _getFirstName() {
    final String? firstName =
        _storageService.getString(SharedKeys.firstName) ?? '';
    _firstNameCubit.onUpdateData(firstName);
  }

  void _getLastName() {
    final String? lastName =
        _storageService.getString(SharedKeys.lastName) ?? '';
    _lastNameCubit.onUpdateData(lastName);
  }
}
