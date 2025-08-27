import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micarro/src/features/auth/bloc/auth_bloc.dart';
import '../bloc/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                authBloc.add(AuthEvent('Usuario Uno'));
              },
              child: const Text('Login Usuario Uno'),
            ),
            ElevatedButton(
              onPressed: () {
                authBloc.add(AuthEvent('Usuario Dos'));
              },
              child: const Text('Login Usuario Dos'),
            ),
          ],
        ),
      ),
    );
  }
}
