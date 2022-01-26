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
        var textTheme = Theme.of(context).textTheme;
        final _auth = ref.read(authenticationProvider);
        final _user = ref.read(fireBaseAuthProvider);
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

        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        top: 15.0,
                        left: 20,
                        bottom: 10,
                      ),
                      child: const Icon(
                        Icons.account_circle,
                        color: Colors.white,
                        size: 45,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 15.0,
                        left: 20,
                        bottom: 10,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "My Profile",
                        style: textTheme.headline3,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                left: 0,
                                top: 20,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(55),
                                border: Border.all(
                                  color: Colors.purpleAccent,
                                  width: 2,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 55,
                                backgroundImage:
                                    const AssetImage('assets/images/profile-icon.png'),
                                child: GestureDetector(
                                  onTap: () {
                                    // print('Edit profile');
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Colors.purple,
                                    ),
                                    margin: const EdgeInsets.only(
                                      left: 88,
                                      top: 65,
                                    ),
                                    child: const Icon(
                                      Icons.edit,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Sahil",
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const Text(
                                  "Sarwar",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 0,
                                    right: 20,
                                    top: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                          top: 10,
                                        ),
                                        child: const Icon(
                                          Icons.email,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                          left: 10,
                                          top: 10,
                                        ),
                                        child: Text(
                                          _user.currentUser?.email ?? '',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 145,
                        height: 40,
                        margin: const EdgeInsets.only(
                          top: 10,
                          left: 55,
                          bottom: 40,
                        ),
                        child: MaterialButton(
                          color: Colors.white,
                          onPressed: _onPressedFunction,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 2.0,
                                    bottom: 2.0,
                                    right: 7,
                                  ),
                                  child: Icon(
                                    Icons.logout,
                                    color: Colors.red,
                                    size: 24,
                                  ),
                                ),
                                Text(
                                  'Sign out',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 21,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
