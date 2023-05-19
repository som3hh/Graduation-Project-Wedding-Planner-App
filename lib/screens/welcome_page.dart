// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'Client_login.dart';
// import 'MakeUp_login.dart';
// import 'photographer_login.dart';
// import 'shop_login.dart';

// void main() => runApp(const WelcomeScreen());

// class WelcomeScreen extends StatelessWidget {
//   const WelcomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Container(
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/images/gif wedding.gif'),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 LoginButton(
//                   buttonText: 'Shop Login',
//                   iconPath: 'assets/images/icons8-shop-48.png',
//                   onPressed: () {
//                     Get.to(() => ShopLogin());
//                   },
//                 ),
//                 LoginButton(
//                   buttonText: 'Photographer Login',
//                   iconPath:
//                       'assets/images/icons8-professional-photographer-48.png',
//                   onPressed: () {
//                     // Navigate to photographer and makeup artist login page
//                     Get.to(() => PhotoLogin());
//                   },
//                 ),
//                 LoginButton(
//                   buttonText: 'MakeUp Artist Login',
//                   iconPath: 'assets/images/icons8-makeup-brush-48.png',
//                   onPressed: () {
//                     // Navigate to photographer and makeup artist login page
//                     Get.to(() => MakeUpLogin());
//                   },
//                 ),
//                 LoginButton(
//                   buttonText: 'Client Login',
//                   iconPath: 'assets/images/icons8-romance-48.png',
//                   onPressed: () {
//                     // Navigate to client login page
//                     Get.to(() => ClientLogin());
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class LoginButton extends StatelessWidget {
//   final String buttonText;
//   final String iconPath;
//   final VoidCallback onPressed;

//   const LoginButton({
//     required this.buttonText,
//     required this.iconPath,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           margin: const EdgeInsets.symmetric(vertical: 10),
//           width: 130,
//           height: 100,
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               primary: const Color.fromARGB(255, 221, 148, 172),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//             ),
//             onPressed: onPressed,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   iconPath,
//                   width: 40,
//                   height: 40,
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   buttonText,
//                   style: TextStyle(
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
