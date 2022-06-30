import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_button/sign_button.dart';
import 'package:tentwenty_assignment/utils/gaps.dart';
import 'package:tentwenty_assignment/view/widgets/custom_textField.dart';
import 'package:tentwenty_assignment/view_model/auth_view_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthViewModel>(
      create: (create) => AuthViewModel(),
      child: const LoginWidget(),
    );
  }
}

class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthViewModel>();
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.white24.withOpacity(0.4),
              const Color.fromARGB(255, 181, 240, 183),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: model.formKey,
              child: Column(
                children: [
                  largeGAP,
                  const Text(
                    "Hello Again",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const Text(
                    "Chance to get your life better",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  medGAP,
                  // textFields email
                  CustomTextField(
                    label: "Enter email",
                    controller: model.email,
                    errorMsg: "Please Enter correct email",
                    isPassword: false,
                  ),
                  // textFields password
                  CustomTextField(
                    label: "Enter password",
                    controller: model.password,
                    errorMsg: "fill this field (length 8)",
                    isPassword: true,
                  ),
                  largeGAP,
                  // recovery btn
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text("Recovery Password"),
                    ),
                  ),
                  largeGAP,

                  // login button
                  Selector<AuthViewModel, bool>(
                      selector: (p0, p1) => p1.isLoading,
                      builder: (context, isloAd, _) {
                        return isloAd
                            ? const CircularProgressIndicator()
                            : Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                width: MediaQuery.of(context).size.width,
                                child: MaterialButton(
                                  color: Colors.green,
                                  onPressed: () {
                                    model.login(context);
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                      }),
                  //

                  medGAP,
                  const Text("or contiune with"),
                  smallGAP,

                  /// social button
                  ///
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SignInButton.mini(
                        buttonType: ButtonType.google,
                        onPressed: () {},
                      ),
                      SignInButton.mini(
                        buttonType: ButtonType.apple,
                        onPressed: () {},
                      ),
                      SignInButton.mini(
                        buttonType: ButtonType.facebook,
                        onPressed: () {},
                      ),
                    ],
                  ),

                  ///
                  smallGAP,

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Not a memeber? "),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Register now",
                          style:
                              TextStyle(color: Color.fromARGB(255, 2, 37, 3)),
                        ),
                      )
                    ],
                  ),
                  largeGAP,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
