import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final String? hintText, labelText;
  final TextInputType? keyboardType;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.validator,
    this.hintText,
    this.labelText,
    this.keyboardType,
    this.leftIcon,
    this.rightIcon,
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
      cursorColor: Colors.black,
      controller: widget.controller,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      validator: widget.validator,
      focusNode: _focusNode,
      onTapOutside: (focusNode) {
        setState(() {
          _focusNode.unfocus();
        });
      },
      obscureText: widget.rightIcon != null ? _isObscured : false,
      decoration: InputDecoration(
        filled: true,
        fillColor:
            _focusNode.hasFocus ? Colors.transparent : const Color(0xFFE5EBED),
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
        prefixIconColor: Colors.black,
        suffixIconColor: Colors.black,
        labelStyle: const TextStyle(color: Colors.black),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.black),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.red),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
