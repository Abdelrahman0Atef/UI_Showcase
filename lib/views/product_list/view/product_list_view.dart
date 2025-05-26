part of '../product_list_imports.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({Key? key}) : super(key: key);

  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  final ProductListViewModel vm = ProductListViewModel();


  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: MyColors.white,
    appBar: AppBar(
      title: CustomText(text: MyStrings.products),
      centerTitle: true,
    ),
    body: RefreshIndicator(
      onRefresh: () async  => vm.refresh(),
      child: PagedGridView<int, Product>(
        pagingController: vm.pagingController,
        padding: EdgeInsets.all(12.r),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
          childAspectRatio: 0.7,
        ),
        builderDelegate: PagedChildBuilderDelegate<Product>(
          animateTransitions: true,
          itemBuilder: (context, item, index) => ProductCard(
            product: item,
          ),
          firstPageProgressIndicatorBuilder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          newPageProgressIndicatorBuilder: (context) => Padding(
            padding: EdgeInsets.all(16.r),
            child: const Center(child: CircularProgressIndicator()),
          ),
          firstPageErrorIndicatorBuilder: (context) => ErrorIndicator(
            message: vm.pagingController.error.toString(),
            onTryAgain: () {
              vm.retry();
            },
          ),
          newPageErrorIndicatorBuilder: (context) => ErrorIndicator(
            message: vm.pagingController.error.toString(),
            onTryAgain: () => vm.retry(),
            isNewPage: true,
          ),
        ),
      ),
    ),
  );

  @override
  void dispose() {
    vm.pagingController.dispose();
    super.dispose();
  }
}