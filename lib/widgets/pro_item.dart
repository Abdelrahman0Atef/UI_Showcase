import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/core/models/product_model/api_product_model.dart';
import 'package:untitled/core/resources/my_colors.dart';
import 'package:untitled/core/resources/my_routs.dart';
import 'package:untitled/core/resources/my_strings.dart';
import 'package:untitled/views/home/home_imports.dart';
import 'package:untitled/widgets/product_order_control.dart';
import 'package:untitled/widgets/widgets_imports.dart';

class ProItemWidget extends StatelessWidget {
  final ProModel product;
  final HomeViewModel vm;

  const ProItemWidget({
    required this.product,
    required this.vm,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final countCubit = vm.getProductCounter(product);

    return GestureDetector(
      onTap: () => context.pushNamed(MyRouts.productsDetails, extra: product),
      child: Container(
        height: 322.h,
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
                    Image.network(
                      product.image ?? '',
                      fit: BoxFit.fill,
                      height: 138.h,
                      width: double.infinity,
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
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    text: product.description ?? '',
                    textStyle: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  8.verticalSpace,
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
                      CustomText(
                        text: product.category ?? '',
                        textStyle: TextStyle(color: MyColors.red, fontSize: 9.sp),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  CustomText(
                    text:
                    '${product.rating?.rate?.toStringAsFixed(1) ?? '0.0'} ${MyStrings.rate}',
                    textStyle: TextStyle(color: MyColors.grey, fontSize: 10.sp),
                  ),
                  5.verticalSpace,
                  ProductOrderControl(vm: vm, product: product, countCubit: countCubit,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}