import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FirebaseNotificationService {
  final messaging = FirebaseMessaging.instance;

  Future<void> initialize(BuildContext context) async {
    await messaging.requestPermission();

    final FCMToken = await messaging.getToken();
    print('Token de usuário: $FCMToken');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print('Mensagem recebida: ${message.notification!.title}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Mensagem clicada!');
      _navigateToHomeScreen(context);
    });

    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      print('App aberto diretamente da notificação');
      _navigateToHomeScreen(context);
    }
  }

  void _navigateToHomeScreen(BuildContext context) {
    try {
      GoRouter.of(context).go('/home');
    } catch (e) {
      print(e);
    }
  }
}