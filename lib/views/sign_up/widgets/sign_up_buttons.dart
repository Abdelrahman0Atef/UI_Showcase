part of '../sign_up_imports.dart';

class SignUpButtons extends StatelessWidget {
  final SignUpViewModel vm;
  final GlobalKey<FormState> formKey;

  const SignUpButtons({
    required this.vm,
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
              vm._hasCapitalLetterCubit.state.data &&
                      vm._hasNumberCubit.state.data &&
                      vm._hasValidLengthCubit.state.data
                  ? () {
                    closeKeyboard(context);
                    vm._validateAndProceed(
                      formKey: formKey,
                      context: context,
                    );
                    vm._updatePasswordValidation(
                      vm._passwordController.text,
                    );
                  }
                  : () {},
          text: MyStrings.createAnAccount,
          textColor: MyColors.white,
          color:
              vm._hasCapitalLetterCubit.state.data &&
                      vm._hasNumberCubit.state.data &&
                      vm._hasValidLengthCubit.state.data
                  ? MyColors.red
                  : MyColors.grey,
          width: 0.w,
          borderColor:
              vm._hasCapitalLetterCubit.state.data &&
                      vm._hasNumberCubit.state.data &&
                      vm._hasValidLengthCubit.state.data
                  ? MyColors.red
                  : MyColors.grey,
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
