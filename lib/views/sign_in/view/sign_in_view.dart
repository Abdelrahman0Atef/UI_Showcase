part of sign_in;

class SigInView extends StatelessWidget {
  const SigInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(),
      child: BlocBuilder<SignInCubit, SignInState>(
        builder: (context, state) {
          final cubit = context.read<SignInCubit>();
          final currentState = state is SignInInitial ? state : const SignInInitial(1, false);
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const AuthCustomStack(),
                  20.verticalSpace,
                  SignInToggleButton(currentState: currentState, cubit: cubit),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}