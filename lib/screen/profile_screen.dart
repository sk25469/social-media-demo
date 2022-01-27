import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media/provider/auth_provider.dart';
import 'package:social_media/screen/my_post_screen.dart';
import 'package:social_media/utils/user_utils.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile-screen';
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
      body: Consumer(
        builder: (context, ref, _) {
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
              appBar: AppBar(
                title: const Text(
                  "My Profile",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              body: Column(
                children: [
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
                                    color: const Color.fromARGB(255, 64, 192, 251),
                                    width: 2,
                                  ),
                                ),
                                child: const CircleAvatar(
                                  radius: 55,
                                  backgroundImage:
                                      AssetImage('assets/images/profile-icon.png'),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "@${currentUserId(_user.currentUser!.email!)}",
                                    style: const TextStyle(
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
                                            _user.currentUser!.email!,
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
                        Column(
                          children: [
                            _buildProfileTile(
                              context,
                              const Icon(Icons.edit),
                              'Edit Profile',
                              MyPostScreen.routeName,
                            ),
                            _buildProfileTile(
                              context,
                              const Icon(Icons.my_library_books_rounded),
                              'My Posts',
                              MyPostScreen.routeName,
                            )
                          ],
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
        },
      ),
    );
  }
}

Widget _buildProfileTile(
    BuildContext context, Icon icon, String title, String routeName) {
  var textTheme = Theme.of(context).textTheme;
  return Container(
    width: 350,
    padding: const EdgeInsets.only(
      left: 40,
    ),
    child: ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: icon,
      ),
      title: Text(
        title,
        style: textTheme.headline6,
      ),
      trailing: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {
            Navigator.pushNamed(context, routeName);
          },
        ),
      ),
    ),
  );
}
