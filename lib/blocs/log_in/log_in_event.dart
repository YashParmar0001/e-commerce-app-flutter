part of 'log_in_bloc.dart';

abstract class LogInEvent extends Equatable {
  const LogInEvent();

  @override
  List<Object?> get props => [];
}

class EmailChanged extends LogInEvent {
  EmailChanged({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends LogInEvent {
  PasswordChanged({required this.password});

  final String password;

  @override
  List<Object?> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

// class Submitted extends LogInEvent {
//   Submitted({required this.email, required this.password});
//
//   final String email;
//   final String password;
//
//   @override
//   List<Object?> get props => [email, password];
//
//   @override
//   String toString() {
//     return 'Submitted { email: $email, password: $password }';
//   }
// }

class LogInWithGooglePressed extends LogInEvent {
  @override
  String toString() => 'LogInWithGooglePressed';
}

class LogInWithCredentialsPressed extends LogInEvent {
  LogInWithCredentialsPressed({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];

  @override
  String toString() {
    return 'LoginWithCredentialsPressed { email: $email, password: $password }';
  }
}
