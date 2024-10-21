import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:tickets4devs/screens/LoginScreen.dart';

final GoRouter myRouter = GoRouter(
  routes: <RouteBase>[
  GoRoute(
    path: '/',
    builder: (BuildContext context, GoRouterState state) {
      return LoginScreen();
    },
    // routes: <RouteBase>[
    //   GoRoute(
    //     path: 'details',
    //     builder: (BuildContext context, GoRouterState state) {
    //       final tarefa = state.extra as Tarefa;
    //       return TaskDetail( tarefa: tarefa,);
    //     },
    //   ),
    // ],
  ),
]);
