part of '../product_imports.dart';

class ProductView extends StatefulWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final ProductViewModel vm = ProductViewModel();

  @override
  void initState() {
    super.initState();
    vm.getAllProducts();
  }

  @override
  Widget build(BuildContext context) => Container(
    color: MyColors.white,
    child:
        BlocBuilder<GenericCubit<List<ProModel>>, GenericState<List<ProModel>>>(
          bloc: vm.productsCubit,
          builder: (context, state) {
            final products = state.data;

            if (products.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return ProductsGridView(
              products: products,
              homeViewModel: vm.homeViewModel,
            );
          },
        ),
  );
}
