part of 'widgets_imports.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color textColor;
  final Color color;
  final double? width;
  final Color? borderColor;

  const CustomButton({
    required this.onPressed, required this.text, required this.textColor, required this.color, super.key,
    this.width,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 48.h,
        width: 245.w,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(width: width ?? 0, color: borderColor ?? Colors.white),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [BoxShadow(blurRadius: 8.r,offset: const Offset(0, 2),color: MyColors.darkBlue,),],
        ),
        child: Center(
          child: CustomText(
            text: text,
            textStyle: TextStyle(
              color: textColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
}
