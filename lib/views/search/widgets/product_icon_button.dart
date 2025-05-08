part of '../search_imports.dart';

class ProductIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final double? width;
  final double? height;
  final Decoration? decoration;
  final Color? color;

  const ProductIconButton({
    required this.onPressed,
    required this.icon,this.width, this.height, super.key, this.decoration, this.color,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onPressed,
    child: Container(
      width: width?.w ?? 24,
      height: height?.w ?? 24,
      decoration: decoration ?? BoxDecoration(
        border: Border.all(color: MyColors.gainsboro),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color ?? MyColors.navy, size: 16,),
    ),
  );
}
