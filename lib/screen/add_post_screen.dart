import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/utils/service.dart';

class AddPostScreen extends StatefulWidget {
  static const routeName = '/add-post';
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _formKey = GlobalKey<FormState>();
  XFile? _image;
  final _caption = TextEditingController();
  bool _isLoading = false;
  // bool _noImageSelected = false;

  get userId => FirebaseAuth.instance.currentUser?.email;

  _imgFromCamera() async {
    XFile? image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxHeight: 250,
      maxWidth: double.infinity,
    );
    if (image == null) {
      print("no image");
    }

    setState(() {
      _image = image!;
    });
  }

  _imgFromGallery() async {
    XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 250,
      maxWidth: double.infinity,
    );

    setState(() {
      _image = image;
    });
  }

  _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        // if (_image == null) {
        //   setState(() {
        //     _noImageSelected = true;
        //   });
        //   return;
        // }
        await PostService()
            .addPost(
              caption: _caption.text,
              image: _image,
              userId: userId,
            )
            .whenComplete(
              () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Post added successfully"),
                  duration: Duration(seconds: 1),
                ),
              ),
            );

        setState(() {
          _isLoading = false;
        });
        Navigator.pop(context);
      } on FirebaseException {
        // print(e);
      }
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  _imgFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _imgFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Add New Post',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      maxLines: null,
                      controller: _caption,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Write something...',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Caption can\'t be empty';
                        }
                        if (value.length > 100) {
                          return 'More than 100 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // print('tapping');
                      _showPicker(context);
                    },
                    child: _image != null
                        ? SizedBox(
                            width: double.infinity,
                            height: 250,
                            child: Image.file(
                              File(_image!.path),
                              fit: BoxFit.scaleDown,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: double.infinity,
                            height: 250,
                            child: const Icon(Icons.camera_alt),
                          ),
                  ),
                ],
              ),
              key: _formKey,
            ),
            _isLoading
                ? const Padding(
                    padding: EdgeInsets.only(
                      top: 50,
                      left: 20,
                      right: 20,
                    ),
                    child: CircularProgressIndicator(),
                  )
                : Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        top: 50,
                        left: 20,
                        right: 20,
                      ),
                      child: RaisedButton(
                        onPressed: _onSubmit,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        padding: const EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color.fromARGB(255, 125, 190, 233),
                                Color.fromARGB(255, 1, 103, 255)
                              ],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                          ),
                          child: Container(
                            height: 50,
                            constraints: const BoxConstraints(
                              minWidth: 88.0,
                              minHeight: 36.0,
                            ), // min sizes for Material buttons
                            alignment: Alignment.center,
                            child: const Text(
                              'Post',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
