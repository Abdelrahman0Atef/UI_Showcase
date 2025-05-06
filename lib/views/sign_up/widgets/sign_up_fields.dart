part of '../sign_up_imports.dart';

class SignUpFields extends StatelessWidget {
  final SignUpViewModel viewModel;
  final FocusNode firstNameFocusNode;
  final FocusNode lastNameFocusNode;
  final FocusNode phoneFocusNode;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const SignUpFields({
    required this.viewModel,
    required this.firstNameFocusNode,
    required this.lastNameFocusNode,
    required this.phoneFocusNode,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneController,
    required this.emailController,
    required this.passwordController,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      CustomTextFieldWithTitle(
        label: MyStrings.firstName,
        validator: (value) => ValidationHelper.validateName(value as String?),
        focusNode: firstNameFocusNode,
        controller: firstNameController,
        onSubmitted: (_) {
          firstNameFocusNode.unfocus();
          lastNameFocusNode.requestFocus();
        },
      ),
      16.verticalSpace,
      CustomTextFieldWithTitle(
        label: MyStrings.lastName,
        validator: (value) => ValidationHelper.validateName(value as String?),
        focusNode: lastNameFocusNode,
        controller: lastNameController,
        onSubmitted: (_) {
          lastNameFocusNode.unfocus();
          phoneFocusNode.requestFocus();
        },
      ),
      16.verticalSpace,
      CustomTextFieldWithTitle(
        isPhoneField: true,
        label: MyStrings.phoneNumber,
        validator: (value) => ValidationHelper.validatePhone(value as String?),
        focusNode: phoneFocusNode,
        controller: phoneController,
        onSubmitted: (_) {
          phoneFocusNode.unfocus();
          emailFocusNode.requestFocus();
        },
        keyboardType: TextInputType.number,
      ),
      16.verticalSpace,
      CustomTextFieldWithTitle(
        label: MyStrings.email,
        validator: (value) => ValidationHelper.validateEmail(value as String?),
        focusNode: emailFocusNode,
        controller: emailController,
        onSubmitted: (_) {
          emailFocusNode.unfocus();
          passwordFocusNode.requestFocus();
        },
      ),
      16.verticalSpace,
      BlocBuilder(
        bloc: viewModel._passwordVisibleCubit,
        builder:
            (context, state) => CustomTextFieldWithTitle(
              label: MyStrings.password,
              obscureText: !viewModel._isPasswordVisible,
              isPasswordVisible: viewModel._isPasswordVisible,
              onIconPressed: viewModel._togglePasswordVisibility,
              validator:
                  (value) =>
                      ValidationHelper.validatePassword(value as String?),
              focusNode: passwordFocusNode,
              controller: passwordController,
              onChanged: (value) => viewModel._updatePasswordValidation(value),
              onSubmitted: (_) => closeKeyboard(context),
              isLastField: true,
            ),
      ),
    ],
  );

  void closeKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
