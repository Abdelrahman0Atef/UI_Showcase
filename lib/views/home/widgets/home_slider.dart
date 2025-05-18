part of '../home_imports.dart';

class CustomImageSlider extends StatelessWidget {
  final List<String> imageUrls;
  final HomeViewModel vm;

  const CustomImageSlider({
    required this.imageUrls,
    required this.vm,
    super.key,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 220.h,
    width: 342.w,
    child: Stack(
      children: [
        PageView.builder(
          controller: vm._pageController,
          itemCount: imageUrls.length,
          onPageChanged: vm.changePage,
          itemBuilder:
              (_, index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 10.r, vertical: 20.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  image: DecorationImage(
                    image: AssetImage(imageUrls[index]),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 25.h),
            child: BlocBuilder<GenericCubit<int>, GenericState<int>>(
              bloc: vm._pageCubit,
              builder:
                  (context, state) => Container(
                    width: 74.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                      color: MyColors.darkWhite.withValues(alpha: 90),
                      borderRadius: BorderRadius.circular(70.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(imageUrls.length, (index) {
                        final double baseWidth = 6.w;
                        final double width = baseWidth + (index * 4.w);
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          width: width,
                          height: 6.h,
                          decoration: BoxDecoration(
                            color:
                                state.data == index
                                    ? MyColors.red
                                    : MyColors.grey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    ),
                  ),
            ),
          ),
        ),
      ],
    ),
  );
}
