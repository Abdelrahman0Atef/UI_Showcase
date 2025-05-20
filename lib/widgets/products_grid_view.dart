part of '../widgets/widgets_imports.dart';

class ProductsGridView extends StatelessWidget {
  ProductsGridView({
    required this.products,
    required this.homeVm,
    super.key,
  });

  final List<ApiProductModel> products;
  final HomeViewModel homeVm;

  final WishListViewModel wishVm = getIt<WishListViewModel>();

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.all(12.r),
    child: GridView.builder(
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 322.h,
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 10.h,
      ),
      itemBuilder: (context, index) => ApiProductItem(
        product: products[index],
        homVm: homeVm,
        vm: wishVm,
      ),
    ),
  );
}
