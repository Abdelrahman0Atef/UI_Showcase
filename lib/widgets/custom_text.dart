part of 'widgets_imports.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    required this.text, super.key,
    this.textStyle,
    this.fontSize,
    this.textAlign
  });

  final String text;
  final TextStyle? textStyle;
  final double? fontSize;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) => Text(
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      textAlign: textAlign ?? TextAlign.center,
      text,
      style: textStyle ??
          TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSize?.sp ?? 16,
          ),
    );
}