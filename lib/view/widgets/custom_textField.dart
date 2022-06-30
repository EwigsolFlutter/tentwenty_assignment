import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_assignment/utils/email_validator.dart';
import 'package:tentwenty_assignment/view_model/auth_view_model.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    required this.errorMsg,
    required this.isPassword,
  }) : super(key: key);

  final String label;
  final TextEditingController controller;
  final String errorMsg;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Selector<AuthViewModel, bool>(
          selector: (p0, p1) => p1.isViewPass,
          builder: (context, isTrue, _) {
            return TextFormField(
              controller: controller,
              readOnly: isPassword ? isTrue : false,
              validator: _validator,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabled: true,
                hintText: label,
                suffixIcon: isPassword
                    ? _toggleView(isTrue, context)
                    : const SizedBox.shrink(),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  gapPadding: 5.0,
                  borderSide: const BorderSide(
                    color: Colors.black12,
                  ),
                ),
              ),
            );
          }),
    );
  }

  String? _validator(String? txt) {
    if (label.contains("email")) {
      if (!EmailValidator.validate(txt!)) {
        return errorMsg;
      }
    } else if (label.contains('password')) {
      if (txt!.length < 8) return errorMsg;
    }
    return null;
  }

  Widget _toggleView(bool isView, BuildContext context) {
    return isView
        ? IconButton(
            onPressed: () {
              context.read<AuthViewModel>().setIsViewPass = false;
            },
            icon: const Icon(Icons.visibility),
          )
        : IconButton(
            onPressed: () {
              context.read<AuthViewModel>().setIsViewPass = true;
            },
            icon: const Icon(Icons.visibility_off),
          );
  }
}
