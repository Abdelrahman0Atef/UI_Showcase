part of '../categorie_imports.dart';

class CategoryGridView extends StatefulWidget {
  const CategoryGridView({super.key});

  @override
  State<CategoryGridView> createState() => _CategoryGridViewState();
}

class _CategoryGridViewState extends State<CategoryGridView> {
  final CategoryViewModel vm = CategoryViewModel();

  @override
  void initState() {
    super.initState();
    vm.getCategories();
  }

  @override
  Widget build(BuildContext context) => Container(
    color: MyColors.white,
    child: BlocBuilder<GenericCubit<List<String>>, GenericState<List<String>>>(
      bloc: vm.categoryCubit,
      builder: (context, state) {
        if (state is GenericUpdateState) {
          final categories = state.data;
          if (categories.isEmpty) {
            return ShimmerProductGrid(height: 150.h);
          }
          return RefreshIndicator(
              strokeWidth: 3,
              backgroundColor: MyColors.white,
              color: MyColors.red,
              onRefresh: () async  =>vm.getCategories(),
              child: CategoriesGridView(categories: categories));
        }else if (state is GenericInitialState){
          return ShimmerProductGrid(height: 150.h);
        } else {
          return  Center(child: CustomText(text: MyStrings.errorLoading));
        }
      },
    ),
  );
}
