part of '../wish_list_imports.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  final WishListViewModel viewModel = WishListViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.loadFavorites();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Wishlist'), elevation: 0),
      body: BlocBuilder<GenericCubit<List<ApiProductModel>>, GenericState<List<ApiProductModel>>>(
        bloc: viewModel.favoritesCubit,
        builder: (context, state) {
          if (state is GenericUpdateState) {
            return Padding(
              padding: EdgeInsets.all(10.r),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                ),
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  final product = state.data[index];
                  return ApiProductItem(
                    product: product,
                    vm: viewModel.homeViewModel,
                  );
                },
              ),
            );
          } return const Center(child: CustomText(text: 'No Favorite Products Yet'));

        },
      ),
    );
}
