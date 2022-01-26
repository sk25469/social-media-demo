import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media/provider/auth_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = false;

  void loading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, ref, _) {
        final _auth = ref.read(authenticationProvider);
        Future<void> _onPressedFunction() async {
          loading();
          await _auth.signOut().whenComplete(
                () => _auth.authStateChange.listen(
                  (event) async {
                    if (event == null) {
                      loading();
                      return;
                    }
                  },
                ),
              );
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Profile Screen'),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _onPressedFunction,
                    child: const Text("Sign Out"),
                  ),
          ],
        );
      }),
    );
  }
}
