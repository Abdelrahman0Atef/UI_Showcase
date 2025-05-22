part of '../home_imports.dart';

class HomeInfoCard extends StatelessWidget {
  const HomeInfoCard({
    required this.image,
    required this.title,
    required this.subTitle,
     this.onTap, super.key,
  });

  final String image;
  final String title;
  final String subTitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        color: MyColors.white,
        boxShadow: [
          BoxShadow(blurRadius: 8.r, color: MyColors.black.withValues(alpha: 0.1)),
        ],
      ),
      child: Column(
        children: [
          16.verticalSpace,
          Image.asset(image),
          16.verticalSpace,
          CustomText(
            text: title,
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
              color: MyColors.navy,
            ),
          ),
          8.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 35.r),
            child: CustomText(
              text: subTitle,
              textStyle: TextStyle(fontSize: 10.sp, color: MyColors.grey),
              maxLines: 3,
            ),
          ),
        ],
      ),
    ),
  );
}
