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
        bloc: vm.showListCubit,
        builder: (context, state) {
          if (!state.data) return const SizedBox.shrink();
          return BlocBuilder<
            GenericCubit<List<HomeModel>>,
            GenericState<List<HomeModel>>
          >(
            bloc: vm.productListCubit,
            builder: (context, state) {
              if (state is GenericUpdateState) {
                if (state.data.isEmpty) {
                  return CustomText(text: MyStrings.noProducts);
                }
                return Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10.r),
                    itemCount: state.data.length,
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 322.h,
                          crossAxisCount: 2,
                          mainAxisSpacing: 10.h,
                          crossAxisSpacing: 10.w,
                          childAspectRatio: 0.65,
                        ),
                    itemBuilder:
                        (_, index) => ProductItemWidget(
                          vm: vm,
                          product: state.data[index],
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
