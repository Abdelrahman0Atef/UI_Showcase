import 'package:untitled/core/constants/imports.dart';

class CustomTextFieldWithSection extends StatefulWidget {
  final String label;
  final TextInputType keyboardType;
  final TextStyle? labelStyle;
  final InputDecoration? inputDecoration;
  final bool obscureText;
  final VoidCallback? onIconPressed;
  final bool isPasswordVisible;
  final FormFieldValidator? validator;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final ValueChanged<String>? onSubmitted;

  const CustomTextFieldWithSection({
    required this.label,
    this.keyboardType = TextInputType.text,
    this.labelStyle,
    this.inputDecoration,
    this.obscureText = false,
    this.onIconPressed,
    this.isPasswordVisible = false,
    this.validator,
    this.focusNode,
    this.controller,
    this.onSubmitted,
  });

  @override
  _CustomTextFieldWithSectionState createState() => _CustomTextFieldWithSectionState();
}

class _CustomTextFieldWithSectionState extends State<CustomTextFieldWithSection> {
  late FocusNode _focusNode;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) _focusNode.dispose();
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: CustomText(label: widget.label, labelStyle: widget.labelStyle),
          ),
          TextFormField(
            controller: _controller,
            focusNode: _focusNode,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textDirection: TextDirection.rtl,
            validator: widget.validator,
            obscureText: widget.obscureText && !widget.isPasswordVisible,
            decoration: widget.inputDecoration ??
                InputDecoration(
                  prefixIcon: widget.onIconPressed != null
                      ? IconButton(
                    onPressed: widget.onIconPressed,
                    icon: Icon(
                      widget.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  )
                      : null,
                ),
            keyboardType: widget.keyboardType,
            onFieldSubmitted: widget.onSubmitted,
          ),
        ],
      ),
    );
  }
}