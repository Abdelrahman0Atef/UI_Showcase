part of '../sign_in_imports.dart';

class SignInToggleButton extends StatelessWidget {
  final SignInInitial currentState;
  final SignInCubit cubit;

  const SignInToggleButton({required this.currentState, required this.cubit, super.key});

  @override
  Widget build(BuildContext context) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: MyColors.toggleShadow,
                offset: Offset(0, 1),
                blurRadius: 8.0,
              ),
            ],
          ),
          padding: const EdgeInsets.all(2.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  cubit.toggleSignInMethod(0);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    color: currentState.selectedIndex == 0 ? Colors.red : Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0).w,
                  child: CustomText(
                    text: LocaleKeys.Auth_signInWithPhoneNumber.tr(),
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: currentState.selectedIndex == 0 ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  cubit.toggleSignInMethod(1);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    color: currentState.selectedIndex == 1 ? Colors.red : Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: CustomText(
                    text: LocaleKeys.Auth_signIn.tr(),
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: currentState.selectedIndex == 1 ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        16.verticalSpace,
        SignInBody(currentState: currentState, cubit: cubit),
      ],
    );
}