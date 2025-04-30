part of '../profile_imports.dart';

class ProfileViewModel {
  final BuildContext context;
  late final ProfileCubit cubit;

  ProfileViewModel(this.context) {
    cubit = context.read<ProfileCubit>();
  }

  ProfileState get state => cubit.state;

  Future<void> loadUserInfo([Map<String, dynamic>? userData]) async {
    cubit.loadUserInfo(userData);
    await getVersion();
  }

  void updateIndex(int index) => cubit.updateSelectedIndex(index);

  void signOut() => cubit.signOut();

  void shareApp() {
    final platform = Theme.of(context).platform;
    if (platform == TargetPlatform.iOS) {
      cubit.shareApp(MyStrings.iosLink);
    } else if (platform == TargetPlatform.android) {
      cubit.shareApp(MyStrings.androidLink);
    } else {
      cubit.shareApp(MyStrings.webSiteLink);
    }
  }

  Future<void> getVersion() async {
    final info = await PackageInfo.fromPlatform();
    cubit._appVersion = info.version;

    final currentState = cubit.state;
    if (currentState is ProfileLoaded) {
      cubit.fetchAppVersion();
    }
  }

  String getVersionText() {
    if (state is ProfileLoaded) {
      final loadedState = state as ProfileLoaded;
      return loadedState.appVersion ?? cubit._appVersion ?? '1.0.0';
    }
    return '1.0.0';
  }
}
