part of sign_in;

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
      child: Text(
        text,
        style: textStyle
      ),
    );
  }
}