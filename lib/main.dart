import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:simple_counter/controllers/app_controller.dart';
import 'package:simple_counter/pages/app_page.dart';

void main() {
  runApp(GetMaterialApp(
    theme: ThemeData(
      primaryColor: Colors.grey[900],
      scaffoldBackgroundColor: Colors.white,
    ),
    initialRoute: '/',
    debugShowCheckedModeBanner: false,
    getPages: [
      GetPage(
          name: '/',
          page: () => AppPage(),
          binding: BindingsBuilder(() {
            Get.put(AppController());
          })),
    ],
    supportedLocales: [
      const Locale('ko', 'KR'),
      const Locale('en', 'US'),
    ],
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
    ],
  ));
}
