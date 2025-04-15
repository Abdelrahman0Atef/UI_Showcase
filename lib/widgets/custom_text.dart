part of 'widgets_imports.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    required this.text, super.key,
    this.textStyle,
  });

  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) => Text(
      text,
      style: textStyle ??
          const TextStyle(
            fontWeight: FontWeight.bold,
          ),
    );
}