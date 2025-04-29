part of '../profile_imports.dart';

class ProfileCustomCardButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String text;

  const ProfileCustomCardButton({
    required this.onTap, required this.icon, required this.text, Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 175.w,
        height: 100.h,
        child:  Card(
          color: MyColors.white,
          elevation: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,color: MyColors.grey,),
              8.verticalSpace,
              CustomText(text: text),
            ],
          ),
        ),
      ),
    );
}
