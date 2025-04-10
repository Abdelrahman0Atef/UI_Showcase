import 'package:untitled/core/constants/imports.dart';

class SignInBody extends StatefulWidget {
  const SignInBody({
    super.key,
    required this.currentState,
    required this.cubit,
  });

  final SignInInitial currentState;
  final SignInCubit cubit;

  @override
  _SignInBodyState createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  final GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  late FocusNode phoneFocusNode;
  late FocusNode userNameFocusNode;
  late FocusNode passwordFocusNode;
  late TextEditingController phoneController;
  late TextEditingController userNameController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    phoneFocusNode = FocusNode();
    userNameFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    phoneController = TextEditingController();
    userNameController = TextEditingController();
    passwordController = TextEditingController();

    _loadCredentialsFromState();
  }

  @override
  void didUpdateWidget(covariant SignInBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentState != oldWidget.currentState) {
      _loadCredentialsFromState();
    }
  }

  void _loadCredentialsFromState() {
    if (phoneController.text.isEmpty &&
        widget.currentState.savedPhone.isNotEmpty) {
      phoneController.text = widget.currentState.savedPhone;
    }
    if (userNameController.text.isEmpty &&
        widget.currentState.savedEmail.isNotEmpty) {
      userNameController.text = widget.currentState.savedEmail;
    }
    if (passwordController.text.isEmpty &&
        widget.currentState.savedPassword.isNotEmpty) {
      passwordController.text = widget.currentState.savedPassword;
    }
  }

  @override
  void dispose() {
    phoneFocusNode.dispose();
    userNameFocusNode.dispose();
    passwordFocusNode.dispose();
    phoneController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _closeKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: AnimatedCrossFade(
        firstChild: Form(
          key: phoneFormKey,
          child: Column(
            children: [
              16.verticalSpace,
              CustomTextFieldWithSection(
                label: kPhoneNumber,
                keyboardType: TextInputType.phone,
                validator:
                    (value) => ValidationHelper.validatePhone(value as String?),
                focusNode: phoneFocusNode,
                controller: phoneController,
              ),
              8.verticalSpace,
              Row(
                children: [
                  Checkbox(
                    value: widget.currentState.isPhoneRememberMeChecked,
                    onChanged: (value) {
                      widget.cubit.togglePhoneRememberMe(
                        value ?? false,
                        phoneController.text,
                      );
                      if (value == true) {
                        widget.cubit.savePhoneCredentials(
                          phoneController.text,
                          true,
                        );
                      }
                    },
                    activeColor: Colors.red,
                  ),
                  const Text(kRememberMe),
                ],
              ),
              62.verticalSpace,
              CustomButton(
                onPressed: () {
                  _closeKeyboard();
                  widget.cubit.validatePhoneLogin(
                    formKey: phoneFormKey,
                    phone: phoneController.text,
                    context: context,
                    phoneFocusNode: phoneFocusNode,
                  );
                },
                color: Colors.red,
                text: kSendOTP,
                textColor: Colors.white,
                width: 0.w,
                borderColor: Colors.red,
              ),
              16.verticalSpace,
              CustomButton(
                onPressed: () {
                  widget.cubit.registrationNavigate(context: context);
                },
                color: Colors.white,
                text: kCreateAccount,
                textColor: Colors.black,
                width: 1.sp,
                borderColor: Colors.black,
              ),
              16.verticalSpace,
              CustomTextButton(
                text: kGuest,
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
        ),
        secondChild: Form(
          key: emailFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              16.verticalSpace,
              CustomTextFieldWithSection(
                label: kUserName,
                validator:
                    (value) => ValidationHelper.validateEmail(value as String?),
                focusNode: userNameFocusNode,
                controller: userNameController,
                onSubmitted: (_) {
                  userNameFocusNode.unfocus();
                  passwordFocusNode.requestFocus();
                },
              ),
              24.verticalSpace,
              CustomTextFieldWithSection(
                label: kPassword,
                obscureText: !widget.currentState.passwordVisible,
                isPasswordVisible: widget.currentState.passwordVisible,
                onIconPressed: widget.cubit.togglePasswordVisibility,
                validator:
                    (value) =>
                        ValidationHelper.validatePassword(value as String?),
                focusNode: passwordFocusNode,
                controller: passwordController,
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
                  const Text(kRememberMe),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: CustomTextButton(
                  textStyle: const TextStyle(color: Colors.grey),
                  text: kForgetPassword,
                  onPressed: () {},
                ),
              ),
              22.verticalSpace,
              CustomButton(
                onPressed: () {
                  _closeKeyboard();
                  widget.cubit.validateEmailLogin(
                    formKey: emailFormKey,
                    email: userNameController.text,
                    password: passwordController.text,
                    context: context,
                    emailFocusNode: userNameFocusNode,
                    passwordFocusNode: passwordFocusNode,
                    rememberMe: widget.currentState.isEmailRememberMeChecked,
                  );
                },
                color: Colors.red,
                text: kLogIn,
                textColor: Colors.white,
                width: 0.w,
                borderColor: Colors.red,
              ),
              16.verticalSpace,
              CustomButton(
                onPressed: () {
                  widget.cubit.registrationNavigate(context: context);
                },
                color: Colors.white,
                text: kCreateAccount,
                textColor: Colors.black,
                width: 1.w,
                borderColor: Colors.black,
              ),
              16.verticalSpace,
              CustomTextButton(
                text: kGuest,
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
        ),
        crossFadeState:
            widget.currentState.selectedIndex == 0
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }
}
