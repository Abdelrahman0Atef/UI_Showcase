part of '../product_imports.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final ProductsViewModel vm = ProductsViewModel();

  @override
  void initState() {
    super.initState();
    vm.getAllProducts();
    vm.loadFavorites();
  }

  @override
  Widget build(BuildContext context) => Container(
    color: MyColors.white,
    child:
        BlocBuilder<GenericCubit<List<ApiProductModel>>, GenericState<List<ApiProductModel>>>(
          bloc: vm.productsCubit,
          builder: (context, state) {
            final products = state.data;

            if (products.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return ProductsGridView(
              products: products,
              homeVm: vm.homeViewModel,
            );
          },
        ),
  );
}
