part of '../product_details_imports.dart';

class ProductDetailsOrderControl extends StatelessWidget {
  const ProductDetailsOrderControl({
    required this.vm,
    required this.product,
    required this.countCubit,
    required this.onTap,
    super.key,
  });

  final HomeViewModel vm;
  final ApiProductModel product;
  final GenericCubit<int> countCubit;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      ProductIconButton(
        iconSize: 25,
        height: 54.h,
        width: 54.w,
        onPressed: () => vm.increment(product),
        icon: Icons.add,
      ),
      8.horizontalSpace,
      BlocBuilder<GenericCubit<int>, GenericState<int>>(
        bloc: countCubit,
        builder:
            (context, state) => CustomText(
              text: '${state.data}',
              textStyle: TextStyle(fontSize: 26.sp),
            ),
      ),
      8.horizontalSpace,
      BlocBuilder<GenericCubit<int>, GenericState<int>>(
        bloc: countCubit,
        builder: (context, state) {
          final int quantity = state.data;
          final Color buttonColor =
              quantity == 0 ? MyColors.grey : MyColors.black;
          return ProductIconButton(
            iconSize: 25,
            height: 54.h,
            width: 54.w,
            onPressed: () => vm.decrement(product),
            icon: Icons.remove,
            color: buttonColor,
          );
        },
      ),
      12.horizontalSpace,
      GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40.h,
          width: 161.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            color: MyColors.red,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shopping_basket, color: MyColors.white),
              5.horizontalSpace,
              const CustomText(
                text: MyStrings.basket,
                textStyle: TextStyle(color: MyColors.white),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
