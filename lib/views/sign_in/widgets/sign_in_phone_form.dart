part of '../sign_in_imports.dart';

class SignInPhoneFormWidget extends StatefulWidget {
  final SignInInitial currentState;
  final SignInCubit cubit;

  const SignInPhoneFormWidget({
    super.key,
    required this.currentState,
    required this.cubit,
  });

  @override
  State<SignInPhoneFormWidget> createState() => _SignInPhoneFormWidgetState();
}

class _SignInPhoneFormWidgetState extends State<SignInPhoneFormWidget> {
  late final SignInCubit _cubit;
  final GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final FocusNode phoneFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _cubit = getIt<SignInCubit>();
    _loadCredentialsFromState();
  }

  @override
  void didUpdateWidget(covariant SignInPhoneFormWidget oldWidget) {
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
  }

  void _closeKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: phoneFormKey,
      child: Column(
        children: [
          16.verticalSpace,
          CustomTextFieldWithTitle(
            label: MyStrings.phoneNumber,
            keyboardType: TextInputType.phone,
            validator: (value) =>
                ValidationHelper.validatePhone(value as String?),
            focusNode: phoneFocusNode,
            controller: phoneController,
            isLastField: true,
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
              const Text(MyStrings.rememberMe),
            ],
          ),
          62.verticalSpace,
          CustomButton(
            onPressed: () {
              _closeKeyboard();
              if (phoneFormKey.currentState!.validate()) {
                widget.cubit.validatePhoneSignIn(
                  formKey: phoneFormKey,
                  phone: phoneController.text,
                  phoneFocusNode: phoneFocusNode,
                  rememberMe: widget.currentState.isPhoneRememberMeChecked,
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeView()),
                );
              }
            },
            color: Colors.red,
            text: MyStrings.sendOTP,
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
            text: MyStrings.createAccount,
            textColor: Colors.black,
            width: 1.w,
            borderColor: Colors.black,
          ),
          16.verticalSpace,
          AuthTextButton(
            text: MyStrings.guest,
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
    phoneController.dispose();
    phoneFocusNode.dispose();
    super.dispose();
  }
}