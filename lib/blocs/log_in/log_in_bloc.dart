import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/repositories/auth/auth_repository.dart';
import 'package:equatable/equatable.dart';

import '../../utils/validators.dart';

part 'log_in_event.dart';
part 'log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  LogInBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(LogInState.empty()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LogInWithGooglePressed>(_onLogInWithGooglePressed);
    on<LogInWithCredentialsPressed>(_onLogInWithCredentialPressed);
  }

  final AuthRepository _authRepository;

  void _onEmailChanged(EmailChanged event, Emitter<LogInState> emit) {
    emit(state.update(isEmailValid: Validators.isValidEmail(event.email)));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LogInState> emit) {
    emit(state.update(
        isPasswordValid: Validators.isValidPassword(event.password)));
  }

  Future<void> _onLogInWithGooglePressed(
      LogInWithGooglePressed event, Emitter<LogInState> emit) async {
    try {
      await _authRepository.signInWithGoogle();
      emit(LogInState.success());
    } catch (_) {
      emit(LogInState.failure());
    }
  }

  Future<void> _onLogInWithCredentialPressed(
      LogInWithCredentialsPressed event, Emitter<LogInState> emit) async {
    try {
      await _authRepository.signInWithCredentials(event.email, event.password);
      emit(LogInState.success());
    } catch (_) {
      emit(LogInState.failure());
    }
  }
}