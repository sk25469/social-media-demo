import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/model/post.dart';
import 'package:social_media/utils/firestore_database.dart';
import 'package:social_media/widget/userpost.dart';

class MyPostScreen extends StatefulWidget {
  static const routeName = '/my-post-screen';
  const MyPostScreen({Key? key}) : super(key: key);

  @override
  State<MyPostScreen> createState() => _MyPostScreenState();
}

class _MyPostScreenState extends State<MyPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'My Posts',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(
            const Duration(
              seconds: 1,
            ),
          );
          setState(() {});
        },
        child: StreamBuilder<QuerySnapshot<PostModel>>(
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
            if (updatedPosts.size == 0) {
              return const Center(
                child: Text('You have no posts available\nAdd some posts!'),
              );
            } else {
              return ListView.builder(
                itemCount: updatedPosts.size,
                itemBuilder: (context, index) {
                  return UserPost(
                    postModel: updatedPosts.docs[index].data(),
                    isMyPost: true,
                  );
                },
              );
            }
          },
          stream: postsRef
              .where(
                'ownerId',
                isEqualTo: firebaseAuth.currentUser!.email,
              )
              .orderBy('timestamp', descending: true)
              .limit(20)
              .snapshots(),
        ),
      ),
    );
  }
}
