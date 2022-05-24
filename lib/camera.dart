import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? imageFile;

  /// Get from gallery
  _getFromGallery() async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 10, bottom: 80),
          child: imageFile == null
              ? const Text("No image selected")
              : Image.file(
                  imageFile!,
                  fit: BoxFit.cover,
                )),
      floatingActionButton: imageFile == null
          ? Wrap(
              children: [
                FloatingActionButton(
                    child: const Icon(Icons.ad_units), // Or add_a_photo
                    onPressed: () {
                      _getFromGallery();
                    }),
                FloatingActionButton(
                    child: const Icon(Icons.camera),
                    onPressed: () {
                      _getFromCamera();
                    })
              ],
            )
          : Wrap(
              children: [
                FloatingActionButton(
                    child: const Icon(Icons.cancel),
                    onPressed: () {
                      setState(() {
                        imageFile = null;
                      });
                    }),
                FloatingActionButton(
                    child: const Icon(Icons.edit),
                    onPressed: () {
                      // TODO: Go to edit screen
                    }),
                FloatingActionButton(
                    child: const Icon(Icons.send),
                    onPressed: () {
                      // TODO: Send image
                    })
              ],
            ),
    );
  }
}
