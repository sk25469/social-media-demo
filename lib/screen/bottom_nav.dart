import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:social_media/screen/add_post_screen.dart';
import 'package:social_media/screen/home_screen.dart';
import 'package:social_media/screen/profile_screen.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

/// This is the dimension of floation action button, used for the animation while using
/// [OpenContainer]

class BottomNavigationScreen extends StatefulWidget {
  static const routeName = '/bottom-nav-screen';
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  var _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  final List<Map<String, Object>> _pages = [
    {
      'page': const HomeScreen(),
      'title': 'Feeds',
    },
    {
      'page': const ProfileScreen(),
      'title': 'My Profile',
    },
  ];

  /// [OpenContainer] from the [Animation] package is used to provide the zooming
  /// animation for the floating action button and
  /// [PageTransitionSwitcher] is used to switch between the pages with a fade through
  /// transition
  @override
  Widget build(BuildContext context) {
    GlobalKey globalKey = GlobalKey<State<TitledBottomNavigationBar>>();
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: Material(
        child: PageTransitionSwitcher(
          transitionBuilder: (child, primaryAnimation, secondaryAnimatiion) {
            return FadeThroughTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimatiion,
              child: child,
            );
          },
          child: _pages[_selectedPageIndex]['page'] as Widget,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Visibility(
        visible: !keyboardIsOpen,
        child: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, AddPostScreen.routeName);
          },
        ),
      ),
      bottomNavigationBar: TitledBottomNavigationBar(
        key: globalKey,
        onTap: _selectPage,
        curve: Curves.bounceInOut,
        currentIndex: _selectedPageIndex,
        reverse: true,
        inactiveColor: Colors.black,
        items: [
          TitledNavigationBarItem(
            icon: const Icon(Icons.feed),
            title: const Text('Feeds'),
          ),
          TitledNavigationBarItem(
            icon: const Icon(Icons.account_circle_outlined),
            title: const Text('Profile'),
          ),
        ],
      ),
    );
  }
}
