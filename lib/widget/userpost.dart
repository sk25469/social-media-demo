// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media/model/post.dart';
import 'package:social_media/utils/date_utils.dart';

class UserPost extends StatelessWidget {
  final PostModel postModel;
  const UserPost({Key? key, required this.postModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String toReadableDate(Timestamp timestamp) {
      var day = timestamp.toDate().day;
      var month = monthDateToName[timestamp.toDate().month];
      var year = (timestamp.toDate().year) % 100;
      return '${day}th ${month}\' $year';
    }

    String toReadableTime(Timestamp timestamp) {
      var hour = timestamp.toDate().hour;
      var minute = timestamp.toDate().minute;
      var ampm = hour >= 12 ? 'PM' : 'AM';
      hour = hour % 12;
      hour = hour == 0 ? 12 : hour;
      return '${hour}:${minute} $ampm';
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
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
                      "@" + postModel.username,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
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
