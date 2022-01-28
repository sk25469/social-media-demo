import 'package:flutter/material.dart';
import 'package:social_media/model/post.dart';
import 'package:social_media/screen/edit_post_screen.dart';
import 'package:social_media/utils/date_utils.dart';
import 'package:social_media/utils/firestore_database.dart';
import 'package:path/path.dart' as path;

class UserPost extends StatelessWidget {
  final PostModel postModel;
  final bool isMyPost;
  const UserPost({
    Key? key,
    required this.postModel,
    required this.isMyPost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void deletePost(String imageFileUrl) async {
      print(imageFileUrl);
      var fileUrl = imageFileUrl
          .replaceAll(
              RegExp(
                  r'https://firebasestorage.googleapis.com/v0/b/social-media-demo-9927c.appspot.com/o/images%2F'),
              '')
          .split('?')[0];

      await posts.child(fileUrl).delete();

      await postsRef.where('postId', isEqualTo: postModel.postId).get().then(
        (snapshot) {
          for (var doc in snapshot.docs) {
            doc.reference.delete();
          }
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        const Icon(Icons.account_circle),
                        const SizedBox(width: 8),
                        Text(
                          "@" + postModel.username,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (isMyPost)
                  PopupMenuButton(
                    icon: const Icon(
                      Icons.more_vert,
                    ),
                    color: Colors.white,
                    itemBuilder: (context) => [
                      const PopupMenuItem<int>(
                        value: 0,
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const PopupMenuItem<int>(
                        value: 1,
                        child: Text(
                          "Delete",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                    onSelected: (item) {
                      if (item == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditPostScreen(
                              exitingPost: postModel,
                            ),
                          ),
                        );
                      }
                      if (item == 1) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                  "Are you sure you want to delete this post?"),
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      deletePost(postModel.mediaUrl);
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Yes"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("No"),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(
                bottom: 8,
                top: 5,
                left: 10,
              ),
              child: Text(
                postModel.description,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 250,
              child: Image.network(
                postModel.mediaUrl,
                fit: BoxFit.scaleDown,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      toReadableDate(postModel.timestamp),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      toReadableTime(postModel.timestamp),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
