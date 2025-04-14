part of '../sign_up_imports.dart';

class SignUpButtons extends StatelessWidget {
  final SignUpInitial currentState;
  final SignUpCubit cubit;
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const SignUpButtons({
    super.key,
    required this.currentState,
    required this.cubit,
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneController,
    required this.emailController,
    required this.passwordController,
  });

  void closeKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CustomButton(
            onPressed: currentState.isPasswordValid
                ? () {
              closeKeyboard(context);
              cubit.validateAndProceed(
                formKey: formKey,
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                phone: phoneController.text,
                email: emailController.text,
                password: passwordController.text,
              );
              cubit.updatePasswordValidation(passwordController.text);
            }
                : () {},
            text: MyStrings.createAccount,
            textColor: Colors.white,
            color: currentState.isPasswordValid ? Colors.red : Colors.grey,
            width: 0.w,
            borderColor: currentState.isPasswordValid ? Colors.red : Colors.grey,
          ),
        ),
        8.verticalSpace,
        Center(
          child: AuthTextButton(
            text: MyStrings.userNameSignIn,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SigInView(),
                ),
              );
            },
            textStyle: const TextStyle(
              color: Colors.black,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
