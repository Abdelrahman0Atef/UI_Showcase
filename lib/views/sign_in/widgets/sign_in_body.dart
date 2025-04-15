part of '../sign_in_imports.dart';

class SignInBody extends StatefulWidget {
  const SignInBody({
    required this.currentState, required this.cubit, super.key,
  });

  final SignInInitial currentState;
  final SignInCubit cubit;

  @override
  SignInBodyState createState() => SignInBodyState();
}

class SignInBodyState extends State<SignInBody> {
  @override
  Widget build(BuildContext context) => Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: AnimatedCrossFade(
        firstChild: SignInPhoneFormWidget(
          currentState: widget.currentState,
          cubit: widget.cubit,
        ),
        secondChild: SignInEmailFormWidget(
          currentState: widget.currentState,
          cubit: widget.cubit,
        ),
        crossFadeState: widget.currentState.selectedIndex == 0
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 10),
      ),
    );
}