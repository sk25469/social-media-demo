import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/model/post.dart';
import 'package:social_media/utils/date_utils.dart';
import 'package:social_media/utils/firestore_database.dart';

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
      await postsRef.where('postId', isEqualTo: postModel.postId).get().then((snapshot) {
        for (var doc in snapshot.docs) {
          doc.reference.delete();
        }
      });
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
                    color: const Color.fromARGB(255, 226, 224, 224),
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
                      // if (item == 0)
                      //   Navigator.pushNamed(
                      //     context,
                      //     '/edit-post',
                      //     arguments: postModel,
                      //   ),
                      if (item == 1) {
                        deletePost();
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
