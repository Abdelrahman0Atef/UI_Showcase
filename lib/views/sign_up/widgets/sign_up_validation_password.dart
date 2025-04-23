part of '../sign_up_imports.dart';

class SignUpValidationPassword extends StatelessWidget {
  final bool hasCapitalLetter;
  final bool hasNumber;
  final bool hasValidLength;

  const SignUpValidationPassword({
    required this.hasCapitalLetter, required this.hasNumber, required this.hasValidLength, super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 7.w,
                height: 7.h,
                margin: const EdgeInsets.symmetric(horizontal: 8).w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: hasCapitalLetter ? MyColors.green : MyColors.grey,
                ),
              ),
              CustomText(
                text: MyStrings.atLeastItContainsCapitalLetter,
                textStyle: TextStyle(
                  color: hasCapitalLetter ? MyColors.green : MyColors.black,
                ),
              ),

            ],
          ),
          16.verticalSpace,
          Row(
            children: [
              Container(
                width: 7.w,
                height: 7.h,
                margin: const EdgeInsets.symmetric(horizontal: 8).w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: hasNumber ? MyColors.green : MyColors.grey,
                ),
              ),
              CustomText(
                text: MyStrings.atLeastItContainsOneNumber,
                textStyle: TextStyle(
                  color: hasNumber ? MyColors.green : MyColors.black,
                ),
              ),

            ],
          ),
          16.verticalSpace,
          Row(
            children: [
              Container(
                width: 7.w,
                height: 7.h,
                margin: const EdgeInsets.symmetric(horizontal: 8).w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: hasValidLength ? MyColors.green : MyColors.grey,
                ),
              ),
              CustomText(
                text: MyStrings.atLeast8Letters,
                textStyle: TextStyle(
                  color: hasValidLength ? MyColors.green : MyColors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
}
