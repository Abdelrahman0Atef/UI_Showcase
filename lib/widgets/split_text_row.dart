part of '../views/home/home_imports.dart';

class HomeSplitTextRow extends StatelessWidget {
  const HomeSplitTextRow({
    required this.label,
    this.color = MyColors.red,
    this.horizontalPadding = 30,
    super.key,
  });

  final String label;
  final double? horizontalPadding;
  final Color color;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: horizontalPadding!.r),
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
        CustomText(
          text: MyStrings.more,
          textStyle: TextStyle(
            color: color,
            decoration: TextDecoration.underline,
            decorationColor: color,
          ),
        ),
      ],
    ),
  );
}
