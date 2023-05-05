import 'package:ecommerce_app/blocs/register/register_bloc.dart';
import 'package:ecommerce_app/repositories/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static const routeName = '/register';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const RegisterScreen(),
    );
  }

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  late RegisterBloc _registerBloc;

  @override
  void initState() {
    _registerBloc = RegisterBloc(
        authRepository: AuthRepository());
    emailController.addListener(_onEmailChanged);
    passwordController.addListener(_onPasswordChanged);
    confirmPasswordController.addListener(_onConfirmPasswordChanged);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Container(
            alignment: Alignment.center,
            color: Colors.black,
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 10,
            ),
            child: Text(
              'Register',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
      body: BlocListener<RegisterBloc, RegisterState>(
        bloc: _registerBloc,
        listener: (context, state) {
          if (state.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Register failure'),
                      Icon(Icons.error),
                    ],
                  ),
                ),
              );
          } else if (state.isSubmitting) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Registering...'),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
          } else if (state.isSuccess) {
            BlocProvider.of<AuthBloc>(context).add(LoggedIn());
            Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
          }
        },
        child: BlocBuilder<RegisterBloc, RegisterState>(
          bloc: _registerBloc,
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    cursorColor: Colors.black,
                    controller: emailController,
                    decoration: const InputDecoration(
                      iconColor: Colors.black,
                      icon: Icon(Icons.email),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.black),
                      focusedBorder: UnderlineInputBorder()
                    ),
                    autovalidateMode: AutovalidateMode.always,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isEmailValid ? 'Invalid Email' : null;
                    },
                  ),
                  TextFormField(
                    cursorColor: Colors.black,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      iconColor: Colors.black,
                      icon: Icon(Icons.lock),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.always,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isPasswordValid ? 'Invalid Password' : null;
                    },
                  ),
                  TextFormField(
                    cursorColor: Colors.black,
                    controller: confirmPasswordController,
                    decoration: const InputDecoration(
                      iconColor: Colors.black,
                      icon: Icon(Icons.lock),
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(color: Colors.black)
                    ),
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.always,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isPasswordValid ? 'Invalid Password' : null;
                    },
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                      onPressed: _onFormSubmitted, child: const Text('Register')),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _onEmailChanged() {
    _registerBloc.add(EmailChanged(email: emailController.text));
  }

  void _onPasswordChanged() {
    _registerBloc.add(PasswordChanged(password: passwordController.text));
  }

  void _onConfirmPasswordChanged() {}

  void _onFormSubmitted() {
    _registerBloc.add(Submitted(
        email: emailController.text, password: passwordController.text));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
