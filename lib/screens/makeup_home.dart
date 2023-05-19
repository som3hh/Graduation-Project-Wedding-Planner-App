import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import '../widgets/upload_img.dart';
import 'login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum MenuType { profile, gallery }

class ArtistHome extends StatefulWidget {
  const ArtistHome({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ArtistHome> {
  MenuType? _selectedMenu;
  final Logger _logger = Logger();
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  Map<String, dynamic>? userData;

  final List<MenuOption> _menuOptions = [
    MenuOption(
      iconPath: 'assets/images/icons8-male-user-100.png',
      type: MenuType.gallery,
    ),
    MenuOption(
      iconPath: 'assets/images/icons8-photo-gallery-40.png',
      type: MenuType.profile,
    )
  ];

  final PageController _pageController = PageController(initialPage: 0);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  final List<File> _uploadedImages = [];

  Future<void> _uploadPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _uploadedImages.add(File(pickedFile.path));
      });
      // Upload the image file to Firestore or any other storage service
      // Here, we assume you have a user ID to identify the user
      // You can replace 'userId' with the actual user ID
      _userCollection.doc('userID').update({
        'photos': FieldValue.arrayUnion([pickedFile.path])
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDataSnapshot =
          await usersCollection.doc(user.uid).get();
      setState(() {
        userData = userDataSnapshot.data() as Map<String, dynamic>?;
      });
    }
  }

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
                if (userData != null)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            NetworkImage(userData!['profilePicture'] ?? ''),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        userData!['username'] ?? '',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        userData!['phoneNumber'] ?? '',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        userData!['accountType'] ?? '',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  )
                else
                  const CircularProgressIndicator(),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: _uploadPhoto,
                      child: Text('Upload Photos'),
                    ),
                    Expanded(
                      child: StreamBuilder<DocumentSnapshot>(
                        stream: _userCollection.doc('userID').snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          final photos = (snapshot.data?.data()
                                  as Map<String, dynamic>?)?['photos']
                              as List<dynamic>?;

                          if (photos == null || photos.isEmpty) {
                            return Center(
                              child: Text('No photos uploaded yet.'),
                            );
                          }

                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 4.0,
                              mainAxisSpacing: 4.0,
                            ),
                            itemCount: photos.length,
                            itemBuilder: (context, index) {
                              final imageUrl = photos[index].toString();
                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
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
