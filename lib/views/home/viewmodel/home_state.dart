abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final String? userFullName;
  final String? userEmail;
  final String? userPhone;
  final bool isRegisteredUser;

  HomeLoaded({
    this.userFullName,
    this.userEmail,
    this.userPhone,
    this.isRegisteredUser = false,
  });

  HomeLoaded copyWith({
    String? userFullName,
    String? userEmail,
    String? userPhone,
    bool? isRegisteredUser,
  }) => HomeLoaded(
      userFullName: userFullName ?? this.userFullName,
      userEmail: userEmail ?? this.userEmail,
      userPhone: userPhone ?? this.userPhone,
      isRegisteredUser: isRegisteredUser ?? this.isRegisteredUser,
    );
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}