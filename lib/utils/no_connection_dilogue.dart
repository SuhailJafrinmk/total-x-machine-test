  import 'package:flutter/material.dart';
import 'package:totelx_machine_test/main.dart';

void showNoConnectionDialog() {
    final context = navigatorKey.currentState?.overlay?.context;
    if (context != null) {
      showDialog(
        context: context,
        barrierDismissible: false, 
        builder: (context) => WillPopScope(
          onWillPop: () async => false, 
          child: AlertDialog(
            title: const Text('No Connection'),
            content: const Text('You are not connected to the internet.\nPlease connect to the internet to dismiss this dialogue'),
            actions: [
              TextButton(
                onPressed: () {},
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      );
    }
  }