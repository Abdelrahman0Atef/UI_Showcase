part of 'widgets_imports.dart';

class AuthTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final TextStyle? textStyle;

  const AuthTextButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: onPressed,
    child: CustomText(text: text, textStyle: textStyle),
  );
}
