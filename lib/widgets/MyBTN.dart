import 'package:flutter/material.dart';
import 'package:smsauth/utils/extension.dart';

class MyBTN extends StatelessWidget {
  final String title;

  final Function() onPressed;
  const MyBTN({
    required this.title,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
            style: TextButton.styleFrom(
                backgroundColor: Colors.purple, elevation: 0),
            onPressed: onPressed,
            child: Text(title,
                style: TextStyle(
                  fontSize: (ScreenSize(context).screenWidth < 1000)
                      ? 13
                      : ScreenSize(context).screenWidth * 0.013,
                ))));
  }
}
