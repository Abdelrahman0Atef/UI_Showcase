part of '../product_list_imports.dart';

class ErrorIndicator extends StatelessWidget {
  final String message;
  final VoidCallback onTryAgain;
  final bool isNewPage;

  const ErrorIndicator({
    required this.message,
    required this.onTryAgain,
    this.isNewPage = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.all(20.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: MyColors.red,
            size: isNewPage ? 30 : 50,
          ),
          10.verticalSpace,
          CustomText(
            text: MyStrings.errorLoading,
            textAlign: TextAlign.center,
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isNewPage ? 14.sp : 18.sp,
              color: MyColors.red,
            ),
          ),
          5.verticalSpace,
          CustomText(
            text: message.replaceAll('HttpException: ', ''),
            textAlign: TextAlign.center,
            textStyle: TextStyle(
              fontSize: isNewPage ? 12.sp : 14.sp,
              color: MyColors.green,
            ),
          ),
          15.verticalSpace,
          CustomButton(
            onPressed: onTryAgain,
            text: MyStrings.tryAgain,
            textColor: MyColors.white,
            color: MyColors.red,
          ),
        ],
      ),
    ),
  );
}
