part of '../sign_in_imports.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({
    required this.selectedIndex,
    required this.viewModel,
    super.key,
  });

  final int selectedIndex;
  final SignInViewModel viewModel;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 24.w),
    child: AnimatedCrossFade(
      firstChild: SignInPhoneFormWidget(viewModel: viewModel),
      secondChild: SignInEmailFormWidget(viewModel: viewModel),
      crossFadeState:
          selectedIndex == 0
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 10),
    ),
  );
}
