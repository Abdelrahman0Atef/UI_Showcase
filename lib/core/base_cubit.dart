import 'package:untitled/core/constants/imports.dart';

abstract class BaseCubit<T> extends Cubit<T> {
  BaseCubit(T initialState) : super(initialState);

  void togglePasswordVisibility();

  bool validateForm(GlobalKey<FormState> formKey) {
    return formKey.currentState!.validate();
  }

  void showSnackBar(
    BuildContext context,
    String message, {
    Color backgroundColor = Colors.red,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void navigateTo(BuildContext context, Widget screen, {bool replace = false}) {
    if (replace) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
    }
  }
}
