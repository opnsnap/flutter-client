import 'package:client/camera.dart';
import 'package:client/friends.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'opnsnap',
      initialRoute: '/',
      routes: {
        '/': (context) => const CameraScreen(),
        '/about': (context) => const FriendScreen(),
        '/friends': (context) => const FriendScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
    );
  }
}
