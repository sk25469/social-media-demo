import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/model/post.dart';
import 'package:social_media/utils/firestore_database.dart';

class EditPostScreen extends StatefulWidget {
  static const routeName = '/edit-post';
  final PostModel exitingPost;
  const EditPostScreen({Key? key, required this.exitingPost}) : super(key: key);

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final _formKey = GlobalKey<FormState>();
  var _caption = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _caption = TextEditingController(text: widget.exitingPost.description);
  }

  @override
  Widget build(BuildContext context) {
    _onSubmit() async {
      if (_formKey.currentState!.validate()) {
        setState(() {
          _isLoading = true;
        });
        try {
          String docId = await postsRef
              .where('postId', isEqualTo: widget.exitingPost.postId)
              .get()
              .then((value) => value.docs[0].id);
          print(docId);
          await postsRef.doc(docId).update({
            'description': _caption.text,
            'timestamp': Timestamp.now(),
          });
          print("updated in firestore");
          setState(() {
            _isLoading = false;
          });
          Navigator.pop(context);
        } on FirebaseException catch (e) {
          print(e);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Edit Post',
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
                          return 'Please enter some text';
                        }
                        if (value.length > 100) {
                          return 'More than 100 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: Image.network(
                      widget.exitingPost.mediaUrl,
                      fit: BoxFit.scaleDown,
                    ),
                  )
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
                              'Submit',
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
