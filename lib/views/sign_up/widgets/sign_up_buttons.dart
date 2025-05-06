part of '../sign_up_imports.dart';

class SignUpButtons extends StatelessWidget {
  final SignUpViewModel viewModel;
  final GlobalKey<FormState> formKey;

  const SignUpButtons({
    required this.viewModel,
    required this.formKey,
    super.key,
  });

  void closeKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Center(
        child: CustomButton(
          onPressed:
              viewModel._isPasswordValid
                  ? () {
                    closeKeyboard(context);
                    viewModel._validateAndProceed(
                      formKey: formKey,
                      context: context,
                    );
                    viewModel._updatePasswordValidation(
                      viewModel._passwordController.text,
                    );
                  }
                  : () {},
          text: MyStrings.createAnAccount,
          textColor: MyColors.white,
          color: viewModel._isPasswordValid ? MyColors.red : MyColors.grey,
          width: 0.w,
          borderColor:
              viewModel._isPasswordValid ? MyColors.red : MyColors.grey,
        ),
      ),
      8.verticalSpace,
      Center(
        child: AuthTextButton(
          text: MyStrings.signIn,
          onPressed: () {
            context.pushNamed(MyRouts.signIn);
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
