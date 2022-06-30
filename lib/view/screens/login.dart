import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
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
      ,
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
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color.fromARGB(255, 124, 199, 126),
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: model.formKey,
            child: Column(
              children: [
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
                const Align(
                  alignment: Alignment.topRight,
                  child: Text("Recovery Password"),
                ),
                largeGAP,

                // login button
                Selector<AuthViewModel, bool>(
                    selector: (p0, p1) => p1.isLoading,
                    builder: (context, isloAd, _) {
                      return isloAd
                          ? const CircularProgressIndicator()
                          : MaterialButton(
                              color: Colors.green,
                              onPressed: () {
                                model.login(context);
                              },
                              child: const Text("Login"),
                            );
                    }),
                //

                medGAP,
                const Text("or contiune with"),
                smallGAP,

                /// social button
                ///
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SignInButton(
                      Buttons.Google,
                      mini: true,
                      onPressed: () {},
                    ),
                    SignInButton(
                      Buttons.Apple,
                      mini: true,
                      onPressed: () {},
                    ),
                    SignInButton(
                      Buttons.Facebook,
                      mini: true,
                      onPressed: () {},
                    ),
                  ],
                ),

                ///
                smallGAP,

                Row(
                  children: [
                    const Text("Not a memeber? "),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Register now",
                        style: TextStyle(color: Colors.green),
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
    );
  }
}
