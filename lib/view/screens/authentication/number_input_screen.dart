import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:totelx_machine_test/constants/app_images.dart';

class PhoneNumberVerificationScreen extends StatefulWidget {
  const PhoneNumberVerificationScreen({super.key});

  @override
  State<PhoneNumberVerificationScreen> createState() => _PhoneNumberVerificationScreenState();
}

class _PhoneNumberVerificationScreenState extends State<PhoneNumberVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return  Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Expanded(
            flex: 1,
            child: SizedBox(
              child: Center(
                child: SvgPicture.asset(AppImages.numberInputScreenSvg),
              ),
            )
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                child: Column(
                  children: [
                    Text('')
                  ],
                ),
              )
              ),
            Expanded(
              flex: 2,
              child: SizedBox()
              )
          ],
        ),
      ),
    );
  }
}