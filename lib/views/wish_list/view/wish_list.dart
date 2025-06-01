part of '../wish_list_imports.dart';

class WishListView extends StatefulWidget {
  const WishListView({Key? key}) : super(key: key);

  @override
  State<WishListView> createState() => _WishListViewState();
}

class _WishListViewState extends State<WishListView> {
  final WishListViewModel vm = getIt<WishListViewModel>();

  @override
  void initState() {
    super.initState();
    vm.loadFavorites();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: CustomText(text: MyStrings.wishList),
      centerTitle: true,
    ),
    body: BlocBuilder<GenericCubit<List<ApiProductModel>>, GenericState<List<ApiProductModel>>>(
      bloc: vm.favoritesCubit,
      builder: (context, state) {
        if (state is GenericUpdateState) {
          if (state.data.isEmpty) {
            return Center(
              child: CustomText(
                text: MyStrings.noFavorite,
                textStyle: const TextStyle(color: MyColors.red,fontWeight: FontWeight.bold,),
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(10.r),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent:  322.h,
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
                    vm: vm,
                    homVm: vm.homeVM,
                  );
                },
              ),
            );
          }
        } else {
          return Center(child: CustomText(text: MyStrings.errorLoading));
        }
      },
    ),
  );
}
