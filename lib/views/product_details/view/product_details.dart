part of '../product_details_imports.dart';

class ProductDetailsView extends StatelessWidget {
  final ProModel product;

  const ProductDetailsView({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    final countCubit = vm.getProductCounter(product);
    return Scaffold(
    backgroundColor: MyColors.white,
    appBar: AppBar(
      backgroundColor: MyColors.white,
      elevation: 0,
      title: CustomText(
        text: product.title ?? '',
        textStyle: TextStyle(
          color: MyColors.black,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.network(
              product.image ?? '',
              height: 200.h,
              fit: BoxFit.contain,
            ),
          ),
          20.verticalSpace,
          CustomText(
            text: product.title ?? '',
            textStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: MyColors.navy,
            ),
          ),
          10.verticalSpace,
          CustomText(
            text:
                "${product.price?.toStringAsFixed(2) ?? '0.00'} ${MyStrings.pound}",
            textStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              //color: MyColors.green,
            ),
          ),
          30.verticalSpace,
          CustomText(text: MyStrings.categories),
          15.verticalSpace,
          HomeOffersCard(isSelected: true,label: '${product.category ?? ''}',),
          30.verticalSpace,
          const HomeSplitTextRow(
            label: 'التفاصيل',
            horizontalPadding: 0,
            color: MyColors.grey,
          ),
          15.verticalSpace,
          CustomText(
            text: product.description ?? '',
            maxLines: 10,
            textStyle: TextStyle(
              fontSize: 12.sp,
              color: MyColors.darkGrey,
              fontWeight: FontWeight.w700,
            ),
          ),
          30.verticalSpace,
          const HomeSplitTextRow(
            label: MyStrings.rate,
            horizontalPadding: 0,
            color: MyColors.grey,
          ),
          15.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.r,horizontal:  8.r),
            child: Row(
              children: [
                CustomText(
                  text: "${product.rating?.rate?.toStringAsFixed(1) ?? '0.0'}",
                  textStyle: TextStyle(fontSize: 12.sp, color: MyColors.red),
                ),
                5.horizontalSpace,
                Icon(Icons.star, color: MyColors.red, size: 18.sp),
              ],
            ),
          ),
          30.verticalSpace,
          ProductDetailsOrderControl(
            vm: vm,
            product: product,
            countCubit: countCubit,
          ),
        ],
      ),
    ),
  );
  }
}
