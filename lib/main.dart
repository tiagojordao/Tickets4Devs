import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tickets4devs/db/FirebaseNotificationService.dart';
import 'package:tickets4devs/notifiers/UserNotifier.dart';
import 'package:tickets4devs/notifiers/WalletNotifier.dart';
import 'package:tickets4devs/notifiers/Cart.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tickets4devs/routes/Routes.dart';


void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Passa o contexto do root do app para o serviço de notificações
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => UserNotifier()),
        ChangeNotifierProvider(create: (context) => WalletNotifier()),
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
      ),
    );
  }
}