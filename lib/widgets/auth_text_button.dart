part of 'widgets_imports.dart';

class AuthTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final TextStyle? textStyle;

  const AuthTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textStyle
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: CustomText(
        text: text,
        textStyle: textStyle
      ),
    );
  }
}