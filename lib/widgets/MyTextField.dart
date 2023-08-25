import 'package:flutter/material.dart';
import 'package:smsauth/utils/extension.dart';

class MyTXTField extends StatelessWidget {
  final String myTitle;
  final TextInputType type;
  final TextEditingController controller;
  final String errorText;
  final bool isEnable;
  const MyTXTField(
      {super.key,
      required this.controller,
      required this.myTitle,
      this.type = TextInputType.text,
      this.isEnable = true,
      required this.errorText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // validator: (value) {
      //   (value==null || value.isEmpty)?return errorText:return null;
      //   };
      validator: (value) {
        if (value == null || value.isEmpty) return errorText;
        return null;
      },
      enabled: isEnable,
      controller: controller,
      keyboardType: type,
      cursorColor: Colors.grey.shade300,
      decoration: InputDecoration(
        hintText: myTitle,
        hintStyle: TextStyle(
          fontSize: (ScreenSize(context).screenWidth < 1000)
              ? 13
              : ScreenSize(context).screenWidth * 0.013,
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300)),
      ),
    );
  }
}
