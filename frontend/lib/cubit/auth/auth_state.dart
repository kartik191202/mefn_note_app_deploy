part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}
final class AuthAuthenticated extends AuthState {

  final String uid;

  AuthAuthenticated(this.uid);

  @override
  List<Object> get props => [uid];
}

final class AuthUnAuthenticated extends AuthState {

  @override
  List<Object> get props => [];
}