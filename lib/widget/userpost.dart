import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/model/post.dart';

class UserPost extends StatelessWidget {
  final PostModel postModel;
  const UserPost({Key? key, required this.postModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String toReadableDate(Timestamp timestamp) {
      var day = timestamp.toDate().day;
      var month = timestamp.toDate().month;
      var year = timestamp.toDate().year;
      return '$day/$month/$year';
    }

    return Card(
      elevation: 5,
      child: Column(
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
                    postModel.username,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            postModel.description,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Image.network(
              postModel.mediaUrl,
              fit: BoxFit.contain,
            ),
          ),
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
        ],
      ),
    );
  }
}
