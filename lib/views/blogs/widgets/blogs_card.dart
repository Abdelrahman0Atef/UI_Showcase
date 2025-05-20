part of '../blogs.imports.dart';

class BlogsCard extends StatelessWidget {
  final String featureImage;
  final String creationTime;
  final String title;
  final String shortContent;

  const BlogsCard({
    required this.featureImage,
    required this.creationTime,
    required this.title,
    required this.shortContent,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.all(16.r),
    padding: EdgeInsets.all(16.r),
    decoration: BoxDecoration(
      color: MyColors.white,
      borderRadius: BorderRadius.circular(12.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 10.r,
          spreadRadius: 5.r,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.network(featureImage),
        ),
        8.verticalSpace,
        CustomText(
          text: title,
          textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        8.verticalSpace,
        CustomText(
          text: '${MyStrings.postedOn} ${creationTime}',
          textStyle: TextStyle(fontSize: 14.sp, color: MyColors.grey),
        ),
        12.verticalSpace,
        CustomText(
          text: shortContent,
          textStyle: TextStyle(fontSize: 16.sp, color: Colors.black87),
          textAlign: TextAlign.start,
          maxLines: 3,
        ),
      ],
    ),
  );
}
