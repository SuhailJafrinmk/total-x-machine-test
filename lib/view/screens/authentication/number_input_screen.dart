import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:totelx_machine_test/constants/app_images.dart';
import 'package:totelx_machine_test/view/common_widgets/custom_button.dart';
import 'package:totelx_machine_test/view/common_widgets/custom_textfield.dart';

class PhoneNumberVerificationScreen extends StatefulWidget {
  const PhoneNumberVerificationScreen({super.key});

  @override
  State<PhoneNumberVerificationScreen> createState() =>
      _PhoneNumberVerificationScreenState();
}

class _PhoneNumberVerificationScreenState
    extends State<PhoneNumberVerificationScreen> {
  final TextEditingController phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: SizedBox(
                  child: Center(
                    child: SvgPicture.asset(
                      AppImages.numberInputScreenSvg,
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            Expanded(
                flex: 1,
                child: SizedBox(
                  child: Column(
                    children: [
                      const Text('Enter phone number'),
                      CustomTextField(
                          hintText: 'Enter phone number',
                          textEditingController: phoneNumberController),
                      const Text.rich(
                        TextSpan(
                          text: 'By continuing, I agree to TotalX\'s ',
                          style: const TextStyle(
                              color: Colors.black), // Default text color
                          children: [
                            TextSpan(
                              text: 'terms and conditions',
                              style: TextStyle(color: Colors.cyan),
                            ),
                            TextSpan(
                              text: ' and ',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: 'privacy policy',
                              style: TextStyle(color: Colors.cyan),
                            ),
                          ],
                        ),
                      ),
                      CustomButtonBlack(text: 'Get Otp'),
                    ],
                  ),
                )),
            const Expanded(flex: 2, child: SizedBox())
          ],
        ),
      ),
    );
  }
}
