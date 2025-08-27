import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/user.dart';
import '../../../core/repositories/auth_repository.dart';

class AuthState {
  final bool isAuthenticated;
  final User? user;

  AuthState({required this.isAuthenticated, this.user});

  List get companies => user?.companies ?? [];
}

class AuthEvent {
  final String username;
  AuthEvent(this.username);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc(this.repository) : super(AuthState(isAuthenticated: false)) {
    on<AuthEvent>((event, emit) async {
      final user = await repository.login(event.username);
      emit(AuthState(isAuthenticated: user != null, user: user));
    });
  }
}