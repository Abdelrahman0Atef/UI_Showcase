part of '../sign_in_imports.dart';

class SignInToggleButton extends StatelessWidget {
  final SignInViewModel vm;

  const SignInToggleButton({required this.vm, super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<GenericCubit<int>, GenericState<int>>(
        bloc: vm._signInMethodCubit,
        builder: (context, state) {
          final selectedIndex = state.data;
          return Column(
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
                      selectedIndex: selectedIndex,
                    ),
                    signInToggleButton(
                      index: 0,
                      text: MyStrings.signInWithPhoneNumber,
                      selectedIndex: selectedIndex,
                    ),
                  ],
                ),
              ),
              16.verticalSpace,
              SignInBody(selectedIndex: selectedIndex, vm: vm),
            ],
          );
        },
      );

  Widget signInToggleButton({
    required int index,
    required String text,
    required int selectedIndex,
  }) => GestureDetector(
    onTap: () {
      vm._toggleSignInMethod(index);
    },
    child: Container(
      width: 135.w,
      height: 48.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.r),
        color: selectedIndex == index ? MyColors.red : MyColors.white,
      ),
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        child: CustomText(
          text: text,
          textStyle: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: selectedIndex == index ? MyColors.white : MyColors.black,
            overflow: TextOverflow.visible,
          ),
        ),
      ),
    ),
  );
}
