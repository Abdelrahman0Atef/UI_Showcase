part of '../home_imports.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({required this.vm, super.key});

  final HomeViewModel vm;

  @override
  Widget build(BuildContext context) {
    final SearchViewModel searchModel = SearchViewModel();
    return SingleChildScrollView(
      child: Column(
        children: [
          SearchField(
            controller: TextEditingController(),
            hasResults: false,
            onChanged: (_) {},
            onClear: () {},
            onTap: () {
              context.pushNamed(MyRouts.search);
            },
          ),
          CustomImageSlider(viewModel: vm, imageUrls: vm.imageUrls),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomText(
                text: 'Offers',
                textStyle: TextStyle(
                  color: MyColors.navy,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const CustomText(
                text: 'More',
                textStyle: TextStyle(
                  decoration: TextDecoration.underline,
                  color: MyColors.grey,
                ),
              ),
            ],
          ),
          26.verticalSpace,
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const HomeOffersCard(isSelected: true),
                12.horizontalSpace,
                const HomeOffersCard(isSelected: false),
                12.horizontalSpace,
                const HomeOffersCard(isSelected: false),
              ],
            ),
          ),
          BlocBuilder<GenericCubit<bool>, GenericState<bool>>(
            bloc: searchModel.showListCubit,
            builder: (context, state) {
              if (!state.data) return const SizedBox.shrink();
              return BlocBuilder<
                GenericCubit<List<ProductModel>>,
                GenericState<List<ProductModel>>
              >(
                bloc: searchModel.productListCubit,
                builder: (context, state) {
                  if (state is GenericUpdateState) {
                    if (state.data.isEmpty) {
                      return CustomText(text: MyStrings.noProducts);
                    }
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.r),
                        child: ListView.builder(
                          itemCount: state.data.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder:
                              (_, index) => ProductItemWidget(
                                product: state.data[index],
                                vm: searchModel,
                              ),
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
      ),
    );
  }
}
