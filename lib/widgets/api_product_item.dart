part of '../widgets/widgets_imports.dart';

class ApiProductItem extends StatelessWidget {
  final ApiProductModel product;
  final HomeViewModel homVm;
  final WishListViewModel vm;


  const ApiProductItem({required this.product, required this.vm, required this.homVm, super.key});

  @override
  Widget build(BuildContext context) {
    final _ = context.locale;
    final countCubit = homVm.getProductCounter(product);
    return GestureDetector(
      onTap: () => context.pushNamed(MyRouts.productsDetails, extra: product),
      child: Container(
        width: 161.w,
        decoration: BoxDecoration(
          border: Border.all(color: MyColors.darkWhite),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.r),
                topRight: Radius.circular(15.r),
              ),
              child: Container(
                color: MyColors.darkWhite,
                height: 164.h,
                width: double.infinity,
                child: Column(
                  children: [
                    Stack(children: [
                      Image.network(
                        product.image ?? '',
                        fit: BoxFit.fill,
                        height: 138.h,
                        width: double.infinity,
                      ),
                      FavoriteButton(product: product,vm: vm,),
                    ],
                    ),
                    5.verticalSpace,
                    CustomText(
                      text: product.title ?? '',
                      maxLines: 1,
                      textStyle: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.normal,
                        color: MyColors.charcoal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            5.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    textAlign: TextAlign.start,
                    text: product.description ?? '',
                    textStyle: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  10.verticalSpace,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text:
                            '${product.price?.toStringAsFixed(2) ?? '0.00'} ${MyStrings.pound}',
                        textStyle: TextStyle(
                          color: MyColors.navy,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      25.horizontalSpace,
                      Expanded(
                        child: CustomText(
                          text: product.category ?? '',
                          textStyle: TextStyle(
                            color: MyColors.red,
                            fontSize: 9.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  5.verticalSpace,
                  CustomText(
                    text:
                        '${product.rating?.rate?.toStringAsFixed(1) ?? '0.0'} ${MyStrings.rate}',
                    textStyle: TextStyle(color: MyColors.grey, fontSize: 10.sp),
                  ),
                  10.verticalSpace,
                  ProductOrderControl(
                    vm: homVm,
                    product: product,
                    countCubit: countCubit,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
