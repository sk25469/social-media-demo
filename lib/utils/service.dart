import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/model/post.dart';
import 'package:social_media/utils/file_utils.dart';
import 'package:social_media/utils/user_utils.dart';
import 'package:uuid/uuid.dart';

import 'firestore_database.dart';

class PostService {
  String id = const Uuid().v4();
  Future<String> uploadImage(XFile? image) async {
    String fileName = id + FileUtils.getFileExtension(File(image!.path));
    File file = File(image.path);
    await posts.child(fileName).putFile(file);
    String downloadUrl = await posts.child(fileName).getDownloadURL();
    return downloadUrl;
  }

  Future<void> addPost({
    required String caption,
    required XFile? image,
    required String userId,
  }) async {
    String downloadUrl = await uploadImage(image);
    PostModel post = PostModel(
      description: caption,
      mediaUrl: downloadUrl,
      ownerId: userId,
      postId: id,
      timestamp: Timestamp.now(),
      username: currentUserId(userId),
    );
    await postsRef.add(post);
  }

  /// Deletes the post from the firestore-database
  /// then deletes the file from the firebase-storage
  /// takes [String] download url of the file as parameter
  Future<void> deletePost(String imageFileUrl, String postId) async {
    var fileUrl = imageFileUrl
        .replaceAll(
            RegExp(
                r'https://firebasestorage.googleapis.com/v0/b/social-media-demo-9927c.appspot.com/o/images%2F'),
            '')
        .split('?')[0];

    await posts.child(fileUrl).delete();

    await postsRef.where('postId', isEqualTo: postId).get().then(
      (snapshot) {
        for (var doc in snapshot.docs) {
          doc.reference.delete();
        }
      },
    );
  }

  Future<void> updatePost(String postId, String caption) async {
    String docId = await postsRef
        .where('postId', isEqualTo: postId)
        .get()
        .then((value) => value.docs[0].id);
    // print(docId);
    await postsRef.doc(docId).update({
      'description': caption,
      'timestamp': Timestamp.now(),
    });
  }
}
