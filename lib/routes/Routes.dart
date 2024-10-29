import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:tickets4devs/screens/EventsAvailable.dart';
import 'package:tickets4devs/screens/LoginScreen.dart';
import 'package:tickets4devs/screens/CreateEventPage.dart';

final GoRouter myRouter = GoRouter(routes: <RouteBase>[
  GoRoute(
    path: '/',
    builder: (BuildContext context, GoRouterState state) {
      return LoginScreen(); /*alterar depois para inicial */
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
      return CreateEventPage(); // Nova rota para criação de evento
    },
  ),
]);
