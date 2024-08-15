import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

SnackBar customSnackbar(context, bool error, String messege) {
  return SnackBar(
    content: Text(
      messege,
    ),
    backgroundColor: error ? CupertinoColors.destructiveRed : Colors.teal,
    duration: const Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );
}