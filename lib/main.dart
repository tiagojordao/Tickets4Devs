// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tickets4devs/routes/Routes.dart';
import 'package:provider/provider.dart';
import 'package:tickets4devs/models/Cart.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Cart(), 
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: myRouter,
      title: 'Tickets4Devs',
      theme: ThemeData(
        primaryColor: Color(0xFFdbfc3b),
        primaryColorLight: Color(0xFFfefefe),
        scaffoldBackgroundColor: Color(0xFF030303),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFdbfc3b),
          foregroundColor: Color(0xFF030303),
        ),
        textTheme: TextTheme(
          bodySmall: TextStyle(fontSize: 16.0),
          bodyMedium: TextStyle(fontSize: 20.0),
          bodyLarge: TextStyle(fontSize: 24.0),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFdbfc3b),
          foregroundColor: Color(0xFF030303),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFFdbfc3b),
          textTheme: ButtonTextTheme.primary,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0xFFdbfc3b),
          secondary: Color(0xFF030303),
        ),
      ),
    );
  }
}