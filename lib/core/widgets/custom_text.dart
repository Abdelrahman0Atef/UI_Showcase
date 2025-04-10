import 'package:untitled/core/constants/imports.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.label,
    required this.labelStyle,
  });

  final String label;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: labelStyle ??
          TextStyle(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}