part of '../home_imports.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final HomeViewModel vm = HomeViewModel();
  final TextEditingController searchController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final _ = context.locale;
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      BlocBuilder<GenericCubit<bool>, GenericState<bool>>(
        bloc: vm._showClearIconCubit,
        builder:
            (context, state) => HomeSearch(
              controller: searchController,
              hasResults: state.data,
              onTap: () {
                searchController.clear();
                vm._clearSearchResults();
              },
              onChanged: (value) {
                vm._searchProducts(value);
                vm._toggleList(true);
              },
            ),
      ),
      16.verticalSpace,
      BlocBuilder<GenericCubit<bool>, GenericState<bool>>(
        bloc: vm._showListCubit,
        builder: (context, showState) {
          if (!showState.data) return const SizedBox.shrink();
          return BlocBuilder<GenericCubit<List<ProductModel>>, GenericState<List<ProductModel>>>(
            bloc: vm._productListCubit,
            builder: (context, state) {
              final list = state.data;
              if (list.isEmpty) return CustomText(text: MyStrings.noProducts);
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.r),
                  child: GridView.builder(
                    itemCount: list.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 3,
                      childAspectRatio: 0.65,
                    ),
                    itemBuilder: (_, index) => ProductItemWidget(product: list[index]),
                    shrinkWrap: true,
                  ),
                ),
              );
            },
          );
        },
      ),
    ],
  );
}
