import 'dart:io';
import 'package:client/editor.dart';
import 'package:flutter/material.dart';
import 'package:image_editor_dove/flutter_image_editor.dart' as image_editor;
import 'package:image_editor_dove/widget/editor_panel_controller.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class CustomImageEditor extends image_editor.ImageEditorDelegate {
  @override
  Widget addTextWidget(double limitSize, OperateType type,
      {required bool choosen}) {
    throw UnimplementedError();
  }

  @override
  Widget backBtnWidget(double limitSize) {
    // TODO: implement backBtnWidget
    throw UnimplementedError();
  }

  @override
  // TODO: implement boldTagWidget
  Widget get boldTagWidget => throw UnimplementedError();

  @override
  // TODO: implement brushColors
  List<Color> get brushColors => throw UnimplementedError();

  @override
  Widget brushWidget(double limitSize, OperateType type,
      {required bool choosen}) {
    // TODO: implement brushWidget
    throw UnimplementedError();
  }

  @override
  Widget doneWidget(BoxConstraints constraints) {
    // TODO: implement doneWidget
    throw UnimplementedError();
  }

  @override
  Widget flipWidget(double limitSize, OperateType type,
      {required bool choosen}) {
    // TODO: implement flipWidget
    throw UnimplementedError();
  }

  @override
  Widget mosaicWidget(double limitSize, OperateType type,
      {required bool choosen}) {
    // TODO: implement mosaicWidget
    throw UnimplementedError();
  }

  @override
  // TODO: implement resetWidget
  Widget get resetWidget => throw UnimplementedError();

  @override
  Widget rotateWidget(double limitSize, OperateType type,
      {required bool choosen}) {
    // TODO: implement rotateWidget
    throw UnimplementedError();
  }

  @override
  // TODO: implement sliderLeftWidget
  Widget get sliderLeftWidget => throw UnimplementedError();

  @override
  // TODO: implement sliderRightWidget
  Widget get sliderRightWidget => throw UnimplementedError();

  @override
  SliderThemeData sliderThemeData(BuildContext context) {
    // TODO: implement sliderThemeData
    throw UnimplementedError();
  }

  @override
  // TODO: implement textColors
  List<Color> get textColors => throw UnimplementedError();

  @override
  // TODO: implement textConfigModel
  image_editor.TextConfigModel get textConfigModel =>
      throw UnimplementedError();

  @override
  // TODO: implement textSelectedBorder
  Border get textSelectedBorder => throw UnimplementedError();

  @override
  Widget undoWidget(double limitSize) {
    // TODO: implement undoWidget
    throw UnimplementedError();
  }
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
      image_editor.ImageEditor.uiDelegate = CustomImageEditor();

      return image_editor.ImageEditor(
        originImage: origin,
      );
    })).then((result) {
      if (result is image_editor.EditorImageResult) {
        // setState(() {
        //   _image = result.newFile;
        // });
      }
    }).catchError((er) {
      debugPrint(er);
    });
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
                    heroTag: "gallery_button",
                    child: const Icon(Icons.ad_units), // Or add_a_photo
                    onPressed: () {
                      _getFromGallery();
                    }),
                FloatingActionButton(
                    heroTag: "camera_button",
                    child: const Icon(Icons.camera),
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
                      // TODO: Send image
                    })
              ],
            ),
    );
  }
}
