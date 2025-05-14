part of '../categories_product_imports.dart';

class CategoriesProductsView extends StatefulWidget {
  final String category;

  const CategoriesProductsView({required this.category, Key? key})
    : super(key: key);

  @override
  State<CategoriesProductsView> createState() => _CategoriesProductsViewState();
}

class _CategoriesProductsViewState extends State<CategoriesProductsView> {
  final CategoriesProductViewModel viewModel = CategoriesProductViewModel();
  //final SearchViewModel vm = SearchViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.getProductsByCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: MyColors.white,
    appBar: AppBar(title: CustomText(text: widget.category), centerTitle: true),
    body:
        BlocBuilder<GenericCubit<List<ProModel>>, GenericState<List<ProModel>>>(
          bloc: viewModel.productsCubit,
          builder: (context, state) {
            if (state is GenericUpdateState) {
              final products = state.data;
              if (products.isEmpty) {
                return Center(child: CustomText(text: MyStrings.noProducts));
              }
              return ProductsGridView(products: products, homeViewModel: viewModel.homeViewModel,);
            } else if (state is GenericInitialState) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(
                child: CustomText(text: MyStrings.errorLoading),
              );
            }
          },
        ),
  );
}
