// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tickets4devs/routes/Routes.dart';

void main(){
    runApp(MaterialApp.router(
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
    ),
    );
}
