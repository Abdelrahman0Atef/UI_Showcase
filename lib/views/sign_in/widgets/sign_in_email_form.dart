part of sign_in;

class SignInEmailFormWidget extends StatefulWidget {
  final SignInInitial currentState;
  final SignInCubit cubit;

  const SignInEmailFormWidget({
    super.key,
    required this.currentState,
    required this.cubit,
  });

  @override
  State<SignInEmailFormWidget> createState() => _SignInEmailFormWidgetState();
}

class _SignInEmailFormWidgetState extends State<SignInEmailFormWidget> {
  final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode userNameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _loadCredentialsFromState();
  }

  @override
  void didUpdateWidget(covariant SignInEmailFormWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentState != oldWidget.currentState) {
      _loadCredentialsFromState();
    }
  }

  void _loadCredentialsFromState() {
    if (userNameController.text.isEmpty &&
        widget.currentState.savedEmail.isNotEmpty) {
      userNameController.text = widget.currentState.savedEmail;
    }
    if (passwordController.text.isEmpty &&
        widget.currentState.savedPassword.isNotEmpty) {
      passwordController.text = widget.currentState.savedPassword;
    }
  }

  void _closeKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: emailFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          16.verticalSpace,
          CustomTextFieldWithTitle(
            label: MyStrings.kUserName,
            validator: (value) => ValidationHelper.validateEmail(value as String?),
            focusNode: userNameFocusNode,
            controller: userNameController,
            onSubmitted: (_) {
              userNameFocusNode.unfocus();
              passwordFocusNode.requestFocus();
            },
          ),
          24.verticalSpace,
          CustomTextFieldWithTitle(
            label: MyStrings.kPassword,
            obscureText: !widget.currentState.passwordVisible,
            isPasswordVisible: widget.currentState.passwordVisible,
            onIconPressed: widget.cubit.togglePasswordVisibility,
            validator: (value) => ValidationHelper.validatePassword(value as String?),
            focusNode: passwordFocusNode,
            controller: passwordController,
            isLastField: true,
          ),
          8.verticalSpace,
          Row(
            children: [
              Checkbox(
                value: widget.currentState.isEmailRememberMeChecked,
                onChanged: (value) {
                  widget.cubit.toggleEmailRememberMe(
                    value ?? false,
                    userNameController.text,
                    passwordController.text,
                  );
                  if (value == true) {
                    widget.cubit.saveEmailCredentials(
                      userNameController.text,
                      passwordController.text,
                      true,
                    );
                  }
                },
                activeColor: Colors.red,
              ),
              const Text(MyStrings.kRememberMe),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: AuthTextButton(
              textStyle: const TextStyle(color: Colors.grey),
              text: MyStrings.kForgetPassword,
              onPressed: () {},
            ),
          ),
          22.verticalSpace,
          CustomButton(
            onPressed: () {
              _closeKeyboard();
              if (emailFormKey.currentState!.validate()) {
                widget.cubit.validateEmailSignIn(
                  formKey: emailFormKey,
                  email: userNameController.text,
                  password: passwordController.text,
                  emailFocusNode: userNameFocusNode,
                  passwordFocusNode: passwordFocusNode,
                  rememberMe: widget.currentState.isEmailRememberMeChecked,
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeView()),
                );
              }
            },
            color: Colors.red,
            text: MyStrings.kSignIn,
            textColor: Colors.white,
            width: 0.w,
            borderColor: Colors.red,
          ),
          16.verticalSpace,
          CustomButton(
            onPressed: () {
              widget.cubit.signUp();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUpView()),
              );
            },
            color: Colors.white,
            text: MyStrings.kCreateAccount,
            textColor: Colors.black,
            width: 1.w,
            borderColor: Colors.black,
          ),
          16.verticalSpace,
          AuthTextButton(
            text: MyStrings.kGuest,
            onPressed: () {},
            textStyle: TextStyle(
              fontSize: 20.sp,
              decoration: TextDecoration.underline,
              color: Colors.grey,
              decorationColor: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    userNameFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }
}