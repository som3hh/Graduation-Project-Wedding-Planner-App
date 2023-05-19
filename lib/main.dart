import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_ptoj/screens/regestration_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/client_home.dart';
import 'screens/login_page.dart';
import 'screens/welcome_page.dart';
import 'widgets/google_maps.dart';
import 'widgets/map_api.dart';
import 'package:stack_trace/stack_trace.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const WeddingPlanner());
}

class WeddingPlanner extends StatelessWidget {
  const WeddingPlanner({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
