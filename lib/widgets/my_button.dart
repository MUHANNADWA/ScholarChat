import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.text,
    required this.onTap,
    required this.textColor,
  }) : super(key: key);

  final String text;
  final Color textColor;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: onTap,
            style: ButtonStyle(
              elevation: const WidgetStatePropertyAll(0.0),
              shadowColor: const WidgetStatePropertyAll(Colors.transparent),
              padding: const WidgetStatePropertyAll(EdgeInsets.all(12.0)),
              backgroundColor: const WidgetStatePropertyAll(Colors.white),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
