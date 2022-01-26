import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/model/user.dart';

import '../model/post.dart';

final usersRef = FirebaseFirestore.instance.collection('users').withConverter<UserModel>(
      fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
      toFirestore: (user, _) => user.toJson(),
    );
final postsRef = FirebaseFirestore.instance.collection('posts').withConverter<PostModel>(
      fromFirestore: (snapshot, _) => PostModel.fromJson(snapshot.data()!),
      toFirestore: (post, _) => post.toJson(),
    );
