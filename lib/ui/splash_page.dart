import 'package:flutter/material.dart';
import 'package:propcheckmate/common/colors.dart';
import 'package:propcheckmate/ui/homepage.dart';

import '../common/preffs_manager.dart';

class SplashScreen extends StatefulWidget {
  final PreferenceManager preffs;

  const SplashScreen({super.key, required this.preffs});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkSession();
    super.initState();
  }

  checkSession() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
        body: Center(
      child: Image.asset(
        'assets/images/app_icon.png',
        height: 100,
        width: 100,
      ),
    ));
  }
}
