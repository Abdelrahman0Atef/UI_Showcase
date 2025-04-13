import 'package:untitled/core/constants/imports.dart';

class CustomValidationText extends StatelessWidget {
  final bool hasCapitalLetter;
  final bool hasNumber;
  final bool hasValidLength;

  const CustomValidationText({
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomText(
            label: kPasswordHaveCapitalLetter,
            labelStyle: TextStyle(
              color: hasCapitalLetter ? Colors.green : Colors.black,
            ),
          ),
          16.verticalSpace,
          CustomText(
            label: kPasswordHaveNumber,
            labelStyle: TextStyle(
              color: hasNumber ? Colors.green : Colors.black,
            ),
          ),
          16.verticalSpace,
          CustomText(
            label: kPasswordLength,
            labelStyle: TextStyle(
              color: hasValidLength ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}