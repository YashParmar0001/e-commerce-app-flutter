import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/auth/auth_repository.dart';
import '../../utils/validators.dart';

import 'dart:developer' as dev;

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(RegisterState.empty()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<Submitted>(_onSubmitted);
  }

  final AuthRepository _authRepository;

  void _onEmailChanged(EmailChanged event, Emitter<RegisterState> emit) {
    emit(state.update(isEmailValid: Validators.isValidEmail(event.email)));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<RegisterState> emit) {
    emit(state.update(isPasswordValid: Validators.isValidPassword(event.password)));
  }

  Future<void> _onSubmitted(Submitted event, Emitter<RegisterState> emit) async {
    emit(RegisterState.loading());
    try {
      dev.log('Signing up from repository', name: 'Register');
      await _authRepository.signUp(email: event.email, password: event.password);
      emit(RegisterState.success());
    }catch(_) {
      emit(RegisterState.failure());
    }
  }
}