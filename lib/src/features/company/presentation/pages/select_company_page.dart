import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/bloc/auth_bloc.dart';
import '../../../auth/bloc/session_state.dart'
    show SessionBloc, SelectCompanyEvent;

class SelectCompanyPage extends StatelessWidget {
  const SelectCompanyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final companies = context.watch<AuthBloc>().state.companies;
    final sessionBloc = context.read<SessionBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text('Selecciona Empresa')),
      body: ListView.builder(
        itemCount: companies.length,
        itemBuilder: (context, index) {
          final company = companies[index];
          return ListTile(
            title: Text(company.name),
            onTap: () {
              sessionBloc.add(SelectCompanyEvent(company));
            },
          );
        },
      ),
    );
  }
}
