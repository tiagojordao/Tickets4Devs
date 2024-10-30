import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tickets4devs/screens/EventsAvailable.dart';
import 'package:tickets4devs/screens/LoginScreen.dart';
import 'package:tickets4devs/screens/CreateEventPage.dart';
import 'package:tickets4devs/screens/SignUpScreen.dart';
import 'package:tickets4devs/screens/UserProfileScreen.dart';

final GoRouter myRouter = GoRouter(routes: <RouteBase>[
  GoRoute(
    path: '/',
    builder: (BuildContext context, GoRouterState state) {
      return LoginScreen(); // Tela inicial, pode ser alterada para uma tela de boas-vindas
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
      return CreateEventPage(); // Nova rota para criação de evento
    },
  ),
  GoRoute(
    path: '/profile',
    builder: (BuildContext context, GoRouterState state) {
      return UserProfileScreen(
        name: "Nome do Usuário Teste",
        email: "usuarioteste@email.com",
      );
    },
  ),
]);
