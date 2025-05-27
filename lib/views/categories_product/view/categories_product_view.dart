part of '../categories_product_imports.dart';

class CategoriesProductsView extends StatefulWidget {
  final String category;

  const CategoriesProductsView({required this.category, Key? key})
    : super(key: key);

  @override
  State<CategoriesProductsView> createState() => _CategoriesProductsViewState();
}

class _CategoriesProductsViewState extends State<CategoriesProductsView> {
  final CategoriesProductViewModel vm = CategoriesProductViewModel();

  @override
  void initState() {
    super.initState();
    vm.getProductsByCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: MyColors.white,
    appBar: AppBar(title: CustomText(text: widget.category), centerTitle: true),
    body:
        BlocBuilder<GenericCubit<List<ApiProductModel>>, GenericState<List<ApiProductModel>>>(
          bloc: vm.productsCubit,
          builder: (context, state) {
            if (state is GenericUpdateState) {
              final products = state.data;
              if (products.isEmpty) {
                return Center(child: CustomText(text: MyStrings.noProducts));
              }
              return RefreshIndicator(
                strokeWidth: 3,
                backgroundColor: MyColors.white,
                color: MyColors.red,
                onRefresh: () async  =>vm.getProductsByCategory(widget.category),
                child: CustomScrollbar(
                  child: ProductsGridView(
                    products: products,
                    homeVm: vm.homeVm,
                  ),
                ),
              );
            } else if (state is GenericInitialState) {
              return const ShimmerProductGrid();
            } else {
              return const Center(
                child: CustomText(text: MyStrings.errorLoading),
              );
            }
          },
        ),
  );
}
