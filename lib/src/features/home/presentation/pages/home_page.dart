import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/bloc/session_state.dart' show SessionBloc;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final company = context.watch<SessionBloc>().state.selectedCompany;
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Text('Bienvenido a ${company?.name ?? "la empresa"}'),
      ),
    );
  }
}
