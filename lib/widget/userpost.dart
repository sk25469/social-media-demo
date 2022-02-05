import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media/model/post.dart';
import 'package:social_media/screen/edit_post_screen.dart';
import 'package:social_media/utils/date_utils.dart';
import 'package:social_media/utils/service.dart';

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
                              elevation: 5,
                              title: const Text(
                                "Are you sure you want to delete this post?",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              content: SizedBox(
                                height: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                      ),
                                      onPressed: () async {
                                        await PostService()
                                            .deletePost(
                                              postModel.mediaUrl,
                                              postModel.postId,
                                            )
                                            .whenComplete(
                                              () => Navigator.pop(context),
                                            );
                                      },
                                      child: const Text("Yes"),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.grey,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("No"),
                                    ),
                                  ],
                                ),
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
              child: CachedNetworkImage(
                imageUrl: postModel.mediaUrl,
                fit: BoxFit.scaleDown,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      durationAgo(postModel.timestamp),
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
