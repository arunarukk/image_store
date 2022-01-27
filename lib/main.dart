import 'package:flutter/material.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'dart:io';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image;

  List<File?> imageList = [];
  final imagePicker = ImagePicker();
  Future getImage() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
      GallerySaver.saveImage(_image!.path);
      imageList.add(_image);
      print(_image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Camera"),
      ),
      body:
          // GridView.count(
          //   crossAxisCount: 3,
          //   crossAxisSpacing: 4.0,
          //   mainAxisSpacing: 8.0,
          //   children: List.generate(imageList.length, (index) {
          //     return Image.file(imageList[index]!);
          //   }),
          // ),
          Center(
        child: _image == null ? Text("No Image Selected") : Image.file(_image!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: "Increment",
        child: Icon(Icons.camera),
      ),
    );
  }
}
