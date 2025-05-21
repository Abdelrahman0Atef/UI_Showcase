part of '../profile_imports.dart';

class ProfileBody extends StatelessWidget {
  final ProfileViewModel vm;

  const ProfileBody({required this.vm, super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.all(16.r),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<GenericCubit<int>, GenericState<int>>(
            bloc: vm._selectedIndexCubit,
            builder: (context, state) => ProfileCustomDataCard(vm: vm),
          ),
          16.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ProfileCustomCardButton(
                onTap: () {},
                icon: Icons.person,
                text: MyStrings.editData,
              ),
              8.horizontalSpace,
              ProfileCustomCardButton(
                onTap: () {
                  context.pushNamed(MyRouts.blogs);
                },
                icon: Icons.shopping_bag,
                text: MyStrings.orders,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ProfileCustomCardButton(
                onTap: () {},
                icon: Icons.location_on_sharp,
                text: MyStrings.addresses,
              ),
              8.horizontalSpace,
              ProfileCustomCardButton(
                onTap: () {context.pushNamed(MyRouts.wishList);},
                icon: Icons.favorite,
                text: MyStrings.wishList,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ProfileCustomCardButton(
                onTap: () {},
                icon: Icons.balance,
                text: MyStrings.compare,
              ),
              8.horizontalSpace,
              ProfileCustomCardButton(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.r),
                      ),
                    ),
                    builder: (sheetContext) {
                      final currentLocale = sheetContext.locale;
                      return Padding(
                        padding: EdgeInsets.all(16.r),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ProfileRadioChangeLanguage(
                              languageLocale: AppLanguage.english,
                              currentLocale: currentLocale,
                              flagAssetPath: MyAssets.usaFlag,
                              languageText: MyStrings.englishTranslation,
                            ),
                            ProfileRadioChangeLanguage(
                              languageLocale: AppLanguage.arabic,
                              currentLocale: currentLocale,
                              flagAssetPath: MyAssets.egyptFlag,
                              languageText: MyStrings.arabicTranslation,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                icon: Icons.translate,
                text: MyStrings.changeLanguage,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ProfileCustomCardButton(
                onTap: () => vm._shareApp(context),
                icon: Icons.share,
                text: MyStrings.shareApp,
              ),
              8.horizontalSpace,
              ProfileCustomCardButton(
                onTap: () {context.pushNamed(MyRouts.contactUs);},
                icon: Icons.star_rate,
                text: MyStrings.rateTheApp,
              ),
            ],
          ),
          Center(
            child: SizedBox(
              width: double.infinity.w,
              child: ProfileCustomCardButton(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    useRootNavigator: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.r),
                      ),
                    ),
                    builder:
                        (sheetContext) =>
                            ProfileSignOutBottomSheet(vm: vm),
                  );
                },
                text: MyStrings.signOut,
                icon: Icons.logout,
              ),
            ),
          ),
          16.verticalSpace,
          BlocBuilder<GenericCubit<String?>, GenericState<String?>>(
            bloc: vm._versionCubit,
            builder: (context, state) {
              if (state is GenericUpdateState) {
                return Center(
                  child: CustomText(
                    text: MyStrings.version + (state.data ?? ''),
                    textStyle: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 14.sp,
                      color: MyColors.grey,
                    ),
                  ),
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    ),
  );
}
