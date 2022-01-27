import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/model/post.dart';
import 'package:social_media/utils/firestore_database.dart';
import 'package:social_media/widget/userpost.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Feeds',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
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
                child: Text('No posts available\nPlease add some posts!'),
              );
            } else {
              return ListView.builder(
                itemCount: updatedPosts.size,
                itemBuilder: (context, index) {
                  return UserPost(
                    postModel: updatedPosts.docs[index].data(),
                  );
                },
              );
            }
          },
          stream: postsRef.orderBy('timestamp', descending: true).limit(20).snapshots(),
        ),
      ),
    );
  }
}
