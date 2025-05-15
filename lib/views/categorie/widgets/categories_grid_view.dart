part of '../categorie_imports.dart';

class CategoriesGridView extends StatelessWidget {
  const CategoriesGridView({required this.categories, super.key});

  final List<String> categories;

  @override
  Widget build(BuildContext context) => GridView.builder(
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
            queryParameters: {MyStrings.apiCategory: category},
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [BoxShadow(color: MyColors.fortress, blurRadius: 8.r)],
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
}
