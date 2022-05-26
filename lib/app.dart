import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client/bloc/auth_bloc.dart';
import 'package:client/screens/auth/launch.dart';
import 'package:client/screens/auth/home.dart';
import 'package:client/screens/auth/sign_in.dart';
import 'package:client/screens/auth/sign_up.dart';

class AppWrapper extends StatelessWidget {
  const AppWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is! AuthUninitialized) {
        if (state.message != null) {
          // if there is a general error, show it in a snack bar
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message!)));
        }
      }
    }, builder: (context, state) {
      if (state is AuthUninitialized) {
        // initial state when the app isn't fully started.
        return const LaunchScreen();
      } else if (state is AuthLoading) {
        // loading, show spinner
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      } else if (state is AuthUnauthenticated) {
        // user is not authenticated,  initialize login flow
        final authBloc = BlocProvider.of<AuthBloc>(context);
        authBloc.add(InitLoginFlow());
      } else if (state is AuthRegistrationInitialized) {
        // registration flow is initialized, show sign up screen
        return const SignUpScreen();
      } else if (state is AuthLoginInitialized) {
        // login flow is initialized, show sign in screen
        return const SignInScreen();
      } else if (state is AuthAuthenticated) {
        // user is logged in, show home screen
        return const HomeScreen();
      }

      // default screen
      return const LaunchScreen();
    });
  }
}
