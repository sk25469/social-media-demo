import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media/screen/add_post_screen.dart';
import 'package:social_media/screen/auth_checker.dart';
import 'package:social_media/screen/bottom_nav.dart';
import 'package:social_media/screen/error_screen.dart';
import 'package:social_media/screen/home_screen.dart';
import 'package:social_media/screen/profile_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

final firebaseinitializerProvider = FutureProvider<FirebaseApp>((ref) async {
  return await Firebase.initializeApp();
});

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialize = ref.watch(firebaseinitializerProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: initialize.when(
        data: (data) {
          return const AuthChecker();
        },
        loading: () => const CircularProgressIndicator(),
        error: (e, stackTrace) => ErrorScreen(e, stackTrace),
      ),
      routes: {
        // '/': (context) => const AuthChecker(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
        AddPostScreen.routeName: (context) => const AddPostScreen(),
        BottomNavigationScreen.routeName: (context) => const BottomNavigationScreen(),
      },
    );
  }
}
