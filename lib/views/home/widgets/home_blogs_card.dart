part of '../home_imports.dart';

class HomeBlogsCard extends StatelessWidget {
  final String featureImage;
  final String creationTime;
  final String title;
  final String shortContent;

  const HomeBlogsCard({
    required this.featureImage,
    required this.creationTime,
    required this.title,
    required this.shortContent,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
    width: 0.7.sw,
    //height: 375.h,
    margin: EdgeInsets.all(16.r),
    decoration: BoxDecoration(
      color: MyColors.white,
      borderRadius: BorderRadius.circular(16.r),
      boxShadow: [
        BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10.r),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.network(
              featureImage,
              fit: BoxFit.fill,
              width: double.infinity.w,
              height: 170.h,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal:  16.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: '${MyStrings.postedOn} ${creationTime}',
                  textStyle: TextStyle(fontSize: 12.sp, color: MyColors.grey),
                ),
                5.verticalSpace,
                CustomText(
                  text: title,
                  textStyle: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
                10.verticalSpace,
                CustomText(
                  text: shortContent,
                  textStyle: TextStyle(fontSize: 12.sp, color: Colors.black87),
                  textAlign: TextAlign.start,
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
