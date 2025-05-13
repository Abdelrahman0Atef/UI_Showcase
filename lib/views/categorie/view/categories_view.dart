part of '../categorie_imports.dart';

class CategoryGridView extends StatefulWidget {
  const CategoryGridView({super.key});

  @override
  State<CategoryGridView> createState() => _CategoryGridViewState();
}

class _CategoryGridViewState extends State<CategoryGridView> {
  final CategoryViewModel vm = CategoryViewModel(DataSources(Dio()));

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
              return GridView.builder(
                padding: EdgeInsets.all(12.r),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.r,
                  mainAxisSpacing: 12.r,
                  childAspectRatio: 1.5,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final imagePath = MyAssets.egyptFlag;
                  return GestureDetector(
                    onTap: () {
                      context.pushNamed(
                        MyRouts.categoriesProducts,
                        queryParameters: {'category': category},
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyColors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(color: MyColors.fortress, blurRadius: 8.r),
                        ],
                      ),
                      padding: EdgeInsets.all(12.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: CustomText(
                              text: category,
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          10.horizontalSpace,
                          Image.asset(
                            imagePath,
                            width: 40.w,
                            height: 40.h,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state.data.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(child: CustomText(text: MyStrings.noCategories));
            }
          },
        ),
  );
}
