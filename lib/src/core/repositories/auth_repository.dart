import '../models/user.dart';
import '../models/company.dart';

class AuthRepository {
  // Simulación de usuarios hardcodeados
  final List<User> _users = [
    User(
      id: '1',
      name: 'Usuario Uno',
      companies: [Company(id: 'c1', name: 'Empresa Única')],
    ),
    User(
      id: '2',
      name: 'Usuario Dos',
      companies: [
        Company(id: 'c2', name: 'Empresa A'),
        Company(id: 'c3', name: 'Empresa B'),
      ],
    ),
  ];

  Future<User?> login(String username) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _users.where((u) => u.name == username).isNotEmpty
        ? _users.firstWhere((u) => u.name == username)
        : null;
  }
}
