import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/core/generic_cubit/generic_cubit.dart';
import 'package:untitled/core/models/product_model/api_product_model.dart';
import 'package:untitled/core/resources/my_colors.dart';
import 'package:untitled/views/home/home_imports.dart';
import 'package:untitled/views/search/search_imports.dart';
import 'package:untitled/widgets/widgets_imports.dart';

class ProductOrderControl extends StatelessWidget {
  const ProductOrderControl({
    required this.vm, required this.product, required this.countCubit, super.key,
  });

  final HomeViewModel vm;
  final ProModel product;
  final GenericCubit<int> countCubit;

  @override
  Widget build(BuildContext context) => Row(
      children: [
        ProductIconButton(
          onPressed: () {},
          icon: Icons.shopping_basket,
          color: MyColors.red,
          decoration: const BoxDecoration(),
        ),
        12.horizontalSpace,
        ProductIconButton(
          onPressed: () => vm.increment(product),
          icon: Icons.add,
        ),
        8.horizontalSpace,
        BlocBuilder<GenericCubit<int>, GenericState<int>>(
          bloc: countCubit,
          builder: (context, state) => CustomText(
            text: '${state.data}',
            textStyle: TextStyle(fontSize: 12.sp),
          ),
        ),
        8.horizontalSpace,
        ProductIconButton(
          onPressed: () => vm.decrement(product),
          icon: Icons.remove,
          color: MyColors.black,
        ),
      ],
    );
}