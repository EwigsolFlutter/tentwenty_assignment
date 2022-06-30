import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tentwenty_assignment/model/auth_repository.dart';
import 'package:tentwenty_assignment/utils/gaps.dart';
import 'package:tentwenty_assignment/view/screens/home_screen.dart';

class AuthViewModel with ChangeNotifier {
  bool isLoading = false;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isViewPass = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  set setIsViewPass(bool val) {
    isViewPass = val;
    notifyListeners();
  }

  Future<void> login(context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    isLoading = true;
    notifyListeners();

    //send request for login
    final _apiResponse = await APIRepository().login(
      email.text,
      password.text,
      "deviceToken",
    );

    if (_apiResponse) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("email", email.text);
      showToast(context, "Login SuccessFully ");
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (builder) => const HomeScreen(),
        ),
        (route) => false,
      );
    } else {
      showToast(context, "Login Failed ");
    }
    isLoading = false;
    notifyListeners();
  }
}
