abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final bool isRegisteredUser;
  final String? userEmail;
  final String? userPhone;
  final String? userFullName;
  final int selectedIndex;

  HomeLoaded({
    this.isRegisteredUser = false,
    this.userEmail,
    this.userPhone,
    this.userFullName,
    this.selectedIndex = 0,
  });

  HomeLoaded copyWith({
    bool? isRegisteredUser,
    String? userEmail,
    String? userPhone,
    String? userFullName,
    int? selectedIndex,
  }) => HomeLoaded(
      isRegisteredUser: isRegisteredUser ?? this.isRegisteredUser,
      userEmail: userEmail ?? this.userEmail,
      userPhone: userPhone ?? this.userPhone,
      userFullName: userFullName ?? this.userFullName,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
