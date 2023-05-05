import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';

import 'dart:developer' as dev;

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static const routeName = '/auth_';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const AuthScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Uninitialized) {
          dev.log('Uninitialized State', name: 'AuthState');
        } else if (state is UnAuthenticated) {
          Navigator.pushReplacementNamed(context, 'login');
        } else if (state is Authenticated) {
          dev.log('Authenticated state in AuthScreen, Going home screen');
          Navigator.pushReplacementNamed(context, '/home');
        }else {
          dev.log('Unknown state', name: 'AuthState');
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              Text('Please wait while We are logging you in...'),
            ],
          ),
        ),
      ),
    );
  }
}
