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
          return CategoriesGridView(categories: categories);
        } else if (state.data.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: CustomText(text: MyStrings.noCategories));
        }
      },
    ),
  );
}
