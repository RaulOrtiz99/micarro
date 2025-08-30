import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:micarro/src/core/repositories/auth_repository.dart';
import 'package:micarro/src/core/utils/go_router_refresh_stream.dart';
import 'package:micarro/src/core/services/notification_service.dart'; // <-- Importa el servicio
import 'package:micarro/src/features/auth/bloc/auth_bloc.dart';
import 'package:micarro/src/features/auth/bloc/session_state.dart';
import 'package:micarro/src/features/auth/presentation/pages/login_page.dart';
import 'package:micarro/src/features/company/presentation/pages/select_company_page.dart';
import 'package:micarro/src/features/home/presentation/pages/home_page.dart';

import 'src/features/products/pages/products_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(AuthRepository())),
        BlocProvider(create: (_) => SessionBloc()),
      ],
      child: Builder(
        builder: (context) {
          NotificationService.initialize(
            context,
          ); // <-- Inicializa el servicio aquí

          final router = GoRouter(
            initialLocation: "/login",
            refreshListenable: GoRouterRefreshStream(
              context.read<AuthBloc>().stream,
            ),
            redirect: (context, state) {
              final authState = context.read<AuthBloc>().state;
              final sessionState = context.read<SessionBloc>().state;

              if (!authState.isAuthenticated) {
                return "/login";
              }

              if (authState.companies.length > 1 &&
                  sessionState.selectedCompany == null) {
                return "/select-company";
              }

              if (authState.companies.length == 1 &&
                  sessionState.selectedCompany == null) {
                context.read<SessionBloc>().add(
                  SelectCompanyEvent(authState.companies.first),
                );
                return "/home";
              }

              return null;
            },
            routes: [
              GoRoute(path: "/login", builder: (_, __) => const LoginPage()),
              GoRoute(
                path: "/select-company",
                builder: (_, __) => const SelectCompanyPage(),
              ),
              GoRoute(path: "/home", builder: (_, __) => const HomePage()),
              GoRoute(
                path: "/products",
                builder: (context, state) {
                  final products = state.extra as List<String>? ?? [];
                  return ProductsPage(products: products);
                },
              ), // <-- Agrega la ruta de productos aquí
            ],
          );

          return MaterialApp.router(
            title: "POC Clean Architecture",
            routerConfig: router,
          );
        },
      ),
    );
  }
}
