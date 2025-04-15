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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 7.w,
                height: 7.h,
                margin: const EdgeInsets.symmetric(horizontal: 8).w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: hasCapitalLetter ? Colors.green : Colors.grey,
                ),
              ),
              CustomText(
                text: LocaleKeys.Auth_atLeastItContainsCapitalLetter.tr(),
                textStyle: TextStyle(
                  color: hasCapitalLetter ? Colors.green : Colors.black,
                ),
              ),

            ],
          ),
          16.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 7.w,
                height: 7.h,
                margin: const EdgeInsets.symmetric(horizontal: 8).w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: hasNumber ? Colors.green : Colors.grey,
                ),
              ),
              CustomText(
                text: LocaleKeys.Auth_atLeastItContainsOneNumber.tr(),
                textStyle: TextStyle(
                  color: hasNumber ? Colors.green : Colors.black,
                ),
              ),

            ],
          ),
          16.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 7.w,
                height: 7.h,
                margin: const EdgeInsets.symmetric(horizontal: 8).w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: hasValidLength ? Colors.green : Colors.grey,
                ),
              ),
              CustomText(
                text: LocaleKeys.Auth_atLeast8Letters.tr(),
                textStyle: TextStyle(
                  color: hasValidLength ? Colors.green : Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
