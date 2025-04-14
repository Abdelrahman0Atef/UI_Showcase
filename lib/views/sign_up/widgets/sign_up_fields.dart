part of sign_up;

class SignUpFields extends StatelessWidget {
  final SignUpInitial currentState;
  final SignUpCubit cubit;
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
    super.key,
    required this.currentState,
    required this.cubit,
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
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFieldWithTitle(
          label: MyStrings.kFirstName,
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
          label: MyStrings.kLastName,
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
          label: MyStrings.kPhone,
          validator: (value) => ValidationHelper.validatePhone(value as String?),
          focusNode: phoneFocusNode,
          controller: phoneController,
          onSubmitted: (_) {
            phoneFocusNode.unfocus();
            emailFocusNode.requestFocus();
          },
        ),
        16.verticalSpace,
        CustomTextFieldWithTitle(
          label: MyStrings.kEmail,
          validator: (value) => ValidationHelper.validateEmail(value as String?),
          focusNode: emailFocusNode,
          controller: emailController,
          onSubmitted: (_) {
            emailFocusNode.unfocus();
            passwordFocusNode.requestFocus();
          },
        ),
        16.verticalSpace,
        CustomTextFieldWithTitle(
          label: MyStrings.kPassword,
          obscureText: !currentState.isPasswordVisible,
          isPasswordVisible: currentState.isPasswordVisible,
          onIconPressed: cubit.togglePasswordVisibility,
          validator: (value) => ValidationHelper.validatePassword(value as String?),
          focusNode: passwordFocusNode,
          controller: passwordController,
          onChanged: (value) {
            cubit.updatePasswordValidation(value);
          },
          onSubmitted: (_) {
            closeKeyboard(context);
          },
          isLastField: true,
        ),
      ],
    );
  }

  void closeKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}