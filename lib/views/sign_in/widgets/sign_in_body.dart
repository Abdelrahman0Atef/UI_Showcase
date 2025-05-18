part of '../sign_in_imports.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({
    required this.selectedIndex,
    required this.vm,
    super.key,
  });

  final int selectedIndex;
  final SignInViewModel vm;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 24.w),
    child: AnimatedCrossFade(
      firstChild: SignInPhoneFormWidget(vm: vm),
      secondChild: SignInEmailFormWidget(vm: vm),
      crossFadeState:
          selectedIndex == 0
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 10),
    ),
  );
}
