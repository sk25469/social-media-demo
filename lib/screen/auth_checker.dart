import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media/provider/auth_provider.dart';
import 'package:social_media/screen/bottom_nav.dart';
import 'package:social_media/screen/error_screen.dart';
import 'login_page.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authState = ref.watch(authStateProvider);
    return _authState.when(
      data: (data) {
        if (data != null) return const BottomNavigationScreen();
        return const LoginPage();
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, trace) => ErrorScreen(e, trace),
    );
  }
}
