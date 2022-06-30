import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tentwenty_assignment/view/screens/home_screen.dart';
import 'package:tentwenty_assignment/view/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences pref = await SharedPreferences.getInstance();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(
      MyApp(
        isAlreadyLogin: pref.containsKey('email'),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final bool isAlreadyLogin;

  const MyApp({
    Key? key,
    required this.isAlreadyLogin,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'TASk',
      theme: ThemeData(primarySwatch: Colors.green),
      home: isAlreadyLogin ? const HomeScreen() : const LoginScreen(),
    );
  }
}
