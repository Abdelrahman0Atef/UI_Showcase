part of '../profile_imports.dart';

class ProfileCustomCardButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String text;

  const ProfileCustomCardButton({
    required this.onTap,
    required this.icon,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 8.r),
      width: 175.w,
      height: 100.h,
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: MyColors.grey),
          8.verticalSpace,
          CustomText(text: text),
        ],
      ),
    ),
  );
}
