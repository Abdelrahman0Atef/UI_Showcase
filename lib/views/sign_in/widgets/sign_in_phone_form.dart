part of '../sign_in_imports.dart';

class SignInPhoneFormWidget extends StatefulWidget {
  final SignInViewModel viewModel;

  const SignInPhoneFormWidget({required this.viewModel, super.key});

  @override
  State<SignInPhoneFormWidget> createState() => _SignInPhoneFormWidgetState();
}

class _SignInPhoneFormWidgetState extends State<SignInPhoneFormWidget> {
  final GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final FocusNode phoneFocusNode = FocusNode();

  bool isRememberMeChecked = false;

  @override
  void initState() {
    super.initState();
    final storageService = getIt<LocalStorageService>();
    isRememberMeChecked =
        storageService.getIsChecked(SharedKeys.phoneRememberMe) ?? false;
    final savedPhone = storageService.getString(SharedKeys.phone) ?? '';
    phoneController.text = savedPhone;
  }

  @override
  void dispose() {
    phoneController.dispose();
    phoneFocusNode.dispose();
    super.dispose();
  }

  void _closeKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) => Form(
    key: phoneFormKey,
    child: Column(
      children: [
        16.verticalSpace,
        CustomTextFieldWithTitle(
          isPhoneField: true,
          label: MyStrings.phoneNumber,
          keyboardType: TextInputType.phone,
          validator:
              (value) => ValidationHelper.validatePhone(value as String?),
          focusNode: phoneFocusNode,
          controller: phoneController,
          isLastField: true,
        ),
        8.verticalSpace,
        Row(
          children: [
            Checkbox(
              value: isRememberMeChecked,
              onChanged: (value) {
                setState(() {
                  isRememberMeChecked = value ?? false;
                });
                widget.viewModel._togglePhoneRememberMe(
                  isRememberMeChecked,
                  phoneController.text,
                );
                if (isRememberMeChecked) {
                  final storageService = getIt<LocalStorageService>();
                  storageService.setIsChecked(
                    SharedKeys.isRegisteredUser,
                    true,
                  );
                }
              },
              activeColor: MyColors.red,
            ),
            Text(MyStrings.rememberMe),
          ],
        ),
        62.verticalSpace,
        CustomButton(
          onPressed: () {
            _closeKeyboard();
            if (phoneController.text.isNotEmpty) {
              widget.viewModel._validatePhoneSignIn(
                formKey: phoneFormKey,
                phone: phoneController.text,
                phoneFocusNode: phoneFocusNode,
                rememberMe: isRememberMeChecked,
              );

              final storageService = getIt<LocalStorageService>();
              storageService.setIsChecked(SharedKeys.isRegisteredUser, true);

              context.goNamed(
                MyRouts.home,
                extra: {
                  SharedKeys.phone: phoneController.text,
                  SharedKeys.isRegisteredUser: true,
                },
              );
            }
          },
          color: MyColors.red,
          text: MyStrings.sendConfirmationCode,
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
}
