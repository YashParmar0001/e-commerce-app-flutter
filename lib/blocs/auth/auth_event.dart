part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthUserChanged extends AuthEvent {
  const AuthUserChanged({required this.authUser, this.user});

  final auth.User? authUser;
  final User? user;

  @override
  List<Object?> get props => [authUser, user];

}
