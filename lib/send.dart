// NOT USED SO FAR

import 'dart:io';
import 'package:client/friends.dart';
import 'package:flutter/material.dart';

class SendScreen extends StatefulWidget {
  final File? image;

  const SendScreen({super.key, this.image});

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:const Text('Send Screen'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 10, bottom: 80),
          child: Text("Test"),
        ),
        floatingActionButton: Wrap(
          children: [
            FloatingActionButton(
                heroTag: "other_button",
                child: const Icon(Icons.accessible), // Or add_a_photo
                onPressed: () {}),
            FloatingActionButton(
                heroTag: "send_button",
                child: const Icon(Icons.send_sharp),
                onPressed: () {})
          ],
        )
    );
  }
}