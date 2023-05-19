//   Container(
//             height: 500,
//             width: 350,
//             decoration: BoxDecoration(
//                 color: Color(0xffB4E4FF),
//                 borderRadius: BorderRadius.circular(30)),
//           child: Stack(children: [
//             FlutterMap(
//               mapController: MapController(),
//               options: MapOptions(
//                 center: LatLng(30.1191, 31.6053),
//                 zoom: 13.0,
//               ),
//               children: [
//                 TileLayer(
//                   urlTemplate:
//                       "https://api.mapbox.com/styles/v1/som3h/clh701tlo00sa01quhfgohj6a/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic29tM2giLCJhIjoiY2xoNno3aDR5MGF4ajNubm9hbXNqdnF3cSJ9.m0qO-8nJmOzD6aqw7OTs8g",
//                   additionalOptions: {
//                     "access_token":
//                         "pk.eyJ1Ijoic29tM2giLCJhIjoiY2xoNno3aDR5MGF4ajNubm9hbXNqdnF3cSJ9.m0qO-8nJmOzD6aqw7OTs8g",
//                     "id": "mapbox.mapbox-streets-v8"
//                   },
//                   userAgentPackageName: 'com.example.app',
//                 ),
//               ],
//             ),
//             Positioned(
//               bottom: 20,
//               right: 20,
//               child: FloatingActionButton(
//                 onPressed: () {
//                   // code to get current location
//                 },
//                 child: const Icon(Icons.my_location),
//               ),
//             )
//           ]),
//           )
// //           ElevatedButton(
// //                   onPressed: () async {
// //                     try {
// //                       var auth = FirebaseAuth.instance;
// //                       UserCredential user =
// //                           await auth.createUserWithEmailAndPassword(
// //                               email: email!, password: password!);
// //                       FirebaseFirestore.instance
// //                           .collection('users')
// //                           .doc(user.user!.uid)
// //                           .set({
// //                         'username': userName,
// //                         'email': email,
// //                         'accountType': _selectedRole,
// //                       });
// //                       // Move Navigator calls outside of try-catch block
// //                     } on FirebaseAuthException {
// //                       Builder(
// //                         builder: (BuildContext builderContext) {
// //                           ScaffoldMessenger.of(builderContext).showSnackBar(
// //                             const SnackBar(
// //                                 content: Text(
// //                                     'This Email Is Already Used On Another Account')),
// //                           );
// //                           return const SizedBox.shrink();
// //                         },
// //                       );
// //                     }
// //                     Builder(
// //                       builder: (BuildContext builderContext) {
// //                         ScaffoldMessenger.of(builderContext).showSnackBar(
// //                           const SnackBar(content: Text('Success')),
// //                         );
// //                         return const SizedBox.shrink();
// //                       },
// //                     );
// //                   },
// //                   style: ButtonStyle(
// //                     backgroundColor: MaterialStateProperty.all<Color>(
// //                         const Color(0xff95BDFF)),
// //                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
// //                         RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(20),
// //                     )),
// //                   ),
// //                   child: const Text('Confirm'),
// //                 ),
// //               ]),
// //             ),
// //           )
// //         ]),
// //       ),
// //     );
// //   }
// // }

// // class RoleOption {
// //   final String title;
// //   final String iconPath;
// //   final RoleType type;

// //   const RoleOption({
// //     required this.title,
// //     required this.iconPath,
// //     required this.type,
// //   });
// // }
// //-----------------------
// // if (email == null ||
// //                         password == null ||
// //                         userName == null ||
// //                         _selectedRole == null) {
// //                       if (context.mounted) {
// //                         ScaffoldMessenger.of(context).showSnackBar(
// //                           const SnackBar(
// //                               content: Text('Please fill in all fields')),
// //                         );
// //                       }
// //                       return;
// //                     }

// //                     try {
// //                       var auth = FirebaseAuth.instance;
// //                       UserCredential user =
// //                           await auth.createUserWithEmailAndPassword(
// //                         email: email!,
// //                         password: password!,
// //                       );

// //                       if (context.mounted) {
// //                         ScaffoldMessenger.of(context).showSnackBar(
// //                           const SnackBar(content: Text('Success')),
// //                         );
// //                       }

// //                       FirebaseFirestore.instance
// //                           .collection('users')
// //                           .doc(user.user!.uid)
// //                           .set({
// //                         'username': userName,
// //                         'email': email,
// //                         'accountType': _selectedRole,
// //                       });

// //                       // Navigate to appropriate home screen based on the selected role
// //                       switch (_selectedRole) {
// //                         case RoleType.photographer:
// //                           Get.off(const PhotographerHome());
// //                           break;
// //                         case RoleType.makeupArtist:
// //                           Get.off(const ArtistHome());
// //                           break;
// //                         case RoleType.shop:
// //                           Get.off(const ShopHome());
// //                           break;
// //                         case RoleType.client:
// //                           Get.off(const Home_p());
// //                           break;
// //                         case null:
// //                           if (context.mounted) {
// //                             ScaffoldMessenger.of(context).showSnackBar(
// //                               const SnackBar(
// //                                   content: Text('Invalid role selected')),
// //                             );
// //                           }
// //                           break;
// //                       }
// //                     } on FirebaseAuthException catch (e) {
// //                       if (context.mounted) {
// //                         String errorMessage = 'An error occurred.';

// //                         switch (e.code) {
// //                           case 'email-already-in-use':
// //                             errorMessage =
// //                                 'This email is already used on another account.';
// //                             break;
// //                           case 'invalid-email':
// //                             errorMessage = 'Invalid email address.';
// //                             break;
// //                           case 'weak-password':
// //                             errorMessage =
// //                                 'Weak password. Please choose a stronger password.';
// //                             break;
// //                           // Handle other FirebaseAuthException error codes as needed
// //                         }

// //                         ScaffoldMessenger.of(context).showSnackBar(
// //                           SnackBar(content: Text(errorMessage)),
// //                         );
// //                       }
// //                     } catch (e) {
// //                       if (context.mounted) {
// //                         ScaffoldMessenger.of(context).showSnackBar(
// //                           SnackBar(content: Text('An error occurred.')),
// //                         );
// //                       }
// //                     }
                 