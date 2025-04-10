import 'package:untitled/core/constants/imports.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color textColor;
  final Color color;
  final double? width;
  final Color? borderColor;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.textColor,
    required this.color,
    this.width,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50.h,
        width: 200.w,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(width: width!, color: borderColor!),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [BoxShadow(blurRadius: 8.r,offset: Offset(0, 2),color: Color(0x053F5233),),],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
