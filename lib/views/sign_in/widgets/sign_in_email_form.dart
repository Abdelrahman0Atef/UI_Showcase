part of '../sign_in_imports.dart';

class SignInEmailFormWidget extends StatefulWidget {
  final SignInViewModel viewModel;

  const SignInEmailFormWidget({required this.viewModel, super.key});

  @override
  State<SignInEmailFormWidget> createState() => _SignInEmailFormWidgetState();
}

class _SignInEmailFormWidgetState extends State<SignInEmailFormWidget> {
  final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  bool isRememberMeChecked = false;
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    final storageService = getIt<LocalStorageService>();
    isRememberMeChecked =
        storageService.getIsChecked(SharedKeys.emailRememberMe) ?? false;

    emailController.text = storageService.getString(SharedKeys.email) ?? '';
    passwordController.text =
        storageService.getString(SharedKeys.password) ?? '';

    passwordVisible = widget.viewModel._isPasswordVisible;
  }

  void _togglePasswordVisibility() {
    setState(() {
      passwordVisible = !passwordVisible;
      widget.viewModel._togglePasswordVisibility();
    });
  }

  @override
  Widget build(BuildContext context) => Form(
    key: emailFormKey,
    child: Column(
      children: [
        16.verticalSpace,
        CustomTextFieldWithTitle(
          label: MyStrings.email,
          validator:
              (value) => ValidationHelper.validateEmail(value as String?),
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
          obscureText: !passwordVisible,
          isPasswordVisible: passwordVisible,
          onIconPressed: _togglePasswordVisibility,
          validator:
              (value) => ValidationHelper.validatePassword(value as String?),
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
              value: isRememberMeChecked,
              onChanged: (value) {
                setState(() {
                  isRememberMeChecked = value ?? false;
                });
                widget.viewModel._toggleEmailRememberMe(
                  isRememberMeChecked,
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
            if (emailController.text.isNotEmpty &&
                passwordController.text.isNotEmpty) {
              widget.viewModel._validateEmailSignIn(
                formKey: emailFormKey,
                email: emailController.text,
                password: passwordController.text,
                emailFocusNode: emailFocusNode,
                passwordFocusNode: passwordFocusNode,
                rememberMe: isRememberMeChecked,
              );

              final storageService = getIt<LocalStorageService>();
              storageService.setIsChecked(SharedKeys.isRegisteredUser, true);

              context.goNamed(MyRouts.home);
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
            widget.viewModel._signUp();
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
