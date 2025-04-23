part of '../sign_in_imports.dart';

class SignInEmailFormWidget extends StatefulWidget {
  final SignInInitial currentState;
  final SignInCubit cubit;

  const SignInEmailFormWidget({
    required this.currentState,
    required this.cubit,
    super.key,
  });

  @override
  State<SignInEmailFormWidget> createState() => _SignInEmailFormWidgetState();
}

class _SignInEmailFormWidgetState extends State<SignInEmailFormWidget> {
  final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _loadCredentialsFromState();
  }

  void _loadCredentialsFromState() {
    if (emailController.text.isEmpty && widget.currentState.savedEmail.isNotEmpty) {
      emailController.text = widget.currentState.savedEmail;
    }
    if (passwordController.text.isEmpty && widget.currentState.savedPassword.isNotEmpty) {
      passwordController.text = widget.currentState.savedPassword;
    }
  }

  @override
  Widget build(BuildContext context) => Form(
    key: emailFormKey,
    child: Column(
      children: [
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
        24.verticalSpace,
        CustomTextFieldWithTitle(
          label: MyStrings.password,
          obscureText: !widget.currentState.passwordVisible,
          isPasswordVisible: widget.currentState.passwordVisible,
          onIconPressed: widget.cubit.togglePasswordVisibility,
          validator: (value) => ValidationHelper.validatePassword(value as String?),
          focusNode: passwordFocusNode,
          controller: passwordController,
          isLastField: true,
        ),
        8.verticalSpace,
        Align(
          alignment: Alignment.centerRight,
          child: AuthTextButton(
            textStyle: const TextStyle(color: MyColors.grey),
            text: MyStrings.forgotYourPassword,
            onPressed: () {},
          ),
        ),
        Row(
          children: [
            Checkbox(
              value: widget.currentState.isEmailRememberMeChecked,
              onChanged: (value) {
                widget.cubit.toggleEmailRememberMe(
                  value ?? false,
                  emailController.text,
                  passwordController.text,
                );
              },
              activeColor: MyColors.red,
            ),
            Text(MyStrings.rememberMe),
          ],
        ),
        22.verticalSpace,
        CustomButton(
          onPressed: () {
            if (emailFormKey.currentState!.validate()) {
              if (widget.currentState.isEmailRememberMeChecked) {
                widget.cubit.saveEmailCredentials(
                  emailController.text,
                  passwordController.text,
                  true,
                );
              }
              final Map<String, dynamic> userData = {
                SharedKeys.email: emailController.text,
                SharedKeys.userEmail: emailController.text, // Add this
                SharedKeys.isRegisteredUser: true,
                SharedKeys.userFullName: emailController.text.split('@').first,
              };

              context.goNamed(
                MyRouts.home,
                extra: userData,
              );
            }
          },
          color: MyColors.red,
          text: MyStrings.signIn,
          textColor: MyColors.white,
          width: 0.w,
          borderColor: MyColors.red,
        ),
        16.verticalSpace,
        CustomButton(
          onPressed: () {
            widget.cubit.signUp();
            context.pushNamed(MyRouts.signUp);
          },
          color: MyColors.white,
          text: MyStrings.createAnAccount,
          textColor: Colors.black,
          width: 1.w,
          borderColor: Colors.black,
        ),
        16.verticalSpace,
        AuthTextButton(
          text: MyStrings.signInAsGuest,
          onPressed: () {},
          textStyle: TextStyle(
            fontSize: 20.sp,
            decoration: TextDecoration.underline,
            color: MyColors.grey,
            decorationColor: MyColors.grey,
          ),
        ),
      ],
    ),
  );

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }
}