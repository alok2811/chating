import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType inputType;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  const TextFieldWidget(
      {Key? key,
      required this.textEditingController,
      required this.hintText,
      this.suffixIcon,
      this.prefixIcon,
      this.inputType = TextInputType.text,
      this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: inputType,
      obscureText: obscureText,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        isDense: true,
        border: const OutlineInputBorder(),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
