part of '../profile_imports.dart';

class ProfileBody extends StatelessWidget {
  final ProfileLoaded state;
  final ProfileViewModel viewModel;

  const ProfileBody({
    required this.viewModel,
    required this.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final version = (state.appVersion != null)
        ? state.appVersion
        : (viewModel.state as ProfileLoaded).appVersion;

    return Padding(
      padding: EdgeInsets.all(16.r),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileCustomDataCard(phoneNumber: state.userPhone),
            16.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProfileCustomCardButton(
                  onTap: () {},
                  icon: Icons.person,
                  text: MyStrings.editData,
                ),
                ProfileCustomCardButton(
                  onTap: () {},
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
                ProfileCustomCardButton(
                  onTap: () {},
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
                  onTap: () => viewModel.shareApp(),
                  icon: Icons.share,
                  text: MyStrings.shareApp,
                ),
                ProfileCustomCardButton(
                  onTap: () {},
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
                      builder: (sheetContext) => BlocProvider.value(
                        value: context.read<ProfileCubit>(),
                        child: const ProfileSignOutBottomSheet(),
                      ),
                    );
                  },
                  text: MyStrings.signOut,
                  icon: Icons.logout,
                ),
              ),
            ),
            16.verticalSpace,
            Center(
              child: CustomText(
                text: MyStrings.version + viewModel.getVersionText(),
                textStyle: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 14.sp,
                  color: MyColors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
