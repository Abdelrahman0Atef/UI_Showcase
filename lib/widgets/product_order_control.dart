part of '../widgets/widgets_imports.dart';

class ProductOrderControl extends StatelessWidget {
  const ProductOrderControl({
    required this.vm,
    required this.product,
    required this.countCubit,
    super.key,
  });

  final HomeViewModel vm;
  final dynamic product;
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
        builder:
            (context, state) => CustomText(
              text: '${state.data}',
              textStyle: TextStyle(fontSize: 12.sp),
            ),
      ),
      8.horizontalSpace,
      BlocBuilder<GenericCubit<int>, GenericState<int>>(
        bloc: countCubit,
        builder:
            (context, state) => ProductIconButton(
              onPressed: () => vm.decrement(product),
              icon: Icons.remove,
              color: state.data == 0 ? MyColors.grey : MyColors.black,
            ),
      ),
    ],
  );
}
