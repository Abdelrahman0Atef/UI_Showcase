part of '../home_imports.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({required this.vm, super.key});

  final HomeViewModel vm;

  @override
  Widget build(BuildContext context) {
    final SearchViewModel searchModel = SearchViewModel();
    searchModel.init();

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
          CustomImageSlider(vm: vm, imageUrls: vm.imageUrls),
          const HomeSplitTextRow(label: MyStrings.offers),
          15.verticalSpace,
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
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
          15.verticalSpace,
          SizedBox(
            height: 322.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: SearchViewModel.allProducts.length,
              itemBuilder: (context, index) {
                final product = SearchViewModel.allProducts[index];
                return Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: ProductItemWidget(product: product, vm: searchModel),
                );
              },
            ),
          ),
          30.verticalSpace,
          const HomeSplitTextRow(label: MyStrings.goals),
          25.verticalSpace,
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                HomeSplitCard(
                  text: MyStrings.fitness,
                  color: MyColors.lightNavy,
                  image: MyAssets.fitness,
                ),
                HomeSplitCard(
                  text: MyStrings.skinCare,
                  color: MyColors.lightPink,
                  image: MyAssets.face,
                ),
              ],
            ),
          ),
          30.verticalSpace,
          Image.asset(
            MyAssets.brands,
            width: double.infinity.w,
            fit: BoxFit.cover,
          ),
          30.verticalSpace,
          const HomeSplitTextRow(label: MyStrings.product),
          25.verticalSpace,
          SizedBox(
            height: 322.h,
            width: double.infinity.w,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: SearchViewModel.allProducts.length,
              itemBuilder: (context, index) {
                final product = SearchViewModel.allProducts[index];
                return Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: ProductItemWidget(product: product, vm: searchModel),
                );
              },
            ),
          ),
          30.verticalSpace,
          const HomeSplitTextRow(label: MyStrings.worries),
          25.verticalSpace,
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                HomeSplitCard(
                  text: MyStrings.headache,
                  color: MyColors.lightNavy,
                  image: MyAssets.headache,
                ),
                HomeSplitCard(
                  text: MyStrings.flu,
                  color: MyColors.lightPink,
                  image: MyAssets.flu,
                ),
              ],
            ),
          ),
          30.verticalSpace,
          const HomeSplitTextRow(label: MyStrings.articles),
          20.verticalSpace,
          SizedBox(
            width: double.infinity.w,
            height: 0.41.sh,
            child: BlocBuilder<GenericCubit<List<BlogPost>>,GenericState<List<BlogPost>>>(
                bloc: vm._blogCubit,
                builder: (context, state){
              if(state is GenericUpdateState && state.data.isNotEmpty){
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    final blog = state.data[index];
                    return HomeBlogsCard(
                      featureImage: blog.featuredImage,
                      creationTime: blog.creationTime,
                      title: blog.title,
                      shortContent: blog.shortContent,
                    );
                  },
                );
              } return const Center(child: CustomText(text: MyStrings.noBlogs));
                }),
          ),
          5.verticalSpace,
          GridView.count(
            padding: EdgeInsets.all(16.r),
            crossAxisCount: 2,
            crossAxisSpacing: 12.h,
            mainAxisSpacing: 12.h,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const HomeInfoCard(
                image: MyAssets.car,
                title: MyStrings.fastShipping,
                subTitle: MyStrings.shippingTime,
              ),
              const HomeInfoCard(
                image: MyAssets.mobile,
                title: MyStrings.safeShopping,
                subTitle: MyStrings.security,
              ),
              HomeInfoCard(
                onTap: (){context.pushNamed(MyRouts.contactUs);},
                image: MyAssets.callCenter,
                title: MyStrings.callCenter,
                subTitle: MyStrings.ambassadors,
              ),
              const HomeInfoCard(
                image: MyAssets.money,
                title: MyStrings.refund,
                subTitle: MyStrings.credit,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
