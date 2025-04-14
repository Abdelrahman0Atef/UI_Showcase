part of '../sign_up_imports.dart';

class SignUpValidationPassword extends StatelessWidget {
  final bool hasCapitalLetter;
  final bool hasNumber;
  final bool hasValidLength;

  const SignUpValidationPassword({
    super.key,
    required this.hasCapitalLetter,
    required this.hasNumber,
    required this.hasValidLength,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.r),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomText(
                text: MyStrings.passwordHaveCapitalLetter,
                textStyle: TextStyle(
                  color: hasCapitalLetter ? Colors.green : Colors.black,
                ),
              ),
              Container(
                width: 7.w,
                height: 7.h,
                margin: const EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: hasCapitalLetter ? Colors.green : Colors.grey,
                ),
              ),
            ],
          ),
          16.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomText(
                text: MyStrings.passwordHaveNumber,
                textStyle: TextStyle(
                  color: hasNumber ? Colors.green : Colors.black,
                ),
              ),
              Container(
                width: 7.w,
                height: 7.h,
                margin: const EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: hasNumber ? Colors.green : Colors.grey,
                ),
              ),
            ],
          ),
          16.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomText(
                text: MyStrings.passwordLength,
                textStyle: TextStyle(
                  color: hasValidLength ? Colors.green : Colors.black,
                ),
              ),
              Container(
                width: 7.w,
                height: 7.h,
                margin: const EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: hasValidLength ? Colors.green : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
