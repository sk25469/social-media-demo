import 'package:flutter/material.dart';

class AddPostScreen extends StatelessWidget {
  static const routeName = '/add-post';
  const AddPostScreen({Key? key}) : super(key: key);

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
      body: const Center(
        child: Text('Add Post Screen'),
      ),
    );
  }
}
