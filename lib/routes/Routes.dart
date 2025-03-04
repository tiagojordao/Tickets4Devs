// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tickets4devs/screens/EditEvent.dart';
import 'package:tickets4devs/screens/EventsAvailable.dart';
import 'package:tickets4devs/screens/FirstScreen.dart';
import 'package:tickets4devs/screens/HomeScreen.dart';
import 'package:tickets4devs/screens/LoginScreen.dart';
import 'package:tickets4devs/screens/CreateEventPage.dart';
import 'package:tickets4devs/screens/QRCodeScannerScreen.dart';
import 'package:tickets4devs/screens/SignUpScreen.dart';
import 'package:tickets4devs/screens/UserProfileScreen.dart';
import 'package:tickets4devs/screens/CartPage.dart';
import 'package:tickets4devs/screens/WalletScreen.dart';

final GoRouter myRouter = GoRouter(routes: <RouteBase>[
  GoRoute(
    path: '/',
    builder: (BuildContext context, GoRouterState state) {
      return FirstScreenPage();
    },
  ),
  GoRoute(
    path: '/home',
    builder: (BuildContext context, GoRouterState state) {
      return HomeScreen();
    },
  ),
  GoRoute(
    path: '/wallet',
    builder: (BuildContext context, GoRouterState state) {
      return WalletScreen();
    },
  ),
  GoRoute(
    path: '/signup',
    builder: (BuildContext context, GoRouterState state) {
      return SignUpScreen();
    },
  ),
  GoRoute(
    path: '/search',
    builder: (BuildContext context, GoRouterState state) {
      return EventsAvailable();
    },
  ),
  GoRoute(
    path: '/login',
    builder: (BuildContext context, GoRouterState state) {
      return LoginScreen();
    },
  ),
  GoRoute(
    path: '/create_event',
    builder: (BuildContext context, GoRouterState state) {
      return CreateEventPage();
    },
  ),
  GoRoute(
    path: '/profile',
    builder: (BuildContext context, GoRouterState state) {
      return UserProfileScreen();
    },
  ),
  GoRoute(
    path: '/cart',
    builder: (BuildContext context, GoRouterState state) {
      return CartScreen();
    },
  ),
  GoRoute(
      path: '/edit-event',
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        return EditEvent(
          eventId: args['eventId'],
          date: args['date'],
          price: args['price'],
          title: args['title'],
          localId: args['localId'],
          descricao: args['descricao'],
        );
      },
    ),
    GoRoute(
      path: '/qrCodeScanner',
      builder: (BuildContext context, GoRouterState state) {
        return QRCodeScannerScreen();
      }
    ),
]);
