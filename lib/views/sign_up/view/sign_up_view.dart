part of '../sign_up_imports.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  SignUpViewState createState() => SignUpViewState();
}

class SignUpViewState extends State<SignUpView> {
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
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => SignUpCubit(),
    child: BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpFailure) {
          if (firstNameController.text.isNotEmpty &&
              ValidationHelper.validateName(firstNameController.text) !=
                  null) {
            firstNameFocusNode.requestFocus();
          } else if (lastNameController.text.isNotEmpty &&
              ValidationHelper.validateName(lastNameController.text) !=
                  null) {
            lastNameFocusNode.requestFocus();
          } else if (phoneController.text.isNotEmpty &&
              ValidationHelper.validatePhone(phoneController.text) != null) {
            phoneFocusNode.requestFocus();
          } else if (emailController.text.isNotEmpty &&
              ValidationHelper.validateEmail(emailController.text) != null) {
            emailFocusNode.requestFocus();
          } else if (passwordController.text.isNotEmpty &&
              ValidationHelper.validatePassword(passwordController.text) !=
                  null) {
            passwordFocusNode.requestFocus();
          }
        } else if (state is SignUpSuccess) {
          final Map<String, dynamic> userData = {
            SharedKeys.isRegisteredUser: true,
            SharedKeys.userFullName: '${firstNameController.text} ${lastNameController.text}',
            SharedKeys.email: emailController.text,
            SharedKeys.phone: phoneController.text,
            SharedKeys.userEmail: emailController.text,
            SharedKeys.userPhone: phoneController.text,
          };

          context.goNamed(
            MyRouts.home,
            extra: userData,
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<SignUpCubit>();
        final currentState =
        state is SignUpInitial ? state : const SignUpInitial();

        return Scaffold(
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const AuthCustomStack(),
                  20.verticalSpace,
                  SignUpFields(
                    currentState: currentState,
                    cubit: cubit,
                    firstNameFocusNode: firstNameFocusNode,
                    lastNameFocusNode: lastNameFocusNode,
                    phoneFocusNode: phoneFocusNode,
                    emailFocusNode: emailFocusNode,
                    passwordFocusNode: passwordFocusNode,
                    firstNameController: firstNameController,
                    lastNameController: lastNameController,
                    phoneController: phoneController,
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
                  16.verticalSpace,
                  SignUpValidationPassword(
                    hasCapitalLetter: currentState.hasCapitalLetter,
                    hasNumber: currentState.hasNumber,
                    hasValidLength: currentState.hasValidLength,
                  ),
                  32.verticalSpace,
                  SignUpButtons(
                    currentState: currentState,
                    cubit: cubit,
                    formKey: formKey,
                    firstNameController: firstNameController,
                    lastNameController: lastNameController,
                    phoneController: phoneController,
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}