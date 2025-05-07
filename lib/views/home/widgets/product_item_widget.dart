part of '../home_imports.dart';

class ProductItemWidget extends StatelessWidget {
  final ProductModel product;

  const ProductItemWidget({required this.product, super.key});

  @override
  Widget build(BuildContext context) => Container(
    width: 161.w,
    height: 322.h,
    decoration: BoxDecoration(
      border: Border.all(color: MyColors.darkWhite),
      borderRadius: BorderRadius.circular(4.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Center(
            child: Container(
              color: MyColors.darkWhite,
              height: 164.h,
              width: 159.w,
              child: Column(
                children: [
                  Image.asset(
                    product.image,
                    fit: BoxFit.cover,
                    height: context.locale == AppLanguage.arabic ? 125.h : 138.h,
                    width: 159.w,
                  ),
                  context.locale == AppLanguage.arabic ? 3.verticalSpace : 5.verticalSpace,
                  CustomText(
                    text: MyStrings.discount,
                    textStyle: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: MyColors.charcoal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        5.verticalSpace,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                textAlign: TextAlign.start,
                text: product.title.tr(),
                textStyle: const TextStyle(fontWeight: FontWeight.w500),
              ),
              6.verticalSpace,
              Row(
                children: [
                  CustomText(
                    text:
                        '${product.price.toStringAsFixed(2)} ${MyStrings.pound}',
                    textStyle: TextStyle(
                      color: MyColors.navy,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  25.horizontalSpace,
                  CustomText(
                    text: '${product.points?.toString()} ${MyStrings.point}',
                    textStyle: TextStyle(color: MyColors.red, fontSize: 10.sp),
                  ),
                ],
              ),
              CustomText(
                text: '${product.price.toStringAsFixed(2)} ${MyStrings.pound}',
                textStyle: TextStyle(
                  color: MyColors.grey,
                  fontSize: 10.sp,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              20.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: ProductIconButton(
                      onPressed: () {},
                      icon: Icons.shopping_basket,
                      color: MyColors.red,
                      decoration: const BoxDecoration(),
                    ),
                  ),
                  25.horizontalSpace,
                  ProductIconButton(onPressed: () {}, icon: Icons.add),
                  12.horizontalSpace,
                  const CustomText(text: MyStrings.quantity),
                  12.horizontalSpace,
                  ProductIconButton(
                    onPressed: () {},
                    icon: Icons.remove,
                    color: MyColors.grey,
                  ),
                ],
              ),
              10.verticalSpace
            ],
          ),
        ),
      ],
    ),
  );
}
