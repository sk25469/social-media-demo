import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/model/user.dart';
import 'package:social_media/utils/firestore_database.dart';
import 'package:social_media/utils/user_utils.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChange => _auth.authStateChanges();

  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Error Occured'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text("OK"),
            )
          ],
        ),
      );
    }
  }

  // SignUp the user using Email and Password
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
    required String name,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await usersRef.add(
        UserModel(
          email: email,
          name: name,
          userId: currentUserId(email),
        ),
      );
    } on FirebaseAuthException catch (e) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Error Occured'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text("OK"),
            )
          ],
        ),
      );
    } catch (e) {
      if (e == 'email-already-in-use') {
        // print('Email already in use.');
      } else {
        print('Error: $e');
      }
    }
  }

  //  SignOut the current user
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
