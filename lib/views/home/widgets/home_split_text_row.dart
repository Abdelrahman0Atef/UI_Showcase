part of '../home_imports.dart';

class HomeSplitTextRow extends StatelessWidget {
  const HomeSplitTextRow({
    required this.label, super.key,
  });
  final String label;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 30.r),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: label,
            textStyle: TextStyle(
              color: MyColors.navy,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const CustomText(
            text: MyStrings.more,
            textStyle: TextStyle(
              color: MyColors.red,
              decoration: TextDecoration.underline,
              decorationColor: MyColors.red,
            ),
          ),
        ],
      ),
  );
}
