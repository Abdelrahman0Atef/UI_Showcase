import 'package:untitled/core/constants/imports.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  _RegistrationViewState createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  final formKey = GlobalKey<FormState>();
  late FocusNode firstNameFocusNode;
  late FocusNode lastNameFocusNode;
  late FocusNode phoneFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    firstNameFocusNode = FocusNode();
    lastNameFocusNode = FocusNode();
    phoneFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    // مراقبة التغييرات في حقل الباسورد
    passwordController.addListener(() {
      context.read<RegistrationCubit>().updatePasswordValidation(passwordController.text);
    });
  }

  @override
  void dispose() {
    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    phoneFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void closeKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationCubit, RegistrationState>(
      listener: (context, state) {
        if (state is RegistrationFailure) {
          if (firstNameController.text.isNotEmpty && ValidationHelper.validateName(firstNameController.text) != null) {
            firstNameFocusNode.requestFocus();
          } else if (lastNameController.text.isNotEmpty && ValidationHelper.validateName(lastNameController.text) != null) {
            lastNameFocusNode.requestFocus();
          } else if (phoneController.text.isNotEmpty && ValidationHelper.validatePhone(phoneController.text) != null) {
            phoneFocusNode.requestFocus();
          } else if (emailController.text.isNotEmpty && ValidationHelper.validateEmail(emailController.text) != null) {
            emailFocusNode.requestFocus();
          } else if (passwordController.text.isNotEmpty && ValidationHelper.validatePassword(passwordController.text) != null) {
            passwordFocusNode.requestFocus();
          }
        }
      },
      builder: (context, state) {
        final cubit = context.read<RegistrationCubit>();
        final currentState = state is RegistrationInitial ? state : const RegistrationInitial();

        return Scaffold(
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const CustomStack(),
                  20.verticalSpace,
                  CustomTextFieldWithSection(
                    label: kFirstName,
                    validator: (value) => ValidationHelper.validateName(value as String?),
                    focusNode: firstNameFocusNode,
                    controller: firstNameController,
                    onSubmitted: (_) {
                      firstNameFocusNode.unfocus();
                      lastNameFocusNode.requestFocus();
                    },
                  ),
                  16.verticalSpace,
                  CustomTextFieldWithSection(
                    label: kLastName,
                    validator: (value) => ValidationHelper.validateName(value as String?),
                    focusNode: lastNameFocusNode,
                    controller: lastNameController,
                    onSubmitted: (_) {
                      lastNameFocusNode.unfocus();
                      phoneFocusNode.requestFocus();
                    },
                  ),
                  16.verticalSpace,
                  CustomTextFieldWithSection(
                    label: kPhone,
                    validator: (value) => ValidationHelper.validatePhone(value as String?),
                    focusNode: phoneFocusNode,
                    controller: phoneController,
                    onSubmitted: (_) {
                      phoneFocusNode.unfocus();
                      emailFocusNode.requestFocus();
                    },
                  ),
                  16.verticalSpace,
                  CustomTextFieldWithSection(
                    label: kEmail,
                    validator: (value) => ValidationHelper.validateEmail(value as String?),
                    focusNode: emailFocusNode,
                    controller: emailController,
                    onSubmitted: (_) {
                      emailFocusNode.unfocus();
                      passwordFocusNode.requestFocus();
                    },
                  ),
                  16.verticalSpace,
                  CustomTextFieldWithSection(
                    label: kPassword,
                    obscureText: !currentState.isPasswordVisible,
                    isPasswordVisible: currentState.isPasswordVisible,
                    onIconPressed: cubit.togglePasswordVisibility,
                    validator: (value) => ValidationHelper.validatePassword(value as String?),
                    focusNode: passwordFocusNode,
                    controller: passwordController,
                    onSubmitted: (_) {
                      closeKeyboard();
                    },
                  ),
                  16.verticalSpace,
                  CustomValidationText(
                    hasCapitalLetter: currentState.hasCapitalLetter,
                    hasNumber: currentState.hasNumber,
                    hasValidLength: currentState.hasValidLength,
                  ),
                  32.verticalSpace,
                  Center(
                    child: CustomButton(
                      onPressed: currentState.isPasswordValid
                          ? () {
                        closeKeyboard();
                        cubit.validateAndProceed(
                          formKey: formKey,
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          context: context,
                        );
                      }
                          : (){},
                      text: kCreateAccount,
                      textColor: Colors.white,
                      color: currentState.isPasswordValid ? Colors.red : Colors.grey,
                      width: 0.w,
                      borderColor: currentState.isPasswordValid ? Colors.red : Colors.grey,
                    ),
                  ),
                  8.verticalSpace,
                  Center(
                    child: CustomTextButton(
                      text: kUserNameLogIn,
                      onPressed: () {
                        cubit.logInNavigate(context: context);
                      },
                      textStyle: const TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}