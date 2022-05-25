import 'package:client/about.dart';
import 'package:client/camera.dart';
import 'package:client/editor.dart';
import 'package:client/friends.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'opnsnap',
      routes: {
        '/camera': (context) => const CameraScreen(),
        '/about': (context) => const AboutScreen(),
        '/friends': (context) => FriendScreen(items: []),    // TODO: get friends correctly
      },
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ListItem> friends = [];

  @override
  void initState() {
    // TODO: Get friends from server
    friends = [
      MessageItem('Alice', 'Sent'),
      MessageItem('Bob', 'Received'),
      MessageItem('Charlie', 'Opened'),
      MessageItem('David', 'Sent'),
      MessageItem('Eve', 'Received'),
      MessageItem('Fred', 'Sent'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller =
        PageController(initialPage: 1 /* CameraScreen */);

    return Scaffold(
      appBar: AppBar(
        title: const Text("opnsnap"),
      ),
      body: PageView(
        controller: controller,
        children: [
          FriendScreen(items: friends),
          CameraScreen(),
          AboutScreen(),
        ],
      ),
    );
  }
}
