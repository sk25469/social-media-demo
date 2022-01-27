import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_media/model/user.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../model/post.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;
const Uuid uuid = Uuid();

final usersRef = FirebaseFirestore.instance.collection('users').withConverter<UserModel>(
      fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
      toFirestore: (user, _) => user.toJson(),
    );
final postsRef = FirebaseFirestore.instance.collection('posts').withConverter<PostModel>(
      fromFirestore: (snapshot, _) => PostModel.fromJson(snapshot.data()!),
      toFirestore: (post, _) => post.toJson(),
    );

final posts = firebase_storage.FirebaseStorage.instance.ref().child('images');
