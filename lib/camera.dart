import 'dart:io';
import 'package:client/editor.dart';
import 'package:client/friends.dart';
import 'package:client/main.dart';
import 'package:client/send.dart';
import 'package:flutter/material.dart';
import 'package:image_editor_dove/flutter_image_editor.dart' as image_editor;
import 'package:image_editor_dove/widget/editor_panel_controller.dart';
import 'package:image_picker/image_picker.dart';

//server
import 'package:http/http.dart' as http;

class CameraScreen extends StatefulWidget {
  final MessageItem? to;

  const CameraScreen({super.key, this.to});

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

  Future<void> toImageEditor(File origin) async {
    return Navigator.push(context, MaterialPageRoute(builder: (context) {
      return image_editor.ImageEditor(
        originImage: origin,
      );
    })).then((result) {
      if (result is image_editor.EditorImageResult) {
         setState(() {
            imageFile = result.newFile;
         });
      }
    }).catchError((er) {
      debugPrint(er);
    });
  }

  SnackBar snack(String msg){
    return SnackBar(
      content: Text(msg,
        style: const TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      width: 200,
      padding: const EdgeInsets.symmetric(
        vertical: 8.0, // Inner padding for SnackBar content.
        horizontal: 8.0,
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  _sendImage() {
    ScaffoldMessenger
        .of(context)
        .showSnackBar(snack("Sent 🚀"));
    Navigator.pop(context);

    if(imageFile != null){
      var url = Uri.parse('https://example.com/whatsit/create');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.to == null
            ? const Text('')
            : Row(
                children: [
                  const Text('To '),
                  widget.to!.buildTitle(context),
                ],
              ),
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
                    heroTag: "gallery_button",
                    child: const Icon(Icons.photo_library), // Or add_a_photo
                    onPressed: () {
                      _getFromGallery();
                    }),
                FloatingActionButton(
                    heroTag: "camera_button",
                    child: const Icon(Icons.camera_alt),
                    onPressed: () {
                      _getFromCamera();
                    })
              ],
            )
          : Wrap(
              children: [
                FloatingActionButton(
                    heroTag: "cancel_button",
                    child: const Icon(Icons.cancel),
                    onPressed: () {
                      setState(() {
                        imageFile = null;
                      });
                    }),
                FloatingActionButton(
                    heroTag: "edit_button",
                    child: const Icon(Icons.edit),
                    onPressed: () {
                      toImageEditor(imageFile!);
                    }),
                FloatingActionButton(
                    heroTag: "send_button",
                    child: const Icon(Icons.send),
                    onPressed: () {
                      _sendImage();
                    })
              ],
            ),
    );
  }
}
