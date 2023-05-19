import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'login_page.dart';

enum MenuType { proflie, gallery }

class PhotographerHome extends StatefulWidget {
  const PhotographerHome({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<PhotographerHome> {
  MenuType? _selectedMenu;
  final Logger _logger = Logger();

  final List<MenuOption> _menuOptions = [
    MenuOption(
      iconPath: 'assets/images/icons8-photo-gallery-40.png',
      type: MenuType.gallery,
    ),
    MenuOption(
      iconPath: 'assets/images/icons8-male-user-100.png',
      type: MenuType.proflie,
    )
  ];

  final PageController _pageController = PageController(initialPage: 0);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('farha'), // Replace 'farha' with your app name
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Sidebar Option 1'),
              onTap: () {
                // Handle sidebar option 1 tap
              },
            ),
            ListTile(
              title: const Text('Sidebar Option 2'),
              onTap: () {
                // Handle sidebar option 2 tap
              },
            ),
            ListTile(
              title: const Text('Sign Out'),
              onTap: () {
                _signOut();
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int index) {
                setState(() {
                  _selectedMenu = _menuOptions[index].type;
                });
              },
              children: [
                const Center(child: Text('Gallery Page')),
                const Center(child: Text('Profile Page')),
              ],
            ),
          ),
          BottomAppBar(
            child: Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (final option in _menuOptions)
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _selectedMenu = option.type;
                          _pageController.jumpToPage(option.index);
                        });
                      },
                      icon: Image.asset(
                        option.iconPath,
                        color:
                            _selectedMenu == option.type ? null : Colors.grey,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _signOut() async {
    bool confirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context)
                    .pop(false); // User does not confirm logout
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(true); // User confirms logout
              },
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      try {
        await FirebaseAuth.instance.signOut();
        // Clear user info and state as needed
        // Redirect to login or home screen
        Get.offAll(LoginPage());
      } catch (e, stackTrace) {
        _logger.e('Error signing out', e, stackTrace);
      }
    }
  }
}

class MenuOption {
  final String iconPath;
  final MenuType type;

  MenuOption({
    required this.iconPath,
    required this.type,
  });

  int get index => MenuType.values.indexOf(type);
}
