import 'package:client/about.dart';
import 'package:client/camera.dart';
import 'package:client/editor.dart';
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
      routes: {
        '/camera': (context) => const CameraScreen(),
        '/about': (context) => const AboutScreen(),
        '/friends': (context) => FriendScreen(items: List<ListItem>.generate(
          1000,
              (i) => i % 6 == 0
              ? HeadingItem('Heading $i')
              : MessageItem('Sender $i', 'Message body $i'),
        ),),
      },
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 1 /* CameraScreen */);

    return Scaffold(
      appBar: AppBar(
        title: const Text("opnsnap"),
      ),
      body: PageView(
        controller: controller,
        children: [
          FriendScreen(items: List<ListItem>.generate(
            1000,
                (i) => i % 6 == 0
                ? HeadingItem('Heading $i')
                : MessageItem('Sender $i', 'Message body $i'),
          ),),
          CameraScreen(),
          AboutScreen(),
        ],
      ),
    );
  }
}
