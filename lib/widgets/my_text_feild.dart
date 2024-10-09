import 'package:flutter/material.dart';

class MyTextFeild extends StatelessWidget {
  const MyTextFeild({
    Key? key,
    required this.hint,
    this.keyboardType,
    this.onChanged,
    this.obscureText,
  }) : super(key: key);

  final String hint;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      validator: (value) {
        if (value!.isEmpty) return 'This feild can not be empty!';
        return null;
      },
      keyboardType: keyboardType ?? TextInputType.visiblePassword,
      onChanged: onChanged ?? (value) {},
      decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white)),
    );
  }
}
