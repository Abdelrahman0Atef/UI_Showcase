part of '../home_imports.dart';

class HomeSplitCard extends StatelessWidget {
  const HomeSplitCard({
    required this.text,
    required this.image,
    required this.color,
    super.key,
  });

  final String text;
  final String image;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.symmetric(horizontal: 15.w),
    padding: EdgeInsets.symmetric(horizontal: 15.w),
    width: 248.w,
    height: 100.h,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20.r),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(image, width: 81.w, height: 100.h, fit: BoxFit.fill),
        25.horizontalSpace,
        Expanded(
          child: CustomText(
            text: text,
            textStyle: TextStyle(
              color: MyColors.grey,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
