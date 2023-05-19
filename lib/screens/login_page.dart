import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_ptoj/screens/client_home.dart';
import 'package:graduation_ptoj/screens/regestration_page.dart';
import 'package:graduation_ptoj/widgets/txt_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';
import '../widgets/pass_field.dart';
import 'makeup_home.dart';
import 'photographer_home.dart';
import 'shop_home.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'Farha',
                    style: TextStyle(fontSize: 50, color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Container(
                  width: 330,
                  height: 320,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TxtFields(
                        controller: emailController,
                        hintText: 'Email',
                      ),
                      const SizedBox(height: 20),
                      PxtFields(
                        controller: passwordController,
                        phintText: 'Password',
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            final FirebaseAuth auth = FirebaseAuth.instance;
                            final FirebaseFirestore firestore =
                                FirebaseFirestore.instance;

                            UserCredential userCredential =
                                await auth.signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );

                            if (userCredential.user != null) {
                              String userId = userCredential.user!.uid;
                              DocumentSnapshot userSnapshot = await firestore
                                  .collection('users')
                                  .doc(userId)
                                  .get();
                              if (userSnapshot.exists) {
                                String accountType =
                                    userSnapshot.get('accountType');
                                if (accountType == 'RoleType.client') {
                                  Get.offAll(() => const ClientHome());
                                } else if (accountType ==
                                    'RoleType.photographer') {
                                  // Handle different account types
                                  Get.offAll(() => const PhotographerHome());
                                } else if (accountType ==
                                    'RoleType.makeupArtist') {
                                  Get.offAll(() => const ArtistHome());
                                } else if (accountType == 'RoleType.shop') {
                                  Get.offAll(() => const ShopHome());
                                }
                              }
                            }
                          } catch (e) {
                            String errorMessage =
                                'An error occurred during login.';

                            if (e is FirebaseAuthException) {
                              if (e.code == 'user-not-found') {
                                errorMessage = 'No user found with this email.';
                              } else if (e.code == 'wrong-password') {
                                errorMessage = 'Invalid password.';
                              }
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(errorMessage)),
                            );
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xffF7C8E0),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => const RegsPage());
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xff95BDFF),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  child: const Text('Create Account'),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ));
  }
}
