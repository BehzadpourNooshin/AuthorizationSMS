import 'dart:math';
import 'package:smsauth/screens/homescreen.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:http/http.dart' as http;
import 'package:smsauth/controllers/smscontroller.dart';
import 'package:smsauth/widgets/MyBTN.dart';
import 'package:smsauth/widgets/MyTextField.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smsauth/utils/extension.dart';

class SMSScreen extends StatefulWidget {
  const SMSScreen({super.key});

  @override
  State<SMSScreen> createState() => _SMSScreenState();
}

class _SMSScreenState extends State<SMSScreen> {
  bool isVisible = false;
  int activateCode = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('احراز هویت',
                  style: TextStyle(
                      fontSize: ScreenSize(context).screenWidth <= 1000
                          ? 14
                          : ScreenSize(context).screenWidth * 0.012)),
              centerTitle: true,
              elevation: 0,
              leading: const Icon(Icons.sms_outlined),
              backgroundColor: Colors.purple,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyTXTField(
                      controller: SMSController.phoneController,
                      myTitle: 'شماره تلفن همراه',
                      type: TextInputType.number,
                      errorText: 'شماره تلفن همراه را وارد نمایید!ً'),
                  const SizedBox(height: 10),
                  Visibility(
                      visible: isVisible,
                      child: MyTXTField(
                          controller: SMSController.activeCodeController,
                          type: TextInputType.number,
                          myTitle: 'کد فعال‌سازی',
                          errorText: 'کد فعال‌سازی را وارد نمایید!')),
                  const SizedBox(height: 10),
                  MyBTN(
                      title: isVisible ? 'ارسال کد' : 'فعال‌سازی',
                      onPressed: () async {
                        if (isVisible == false) {
                          if (SMSController.phoneController.text.isNotEmpty) {
                            setState(() {
                              isVisible = true;
                              activateCode = 10000 + Random().nextInt(89999);
                              print(activateCode);
                              Uri url = Uri.parse(
                                  'https://api.kavenegar.com/v1/2F58724E7938522F7648716A3472524C444A31776A493636394B593842455963696F56317474616C4244673D/verify/lookup.json?receptor=${SMSController.phoneController.text}&token=$activateCode&template=behzadpour&type=sms');
                              http.post(url);
                            });
                          } else {
                            CoolAlert.show(
                                context: context,
                                type: CoolAlertType.error,
                                width: 100,
                                text: "تلفن همراه را وارد نمایید!",
                                title: "خطا",
                                confirmBtnText: 'باشه',
                                confirmBtnColor: Colors.redAccent,
                                confirmBtnTextStyle: const TextStyle(
                                    fontSize: 16, color: Colors.white));
                          }
                        } else {
                          if (SMSController
                              .activeCodeController.text.isNotEmpty) {
                            if (activateCode.toString() ==
                                SMSController.activeCodeController.text) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()));

                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setBool('isActivate', true);
                              Future.delayed(const Duration(seconds: 10));
                            } else {
                              CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  width: 100,
                                  text: "مشکلی پیش آمده، اندکی بعد تلاش کنید!",
                                  title: "خطا",
                                  confirmBtnText: 'باشه',
                                  confirmBtnColor: Colors.redAccent,
                                  confirmBtnTextStyle: const TextStyle(
                                      fontSize: 16, color: Colors.white));
                            }
                          } else {
                            CoolAlert.show(
                                context: context,
                                type: CoolAlertType.error,
                                width: 100,
                                text: "کد فعال‌سازی را وارد نمایید!",
                                title: "خطا",
                                confirmBtnText: 'باشه',
                                confirmBtnColor: Colors.redAccent,
                                confirmBtnTextStyle: const TextStyle(
                                    fontSize: 16, color: Colors.white));
                          }
                        }
                      }),
                ],
              ),
            )));
  }
}
