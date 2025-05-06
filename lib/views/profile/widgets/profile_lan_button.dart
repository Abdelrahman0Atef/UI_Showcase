part of '../profile_imports.dart';

class ProfileRadioChangeLanguage extends StatelessWidget {
  const ProfileRadioChangeLanguage({
    required this.languageLocale,
    required this.currentLocale,
    required this.flagAssetPath,
    required this.languageText,
    super.key,
  });

  final Locale languageLocale;
  final Locale currentLocale;
  final String flagAssetPath;
  final String languageText;

  @override
  Widget build(BuildContext context) => RadioListTile<Locale>(
    activeColor: MyColors.red,
    controlAffinity: ListTileControlAffinity.trailing,
    title: Row(
      children: [
        Image.asset(flagAssetPath, width: 25.w, height: 25.w),
        8.horizontalSpace,
        CustomText(text: languageText, textStyle: const TextStyle()),
      ],
    ),
    value: languageLocale,
    groupValue: currentLocale,
    onChanged: (_) {
      context.setLocale(languageLocale);
      context.pop();
    },
  );
}
