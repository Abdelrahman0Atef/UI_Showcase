import 'package:untitled/core/constants/imports.dart';

class UserNameSignIn extends StatelessWidget {
  const UserNameSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.read<SignInCubit>();
        final currentState = state is SignInInitial ? state : const SignInInitial(1, false);

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const CustomStack(),
                20.verticalSpace,
                CustomToggleButton(currentState: currentState, cubit: cubit),
              ],
            ),
          ),
        );
      },
    );
  }
}