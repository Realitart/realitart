import 'package:flutter/material.dart';
import 'package:realitart/core/framework/colors.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final String? hintText, labelText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  final Color? fillColor;
  final Color? borderColor;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.validator,
    this.hintText,
    this.labelText,
    this.keyboardType,
    this.leftIcon,
    this.rightIcon,
    this.maxLines = 1,
    this.maxLength,
    this.fillColor,
    this.borderColor,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isObscured = true;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: txtBlack,
      controller: widget.controller,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      validator: widget.validator,
      focusNode: _focusNode,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      onTapOutside: (focusNode) {
        setState(() {
          _focusNode.unfocus();
        });
      },
      obscureText: widget.rightIcon != null ? _isObscured : false,
      decoration: InputDecoration(
        filled: true,
        fillColor: _focusNode.hasFocus
            ? Colors.transparent
            : widget.fillColor ?? Colors.white,
        prefixIcon: widget.leftIcon != null ? Icon(widget.leftIcon) : null,
        suffixIcon: widget.rightIcon != null
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
                icon: Icon(
                  _isObscured ? Icons.visibility : Icons.visibility_off,
                ),
              )
            : null,
        labelText: widget.labelText,
        hintText: widget.hintText,
        border: const OutlineInputBorder(),
        prefixIconColor: const Color(0xFF302DA6),
        suffixIconColor: const Color(0xFF302DA6),
        labelStyle: const TextStyle(color: txtBlack),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Color(0xFF302DA6)),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          borderSide:
              BorderSide(color: widget.borderColor ?? Colors.transparent),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
