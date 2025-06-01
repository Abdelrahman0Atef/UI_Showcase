part of '../home_imports.dart';

class HomeOffersCard extends StatelessWidget {
  const HomeOffersCard({
    required this.isSelected,
    this.label,
    super.key,
  });

  final bool isSelected;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final _ = context.locale;
    return Container(
    width: 136.w,
    height: 38.h,
    decoration: BoxDecoration(
      color: isSelected ? MyColors.red : MyColors.white,
      boxShadow: [
        BoxShadow(
          color: const Color(0xFFFF464629).withValues(alpha: 0.16),
          blurRadius: 8.r,
        ),
      ],
      borderRadius: BorderRadius.circular(6),
    ),
    child: Center(
      child: CustomText(
        text: label ?? MyStrings.skin,
        textStyle: TextStyle(
          fontWeight: FontWeight.normal,
          color: isSelected ? MyColors.white : MyColors.black,
        ),
      ),
    ),
  );
  }
}
