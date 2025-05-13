import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/core/generic_cubit/generic_cubit.dart';
import 'package:untitled/core/models/product_model/api_product_model.dart';
import 'package:untitled/core/resources/my_colors.dart';
import 'package:untitled/core/resources/my_strings.dart';
import 'package:untitled/views/search/search_imports.dart';
import 'package:untitled/widgets/widgets_imports.dart';

class ProItemWidget extends StatefulWidget {
  final ProModel product;

  const ProItemWidget({
    required this.product,
    super.key,
  });

  @override
  State<ProItemWidget> createState() => _ProItemWidgetState();
}

class _ProItemWidgetState extends State<ProItemWidget> {
  late final GenericCubit<int> _countCubit;

  @override
  void initState() {
    super.initState();
    _countCubit = GenericCubit<int>(0);
  }

  @override
  void dispose() {
    _countCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Container(
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
                    width: double.infinity.w,
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
                      textStyle:
                      TextStyle(color: MyColors.red, fontSize: 9.sp),
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
                Row(
                  children: [
                    ProductIconButton(
                      onPressed: () {},
                      icon: Icons.shopping_basket,
                      color: MyColors.red,
                      decoration: const BoxDecoration(),
                    ),
                    12.horizontalSpace,
                    ProductIconButton(
                      onPressed: () {
                        increment(product);
                      },
                      icon: Icons.add,
                    ),
                    8.horizontalSpace,
                    BlocBuilder<GenericCubit<int>, GenericState<int>>(
                      bloc: _countCubit,
                      builder: (context, state) => CustomText(
                        text: '${state.data}',
                        textStyle: TextStyle(fontSize: 12.sp),
                      ),
                    ),
                    8.horizontalSpace,
                    ProductIconButton(
                      onPressed: () {
                        decrement();
                      },
                      icon: Icons.remove,
                      color: MyColors.black,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void increment(ProModel product) {
    final int maxCount = (product.rating?.count ?? 0) ~/ 4;
    final int current = _countCubit.state.data;
    if (current < maxCount) {
      _countCubit.onUpdateData(current + 1);
    }
  }

  void decrement() {
    final int current = _countCubit.state.data;
    if (current > 0) {
      _countCubit.onUpdateData(current - 1);
    }
  }
}
