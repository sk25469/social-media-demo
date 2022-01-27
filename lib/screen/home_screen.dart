import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/model/post.dart';
import 'package:social_media/utils/firestore_database.dart';
import 'package:social_media/widget/userpost.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List<PostModel> updatedPosts = [];
    // Future<void> _getAllPosts() async {
    //   final newPosts = await postsRef.get();
    //   print((newPosts.docs[0].data().username));
    //   for (int i = 0; i < newPosts.size; i++) {
    //     updatedPosts.add(newPosts.docs[i].data());
    //   }
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Feeds',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder<QuerySnapshot<PostModel>>(
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final updatedPosts = snapshot.requireData;
          return ListView.builder(
            itemCount: updatedPosts.size,
            itemBuilder: (context, index) {
              return UserPost(
                postModel: updatedPosts.docs[index].data(),
              );
            },
          );
        },
        stream: postsRef.snapshots(),
      ),
    );
  }
}
