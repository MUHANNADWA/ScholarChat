import 'package:flutter/material.dart';

class MyTextFeild extends StatefulWidget {
  MyTextFeild({
    Key? key,
    required this.hint,
    this.keyboardType,
    this.onChanged,
  }) : super(key: key);

  final String hint;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;

  @override
  State<MyTextFeild> createState() => _MyTextFeildState();
}

class _MyTextFeildState extends State<MyTextFeild> {
  bool obscureText = true;
  Color eyeColor = const Color.fromARGB(100, 255, 255, 255);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.hint != 'Password' ? false : obscureText,
      validator: (value) {
        if (value!.isEmpty) return 'This feild can not be empty!';
        return null;
      },
      keyboardType: widget.keyboardType ?? TextInputType.visiblePassword,
      onChanged: widget.onChanged ?? (value) {},
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        hintText: widget.hint,
        hintStyle: const TextStyle(color: Colors.white),
        suffixIcon: widget.hint == 'Password'
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                    if (eyeColor == const Color.fromARGB(100, 255, 255, 255)) {
                      eyeColor = Colors.white;
                    } else {
                      eyeColor = const Color.fromARGB(100, 255, 255, 255);
                    }
                  });
                },
                icon: const Icon(Icons.remove_red_eye_rounded),
                color: eyeColor,
              )
            : const SizedBox(),
      ),
    );
  }
}
