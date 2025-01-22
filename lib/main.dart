import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tickets4devs/db/FirebaseNotificationService.dart';
import 'package:tickets4devs/notifiers/UserNotifier.dart';
import 'package:tickets4devs/notifiers/WalletNotifier.dart';
import 'package:tickets4devs/notifiers/LocationNotifier.dart';
import 'package:tickets4devs/notifiers/Cart.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tickets4devs/routes/Routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => UserNotifier()),
        ChangeNotifierProvider(create: (context) => WalletNotifier()),
        ChangeNotifierProvider(create: (context) => LocationNotifier()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseNotificationService().initialize(context);

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
          backgroundColor: Color(0xFFDBFC3B),
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
