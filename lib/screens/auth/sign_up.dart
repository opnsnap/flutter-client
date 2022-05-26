import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client/bloc/auth_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: SignUpForm());
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  Widget buildSignUpForm(context, state) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final authState = authBloc.state as AuthRegistrationInitialized;

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
                          "Sign up with ORY",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 40),
                        )),
                        TextFormField(
                          initialValue: authState.email,
                          decoration: InputDecoration(
                              errorText: authState.emailError == ""
                                  ? null
                                  : authState.emailError,
                              errorMaxLines: 2,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: "Email"),
                          onChanged: (val) =>
                              authBloc.add(ChangeField(val, "email")), //every time an input changes, call an event and change the state
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
                          onChanged: (val) =>
                              authBloc.add(ChangeField(val, "password")), //every time an input changes, call an event and change the state
                        ),
                        if (authState.generalError != "") //show error message if there is any
                          Text(
                            authState.generalError,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.red),
                          ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => authBloc.add(SignUp(
                                authState.flowId,
                                authState.email,
                                authState.password)),
                            child: const Text("Sign Up"),
                          ),
                        ),
                      ]),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    TextButton(
                        onPressed: () => authBloc.add(InitLoginFlow()),
                        child: const Text(
                          "Sign in.",
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
        return buildSignUpForm(context, state);
      },
    );
  }
}
