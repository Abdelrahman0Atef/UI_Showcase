import 'package:untitled/core/constants/imports.dart';

class CustomValidationText extends StatelessWidget {
  const CustomValidationText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.r),
      child: Column(
        children: [
          CustomText(label: kPasswordHaveCapitalLetter, labelStyle: TextStyle(),),
          16.verticalSpace,
          CustomText(label: kPasswordHaveNumber, labelStyle: TextStyle()),
          16.verticalSpace,
          CustomText(label: kPasswordLength, labelStyle: TextStyle()),
        ],
      ),
    );
  }
}