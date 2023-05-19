import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_ptoj/screens/client_home.dart';
import 'package:graduation_ptoj/screens/photographer_home.dart';
import 'package:graduation_ptoj/widgets/gander_selection.dart';
import 'package:graduation_ptoj/widgets/age_fields.dart';
import 'package:graduation_ptoj/widgets/pass_field.dart';
import 'package:graduation_ptoj/widgets/txt_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../constants.dart';
import 'makeup_home.dart';
import 'shop_home.dart';

enum RoleType { photographer, makeupArtist, shop, client }

class RegsPage extends StatefulWidget {
  const RegsPage({Key? key}) : super(key: key);

  @override
  RegsPageState createState() => RegsPageState();
}

class RegsPageState extends State<RegsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  XFile? _profilePicture;
  Future<void> _selectProfilePicture() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profilePicture = image;
      });
    }
  }

  bool _termsAccepted = false;
  RoleType? _selectedRole;
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final List<RoleOption> _roleOptions = [
    const RoleOption(
      title: 'Photographer',
      iconPath: 'assets/images/icons8-professional-photographer-48.png',
      type: RoleType.photographer,
    ),
    const RoleOption(
      title: 'Makeup Artist',
      iconPath: 'assets/images/icons8-makeup-brush-48.png',
      type: RoleType.makeupArtist,
    ),
    const RoleOption(
      title: 'Shop',
      iconPath: 'assets/images/icons8-shop-48.png',
      type: RoleType.shop,
    ),
    const RoleOption(
      title: 'Client',
      iconPath: 'assets/images/icons8-romance-48.png',
      type: RoleType.client,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: mPrimaryColor,
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(
            height: 250,
          ),
          Center(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              width: 410,
              height: 1000,
              child: Column(children: [
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: _selectProfilePicture,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: _profilePicture != null
                          ? DecorationImage(
                              image: FileImage(File(_profilePicture!.path)),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _profilePicture == null
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('I am a'),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 140),
                  child: GenderSelection(),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 205),
                  child: Text('UserName'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TxtFields(
                  onChanged: (data) {
                    setState(() {
                      userNameController.text = data;
                    });
                  },
                  hintText: 'Abdullah Mohammed',
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 243),
                  child: Text('Email'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TxtFields(
                  onChanged: (data) {
                    setState(() {
                      emailController.text = data;
                    });
                  },
                  hintText: 'email',
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 213),
                  child: Text('Password'),
                ),
                const SizedBox(
                  height: 10,
                ),
                PxtFields(
                  onChanged: (data) {
                    setState(() {
                      passwordController.text = data;
                    });
                  },
                  phintText: 'Enter your password',
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 185),
                  child: Text('PhoneNumber'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TxtFields(
                  onChanged: (data) {
                    setState(() {
                      phoneNumberController.text = data;
                    });
                  },
                  hintText: 'Enter your PhoneNumber',
                ),
                const SizedBox(
                  height: 20,
                ),
                //ده جزء اختيار ال Account type
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(_roleOptions.length, (index) {
                    final option = _roleOptions[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          Radio<RoleType>(
                            value: option.type,
                            groupValue: _selectedRole,
                            onChanged: (value) {
                              setState(() {
                                _selectedRole = value;
                              });
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedRole = option.type;
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  option.iconPath,
                                  width: 20,
                                  height: 20,
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: 80,
                                  child: Center(
                                    child: Text(
                                      option.title,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: _selectedRole == option.type
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('I have read and agreed to all terms'),
                    Checkbox(
                      value: _termsAccepted,
                      onChanged: (value) {
                        setState(() {
                          _termsAccepted = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_selectedRole == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please fill in all fields')),
                      );
                      return;
                    }

                    try {
                      UserCredential user = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      String userId = user.user!.uid;

                      if (_profilePicture != null) {
                        final firebase_storage.Reference storageRef =
                            firebase_storage.FirebaseStorage.instance
                                .ref()
                                .child(
                                    'profile_pictures/${user.user!.uid}.jpg');

                        // Upload the profile picture to Firebase Storage
                        await storageRef.putFile(File(_profilePicture!.path));

                        // Get the download URL of the uploaded picture
                        final String downloadURL =
                            await storageRef.getDownloadURL();

                        // Set the download URL in the user document in Firestore
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.user!.uid)
                            .set({
                          'username': userNameController.text,
                          'email': emailController.text,
                          'accountType': _selectedRole.toString(),
                          'phoneNumber': phoneNumberController.text,
                          'profilePicture':
                              downloadURL, // Add the download URL to the document
                          'createdAt': FieldValue.serverTimestamp(),
                          'userID': userId.toString(),
                        });
                      } else {
                        // Set other user information in Firestore without the profile picture
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.user!.uid)
                            .set({
                          'username': userNameController.text,
                          'email': emailController.text,
                          'accountType': _selectedRole.toString(),
                          'phoneNumber': phoneNumberController.text,
                          'createdAt': FieldValue.serverTimestamp(),
                        });
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Success')),
                      );

                      // Navigate to appropriate home screen based on the selected role
                      switch (_selectedRole) {
                        case RoleType.photographer:
                          Get.offAll(const PhotographerHome());
                          break;
                        case RoleType.makeupArtist:
                          Get.offAll(const ArtistHome());
                          break;
                        case RoleType.shop:
                          Get.offAll(const ShopHome());
                          break;
                        case RoleType.client:
                          Get.offAll(const ClientHome());
                          break;
                        case null:
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Invalid role selected')),
                          );
                          break;
                      }
                    } on FirebaseAuthException catch (e) {
                      String errorMessage = 'An error occurred.';

                      switch (e.code) {
                        case 'email-already-in-use':
                          errorMessage =
                              'This email is already used on another account.';
                          break;
                        case 'invalid-email':
                          errorMessage = 'Invalid email address.';
                          break;
                        case 'weak-password':
                          errorMessage =
                              'Weak password. Please choose a stronger password.';
                          break;
                        // Handle other FirebaseAuthException error codes as needed
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(errorMessage)),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('An error occurred.')),
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xff95BDFF)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  child: const Text('Confirm'),
                ),
              ]),
            ),
          )
        ]),
      ),
    );
  }
}

class RoleOption {
  final String title;
  final String iconPath;
  final RoleType type;

  const RoleOption({
    required this.title,
    required this.iconPath,
    required this.type,
  });
}
