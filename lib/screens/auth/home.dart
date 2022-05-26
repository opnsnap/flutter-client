import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client/bloc/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: Text(
              "Session information", style: TextStyle(color: Theme.of(context).colorScheme.primary)
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.exit_to_app_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  final authBloc = BlocProvider.of<AuthBloc>(context);
                  authBloc.add(SignOut());
                },
              ),
            ]),
        body: const UserInformation());
  }
}

class UserInformation extends StatelessWidget {
  const UserInformation({Key? key}) : super(key: key);

  
  Widget buildUserInformation(BuildContext context, AuthState state) {
    
        final currentState = state as AuthAuthenticated;
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Hello, User!",
                  style: TextStyle(fontSize: 20),
                ),
                const Text("Here is your ORY Kratos Session Token:",
                    style: TextStyle(fontSize: 20)),
                Container(
                  width: 350,
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2.0),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.deepOrange[50]!),
                  child: Center(
                      child: Text(currentState.token,
                          style: const TextStyle(fontSize: 17))),
                ),
                const Text("This is the id ORY Kratos assigned you:",
                    style: TextStyle(fontSize: 20)),
                Container(
                  width: 350,
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2.0),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.deepOrange[50]!),
                  child: Center(
                      child:
                          Text(currentState.id, style: const TextStyle(fontSize: 17))),
                ),
                const Text("This is the email adress you used:",
                    style: TextStyle(fontSize: 20)),
                Container(
                  width: 350,
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2.0),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.deepOrange[50]!),
                  child: Center(
                      child: Text(currentState.email,
                          style: const TextStyle(fontSize: 17))),
                ),
              ],
            ),
          ),
        );
  }

  Widget buildError(BuildContext context) {
    return Center(child: Icon(Icons.error, size: 50,color: Theme.of(context).colorScheme.primary,),);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if(state.message == null) {
        return buildUserInformation(context, state);
      } else { //if there is an error message, return an error widget 
        return buildError(context);
      }
    });
  }
}
