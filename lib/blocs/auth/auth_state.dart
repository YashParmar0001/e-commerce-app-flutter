part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState._(
      {this.status = AuthStatus.unknown, this.authUser, this.user});

  final AuthStatus status;
  final auth.User? authUser;
  final User? user;

  const AuthState.unknown() : this._();

  const AuthState.authenticated(
      {required auth.User authUser, required User user})
      : this._(
          status: AuthStatus.authenticated,
          authUser: authUser,
          user: user,
        );

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  @override
  List<Object?> get props => [status, authUser, user];
}

enum AuthStatus { unknown, authenticated, unauthenticated }
