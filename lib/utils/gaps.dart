import 'package:flutter/material.dart';

const smallGAP = SizedBox(height: 15);
const medGAP = SizedBox(height: 20);
const largeGAP = SizedBox(height: 25);

showToast(context, String data) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(data),
    ),
  );
}
