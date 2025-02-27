import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intelliassist/utils.dart';

class uploadImage extends StatefulWidget {
  const uploadImage({super.key});

  @override
  State<uploadImage> createState() => _uploadImageState();
}

class _uploadImageState extends State<uploadImage> {
  Uint8List? _image;
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        padding: EdgeInsets.only(top: 200),
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  _image != null?
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: MemoryImage(_image!),
                  ):
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage('https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o='),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(onPressed: selectImage,icon: const Icon(Icons.add_a_photo))
                    

                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );   
  }
}