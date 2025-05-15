part of '../sign_up_imports.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  SignUpViewState createState() => SignUpViewState();
}

class SignUpViewState extends State<SignUpView> {
  final formKey = GlobalKey<FormState>();
  late SignUpViewModel vm = SignUpViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    vm._dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider<GenericCubit<bool>>.value(value: vm._passwordVisibleCubit),
      BlocProvider<GenericCubit<bool>>.value(value: vm._hasCapitalLetterCubit),
      BlocProvider<GenericCubit<bool>>.value(value: vm._hasNumberCubit),
      BlocProvider<GenericCubit<bool>>.value(value: vm._hasValidLengthCubit),
      BlocProvider<GenericCubit<String?>>.value(value: vm._statusMessageCubit),
    ],
    child: BlocConsumer<GenericCubit<String?>, GenericState<String?>>(
      bloc: vm._statusMessageCubit,
      listener: (context, state) {
        if (state is GenericUpdateState) {
          if (vm._firstNameController.text.isNotEmpty &&
              ValidationHelper.validateName(vm._firstNameController.text) !=
                  null) {
            vm._firstNameFocusNode.requestFocus();
          } else if (vm._lastNameController.text.isNotEmpty &&
              ValidationHelper.validateName(vm._lastNameController.text) !=
                  null) {
            vm._lastNameFocusNode.requestFocus();
          } else if (vm._phoneController.text.isNotEmpty &&
              ValidationHelper.validatePhone(vm._phoneController.text) !=
                  null) {
            vm._phoneFocusNode.requestFocus();
          } else if (vm._emailController.text.isNotEmpty &&
              ValidationHelper.validateEmail(vm._emailController.text) !=
                  null) {
            vm._emailFocusNode.requestFocus();
          } else if (vm._passwordController.text.isNotEmpty &&
              ValidationHelper.validatePassword(vm._passwordController.text) !=
                  null) {
            vm._passwordFocusNode.requestFocus();
          }
        }
      },
      builder:
          (context, state) => Scaffold(
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const AuthCustomStack(),
                    20.verticalSpace,
                    SignUpFields(
                      viewModel: vm,
                      firstNameFocusNode: vm._firstNameFocusNode,
                      lastNameFocusNode: vm._lastNameFocusNode,
                      phoneFocusNode: vm._phoneFocusNode,
                      emailFocusNode: vm._emailFocusNode,
                      passwordFocusNode: vm._passwordFocusNode,
                      firstNameController: vm._firstNameController,
                      lastNameController: vm._lastNameController,
                      phoneController: vm._phoneController,
                      emailController: vm._emailController,
                      passwordController: vm._passwordController,
                    ),
                    16.verticalSpace,
                    BlocBuilder<GenericCubit<bool>, GenericState<bool>>(
                      bloc: vm._hasCapitalLetterCubit,
                      builder:
                          (context, capitalState) => BlocBuilder<
                            GenericCubit<bool>,
                            GenericState<bool>
                          >(
                            bloc: vm._hasNumberCubit,
                            builder:
                                (context, numberState) => BlocBuilder<
                                  GenericCubit<bool>,
                                  GenericState<bool>
                                >(
                                  bloc: vm._hasValidLengthCubit,
                                  builder:
                                      (
                                        context,
                                        lengthState,
                                      ) => SignUpValidationPassword(
                                        hasCapitalLetter:
                                            capitalState is GenericUpdateState
                                                ? capitalState.data
                                                : false,
                                        hasNumber:
                                            numberState is GenericUpdateState
                                                ? numberState.data
                                                : false,
                                        hasValidLength:
                                            lengthState is GenericUpdateState
                                                ? lengthState.data
                                                : false,
                                      ),
                                ),
                          ),
                    ),
                    32.verticalSpace,
                    BlocBuilder<GenericCubit<bool>, GenericState<bool>>(
                      bloc: vm._hasValidLengthCubit,
                      builder:
                          (context, state) =>
                              SignUpButtons(viewModel: vm, formKey: formKey),
                    ),
                  ],
                ),
              ),
            ),
          ),
    ),
  );
}
