import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/core/models/product_model/api_product_model.dart';
import 'package:untitled/views/home/home_imports.dart';
import 'package:untitled/widgets/pro_item.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({
    required this.products, required this.homeViewModel, super.key,
  });

  final List<ProModel> products;
  final HomeViewModel homeViewModel;

  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.all(12.r),
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.57,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
        ),
        itemBuilder:
            (context, index) => ProItemWidget(
          product: products[index],
              vm: homeViewModel,
        ),
      ),
    );
}