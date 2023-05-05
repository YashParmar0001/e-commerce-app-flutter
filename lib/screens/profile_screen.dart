import 'package:ecommerce_app/blocs/auth/auth_bloc.dart';
import 'package:ecommerce_app/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const routeName = '/profile';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ProfileScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          Navigator.pushNamedAndRemoveUntil(
              context, 'login', (Route<dynamic> route) => false);
        }
      },
      child: Scaffold(
          appBar: const CustomAppBar(
            title: 'Profile',
          ),
          body: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is Uninitialized) {
                return const CircularProgressIndicator();
              } else if (state is UnAuthenticated) {
                return const Center(
                  child: Text('Please Log in first'),
                );
              } else if (state is Authenticated) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Text('Email: ${state.email}'),
                          ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<AuthBloc>(context)
                                    .add(LoggedOut());
                              },
                              child: const Text('Log out')),
                        ],
                      ),
                    )
                  ],
                );
              } else {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }
            },
          )),
    );
  }
}
