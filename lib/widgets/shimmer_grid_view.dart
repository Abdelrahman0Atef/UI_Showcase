part of '../widgets/widgets_imports.dart';

class ShimmerProductGrid extends StatelessWidget {
  const ShimmerProductGrid({this.height, Key? key}) : super(key: key);
  final double? height;

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.all(12.r),
      child: SizedBox(
        height: height ?? 322.h,
        child: GridView.builder(
          itemCount: 6,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: height ?? 322.h,
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 10.h,
          ),
          itemBuilder: (context, index) => Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
        ),
      ),
    );
}
