part of '../views/search/search_imports.dart';

class ProductItemWidget extends StatelessWidget {
  final HomeModel product;
  final SearchViewModel vm;

  const ProductItemWidget({required this.product, required this.vm, super.key});

  @override
  Widget build(BuildContext context) => Container(
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
            width: double.infinity.w,
            child: Column(
              children: [
                Image.asset(
                  product.image,
                  fit: BoxFit.cover,
                  height: 138.h,
                  width: double.infinity.w,
                ),
                7.verticalSpace,
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
        7.verticalSpace,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                maxLines: 1,
                textAlign: TextAlign.start,
                text: product.title,
                textStyle: const TextStyle(fontWeight: FontWeight.w500),
              ),
              10.verticalSpace,
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
              12.verticalSpace,
              CustomText(
                text: '${product.price.toStringAsFixed(2)} ${MyStrings.pound}',
                textStyle: TextStyle(
                  color: MyColors.grey,
                  fontSize: 10.sp,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              30.verticalSpace,
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
                  ProductIconButton(
                    onPressed: () {
                      vm._incrementQuantity(product);
                    },
                    icon: Icons.add,
                  ),
                  12.horizontalSpace,
                  BlocBuilder<GenericCubit<int>, GenericState<int>>(
                    bloc: product.quantityCubit,
                    builder: (context, state) {
                      if (state is GenericUpdateState) {
                        return CustomText(
                          text: '${product.quantityCubit.state.data}',
                        );
                      }
                      return const CustomText(text: MyStrings.quantity);
                    },
                  ),
                  12.horizontalSpace,
                  BlocBuilder<GenericCubit<int>, GenericState<int>>(
                    bloc: product.quantityCubit,
                    builder: (context, state) {
                      if (state is GenericUpdateState) {
                        state.data;
                      }
                      return ProductIconButton(
                        onPressed: () {
                          vm._decrementQuantity(product);
                        },
                        icon: Icons.remove,
                        color:
                            product.quantityCubit.state.data <= 0
                                ? MyColors.grey
                                : MyColors.black,
                      );
                    },
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
