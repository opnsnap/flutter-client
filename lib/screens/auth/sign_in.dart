import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client/bloc/auth_bloc.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: SignInForm());
  }
}

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  Widget buildSignInForm(BuildContext context, AuthState state) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final authState = state as AuthLoginInitialized;
        return Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Wrap(
                          runAlignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runSpacing: 25,
                          children: <Widget>[
                            const Center(
                                child: Text(
                              "Sign in with ORY",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 40),
                            )),
                            TextFormField(
                              initialValue: authState.email,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                errorText: authState.emailError == ""
                                  ? null
                                  : authState.emailError,
                              errorMaxLines: 2,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: "Email"),
                                   onChanged: (val) => authBloc.add(ChangeField(val, "email")), //every time an input changes, call an event and change the state
                            ),
                            TextFormField(
                              initialValue: authState.password,
                              obscureText: true,
                              decoration: InputDecoration(
                                errorText: authState.passwordError == ""
                                  ? null
                                  : authState.passwordError,
                              errorMaxLines: 2,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: "Password"),
                                   onChanged: (val) => authBloc.add(ChangeField(val, "password")), //every time an input changes, call an event and change the state
                            ),
                            if (state.generalError != "") //show error message if there is any
                              Text(
                                state.generalError,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.red),
                              ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => authBloc.add(SignIn(
                                    authState.flowId,
                                    authState.email, authState.password)),
                                child: const Text("Sign in"),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        TextButton(
                            onPressed: () =>
                                authBloc.add(InitRegistrationFlow()),
                            child: const Text(
                              "Sign up.",
                            ))
                      ])
                ],
              ),
            ),
          ),
        );  
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return buildSignInForm(context, state);
      },
    );
  }
}
