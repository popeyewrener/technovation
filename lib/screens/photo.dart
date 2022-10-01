import 'dart:io';
import 'dart:typed_data';

import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Photo extends StatefulWidget {
  const Photo({Key? key}) : super(key: key);

  @override
  State<Photo> createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  @override
  Widget build(BuildContext context) {
    var image;
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          ElevatedButton(
              onPressed: () async {
                final ImagePicker _picker = ImagePicker();
                image = await _picker.pickImage(source: ImageSource.gallery);
                final Uint8List bytes = await image!.readAsBytes();
                image = Image.memory(bytes).image;

                setState(() {});
              },
              child: Text('Choose photo')),
          image != null
              ? Image(image: image)
              : Container(
                  child: Text('No img'),
                )
        ]),
      ),
    );
  }
}
