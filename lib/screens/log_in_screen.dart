import 'package:ecommerce_app/blocs/log_in/log_in_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  static const routeName = 'login';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const LogInScreen(),
    );
  }

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  late LogInBloc _logInBloc;

  @override
  void initState() {
    _logInBloc = BlocProvider.of<LogInBloc>(context);
    emailController.addListener(_onEmailChanged);
    passwordController.addListener(_onPasswordChanged);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Container(
            alignment: Alignment.center,
            color: Colors.black,
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 10,
            ),
            child: Text(
              'Log In',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
      body: BlocListener<LogInBloc, LogInState>(
        bloc: BlocProvider.of<LogInBloc>(context),
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
                      Text('Log In failure'),
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
                      Text('Logging in...'),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
          } else if (state.isSuccess) {
            BlocProvider.of<AuthBloc>(context).add(LoggedIn());
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
        child: BlocBuilder(
          bloc: _logInBloc,
          builder: (BuildContext context, LogInState state) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    cursorColor: Colors.black,
                    controller: emailController,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(),
                      icon: Icon(Icons.email),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.black),
                      iconColor: Colors.black
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
                      icon: Icon(Icons.lock),
                      labelText: 'Password',
                      focusedBorder: UnderlineInputBorder(),
                      labelStyle: TextStyle(color: Colors.black),
                      iconColor: Colors.black
                    ),
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.always,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isPasswordValid ? 'Invalid Password' : null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      onPressed: _onFormSubmitted,
                      child: const Text('Log In')),
                  TextButton(
                      style: TextButton.styleFrom(
                          textStyle: const TextStyle(color: Colors.black)),
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text('Create an Account', style: TextStyle(color: Colors.black),)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _onEmailChanged() {
    _logInBloc.add(EmailChanged(email: emailController.text));
  }

  void _onPasswordChanged() {
    _logInBloc.add(PasswordChanged(password: passwordController.text));
  }

  void _onFormSubmitted() {
    _logInBloc.add(LogInWithCredentialsPressed(
        email: emailController.text, password: passwordController.text));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
