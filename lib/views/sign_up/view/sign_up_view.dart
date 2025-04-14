part of sign_up;

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

  void showSnackBar(String message, {Color backgroundColor = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
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
            showSnackBar(MyStrings.kDataValidation);
          } else if (state is SignUpSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeView()),
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
                    Center(
                      child: CustomButton(
                        onPressed:
                        currentState.isPasswordValid
                            ? () {
                          closeKeyboard();
                          cubit.validateAndProceed(
                            formKey: formKey,
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            phone: phoneController.text,
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        }
                            : () {},
                        text: MyStrings.kCreateAccount,
                        textColor: Colors.white,
                        color:
                        currentState.isPasswordValid
                            ? Colors.red
                            : Colors.grey,
                        width: 0.w,
                        borderColor:
                        currentState.isPasswordValid
                            ? Colors.red
                            : Colors.grey,
                      ),
                    ),
                    8.verticalSpace,
                    Center(
                      child: AuthTextButton(
                        text: MyStrings.kUserNameSignIn,
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SigInView(),
                            ),
                          );
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
      ),
    );
  }
}