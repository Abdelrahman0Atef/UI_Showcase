part of '../profile_imports.dart';

class ProfileBody extends StatelessWidget {
  final BuildContext context;
  final ProfileLoaded state;
  final VoidCallback onPressed;

  const ProfileBody({
    required this.context,
    required this.state,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final profileCubit = context.read<ProfileCubit>();
    final version =
        (state.appVersion != null)
            ? state.appVersion
            : profileCubit._appVersion;
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
                  onTap: () {
                    shareApp(context);
                  },
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
                  onTap: onPressed,
                  text: MyStrings.signOut,
                  icon: Icons.logout,
                ),
              ),
            ),
            16.verticalSpace,
            Center(
              child: CustomText(
                text: MyStrings.version + version!,
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

  void shareApp(BuildContext context) {
    final bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final bool isAndroid = Theme.of(context).platform == TargetPlatform.android;
    if (isIOS) {
      context.read<ProfileCubit>().shareApp(MyStrings.iosLink);
    } else if (isAndroid) {
      context.read<ProfileCubit>().shareApp(MyStrings.androidLink);
    } else {
      context.read<ProfileCubit>().shareApp(MyStrings.webSiteLink);
    }
  }
}