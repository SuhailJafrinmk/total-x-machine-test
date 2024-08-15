import 'package:flutter/material.dart';
import 'package:totelx_machine_test/view/ui_utilities/bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(onPressed: (){
        showCustomBottomSheet(context);
      },child: Icon(Icons.add),),
      appBar: AppBar(

      ),
    );
  }
}