part of '../sign_in_imports.dart';

class SigInView extends StatefulWidget {
  const SigInView({super.key});

  @override
  State<SigInView> createState() => _SigInViewState();
}

class _SigInViewState extends State<SigInView> {
  final SignInViewModel vm = SignInViewModel();

  @override
  void initState() {
    super.initState();
    vm._initLoadCredential();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<GenericCubit<String?>, GenericState<String?>>(
        bloc: vm._statusMessageCubit,
        builder:
            (context, state) => Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const AuthCustomStack(),
                    20.verticalSpace,
                    SignInToggleButton(
                      viewModel: vm,
                    ),
                  ],
                ),
              ),
            ),
      );
}
