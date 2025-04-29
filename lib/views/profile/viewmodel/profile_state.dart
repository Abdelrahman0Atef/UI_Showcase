abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final bool isRegisteredUser;
  final String? userEmail;
  final String? userPhone;
  final String? userFullName;
  final int selectedIndex;
  final String? appVersion;

  ProfileLoaded({
    this.isRegisteredUser = false,
    this.userEmail,
    this.userPhone,
    this.userFullName,
    this.selectedIndex = 0,
    this.appVersion,
  });

  ProfileLoaded copyWith({
    bool? isRegisteredUser,
    String? userEmail,
    String? userPhone,
    String? userFullName,
    int? selectedIndex,
    String? appVersion,
  }) => ProfileLoaded(
    isRegisteredUser: isRegisteredUser ?? this.isRegisteredUser,
    userEmail: userEmail ?? this.userEmail,
    userPhone: userPhone ?? this.userPhone,
    userFullName: userFullName ?? this.userFullName,
    selectedIndex: selectedIndex ?? this.selectedIndex,
    appVersion: appVersion ?? this.appVersion,
  );
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}