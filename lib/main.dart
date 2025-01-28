import 'package:flutter/material.dart';
import 'package:propcheckmate/root_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preffs = await SharedPreferences.getInstance();
  runApp(RootApp(preffs: preffs));
}
