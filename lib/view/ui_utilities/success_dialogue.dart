import 'package:flutter/material.dart';

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Icon(Icons.check_circle, color: Colors.green, size: 48),
        content: Text(
          'Data added successfully!',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.green, fontSize: 16),
              ),
            ),
          ),
        ],
      );
    },
  );
}
