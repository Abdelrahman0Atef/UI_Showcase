part of '../sign_in_imports.dart';

class SignInToggleButton extends StatelessWidget {
  final SignInInitial currentState;
  final SignInCubit cubit;
  const SignInToggleButton({
    required this.currentState,
    required this.cubit,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Container(
        padding: EdgeInsets.all(2.w),
        width: 275.w,
        height: 48.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          color: MyColors.white,
          boxShadow: [
            BoxShadow(
              color: MyColors.darkYellow,
              offset: const Offset(0, 1),
              blurRadius: 8.r,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            signInToggleButton(
              index: 1,
              text: MyStrings.signIn,
            ),
            signInToggleButton(
              index: 0,
              text: MyStrings.signInWithPhoneNumber,
            ),
          ],
        ),
      ),
      16.verticalSpace,
      SignInBody(currentState: currentState, cubit: cubit),
    ],
  );

  Widget signInToggleButton({required int index, required String text}) => GestureDetector(
      onTap: () {
        cubit.toggleSignInMethod(index);
      },
      child: Container(
        width: 135.w,
        height: 48.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          color: currentState.selectedIndex == index ? MyColors.red : MyColors.white,
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          child: CustomText(
            text: text,
            textStyle: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: currentState.selectedIndex == index ? MyColors.white: MyColors.black,
              overflow: TextOverflow.visible,
            ),
          ),
        ),
      ),
    );
}