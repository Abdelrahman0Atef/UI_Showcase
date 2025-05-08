part of '../search_imports.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({required this.vm, super.key});

  final SearchViewModel vm;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      BlocBuilder<GenericCubit<bool>, GenericState<bool>>(
        bloc: vm._showClearIconCubit,
        builder: (context, state) {
          if (state is GenericUpdateState) {
            return SearchField(
              isHome: true,
              onTap: () {},
              controller: vm._searchController,
              hasResults: state.data,
              onClear: () {
                vm._searchController.clear();
                vm._clearSearchResults();
              },
              onChanged: (value) {
                vm._searchProducts(value);
                vm._toggleList(true);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      16.verticalSpace,
      BlocBuilder<GenericCubit<bool>, GenericState<bool>>(
        bloc: vm._showListCubit,
        builder: (context, state) {
          if (!state.data) return const SizedBox.shrink();
          return BlocBuilder<GenericCubit<List<ProductModel>>, GenericState<List<ProductModel>>>(
            bloc: vm._productListCubit,
            builder: (context, state) {
              if (state is GenericUpdateState) {
                if (state.data.isEmpty) {
                  return CustomText(text: MyStrings.noProducts);
                }
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.r),
                    child: GridView.builder(
                      itemCount: state.data.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 3,
                            childAspectRatio: 0.65,
                          ),
                      itemBuilder: (_, index) => ProductItemWidget(vm: vm,product: state.data[index]),
                      shrinkWrap: true,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          );
        },
      ),
    ],
  );
}