import 'package:client/app.dart';
import 'package:client/screens/about.dart';
import 'package:client/bloc/auth_bloc.dart';
import 'package:client/screens/camera.dart';
import 'package:client/screens/friends.dart';
import 'package:client/services/auth_service.dart';
import 'package:client/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  final secureStorage = SecureStorage();
  final authService = AuthService();

  runApp(BlocProvider(
    create: (context) =>
        AuthBloc(secureStorage: secureStorage, authService: authService)
          ..add(StartApp()),
  ));
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
        '/friends': (context) => FriendScreen(items: []),
        // TODO: get friends correctly
      },
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const AppWrapper(),
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
