import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePick extends StatefulWidget {
  final void Function(File pickedFile) getImage;

  ImagePick(this.getImage);

  @override
  _ImagePickState createState() => _ImagePickState();
}

class _ImagePickState extends State<ImagePick> {
  File _pickedImage;
  final picker = ImagePicker();

  Future<void> openCamera() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.camera, imageQuality: 50, maxWidth: 150);

    setState(() {
      _pickedImage = File(pickedFile.path);
    });
    widget.getImage(File(pickedFile.path));
  }

  Future<void> openGallery() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 150);

    setState(() {
      _pickedImage = File(pickedFile.path);
    });
    widget.getImage(File(pickedFile.path));
  }

  void chooseoption() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Add Profile Photo'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  openCamera();
                  Navigator.of(context).pop();
                },
                child: Text('Camera'),
              ),
              FlatButton(
                onPressed: () {
                  openGallery();
                  Navigator.of(context).pop();
                },
                child: Text('Gallery'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 40,
            backgroundImage:
                _pickedImage == null ? null : FileImage(_pickedImage),
          ),
          FlatButton.icon(
              icon: Icon(
                Icons.image,
                color: Theme.of(context).primaryColor,
              ),
              label: Text(
                'Add Image',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: chooseoption)
        ],
      ),
    );
  }
}
