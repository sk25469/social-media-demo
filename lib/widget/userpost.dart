import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/model/post.dart';
import 'package:social_media/screen/edit_post_screen.dart';
import 'package:social_media/utils/date_utils.dart';
import 'package:social_media/utils/firestore_database.dart';

class UserPost extends StatefulWidget {
  final PostModel postModel;
  final bool isMyPost;
  const UserPost({
    Key? key,
    required this.postModel,
    required this.isMyPost,
  }) : super(key: key);

  @override
  State<UserPost> createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  @override
  Widget build(BuildContext context) {
    String toReadableDate(Timestamp timestamp) {
      var day = timestamp.toDate().day;
      var month = monthDateToName[timestamp.toDate().month];
      var year = (timestamp.toDate().year) % 100;
      return '${day}th $month\' $year';
    }

    String toReadableTime(Timestamp timestamp) {
      var hour = timestamp.toDate().hour;
      var minute = timestamp.toDate().minute;
      var ampm = hour >= 12 ? 'PM' : 'AM';
      hour = hour % 12;
      hour = hour == 0 ? 12 : hour;
      return '$hour:$minute $ampm';
    }

    void deletePost() async {
      await postsRef.where('postId', isEqualTo: widget.postModel.postId).get().then(
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
                          "@" + widget.postModel.username,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (widget.isMyPost)
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
                              exitingPost: widget.postModel,
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
                                      deletePost();
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
                        // deletePost();
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
                widget.postModel.description,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 250,
              child: Image.network(
                widget.postModel.mediaUrl,
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
                      toReadableDate(widget.postModel.timestamp),
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
                      toReadableTime(widget.postModel.timestamp),
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

class ProgressIndicator extends StatelessWidget {
  const ProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
