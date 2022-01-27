import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/model/post.dart';
import 'package:social_media/widget/userpost.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newPost = PostModel(
      timestamp: Timestamp.now(),
      postId: "abc",
      ownerId: "cde",
      description: "efg",
      mediaUrl:
          "https://firebasestorage.googleapis.com/v0/b/social-media-demo-9927c.appspot.com/o/images%2F0433f1b0-01e9-44a1-a2ff-511b79ceefcbjpg?alt=media&token=9e305eb8-09a1-4105-bf58-474a92210627",
      username: "imsahil",
    );
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
      body: ListView.builder(
        itemBuilder: (context, index) {
          return UserPost(postModel: newPost);
        },
        itemCount: 10,
      ),
    );
  }
}
