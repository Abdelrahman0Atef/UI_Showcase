part of 'widgets_imports.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    required this.text, super.key,
    this.textStyle,
    this.fontSize
  });

  final String text;
  final TextStyle? textStyle;
  final double? fontSize;

  @override
  Widget build(BuildContext context) => Text(
    softWrap: true,
      overflow: TextOverflow.visible,
      maxLines: 2,
    textAlign: TextAlign.center,
      text,
      style: textStyle ??
          TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSize?.sp ?? 16,
          ),
    );
}