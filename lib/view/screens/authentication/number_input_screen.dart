import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:provider/provider.dart';
import 'package:totelx_machine_test/constants/app_images.dart';
import 'package:totelx_machine_test/constants/app_text_styles.dart';
import 'package:totelx_machine_test/providers/auth_provider.dart';
import 'package:totelx_machine_test/utils/custom_snackbar.dart';
import 'package:totelx_machine_test/utils/validators.dart';
import 'package:totelx_machine_test/view/common_widgets/custom_button.dart';
import 'package:totelx_machine_test/view/common_widgets/custom_textfield.dart';
import 'package:totelx_machine_test/view/screens/authentication/verify_otp_screen.dart';
import 'package:flutter/scheduler.dart'; // For post-frame callback

class PhoneNumberVerificationScreen extends StatefulWidget {
  const PhoneNumberVerificationScreen({super.key});

  @override
  State<PhoneNumberVerificationScreen> createState() =>
      _PhoneNumberVerificationScreenState();
}

class _PhoneNumberVerificationScreenState
    extends State<PhoneNumberVerificationScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Image.asset(AppImages.numberInputScreenSvg),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * .03),
                          const Text(
                            'Enter phone number',
                            style: AppTextStyles.subtitle,
                          ),
                          SizedBox(height: size.height * .01),
                          CustomTextField(
                            validator: (value) =>
                                ValidatorFunctions.phoneNumberValidate(value),
                            inputType: TextInputType.number,
                            hintText: 'Enter phone number',
                            textEditingController: phoneNumberController,
                          ),
                          SizedBox(height: size.height * .02),
                          const Text.rich(
                            TextSpan(
                              text: 'By continuing, I agree to TotalX\'s ',
                              style: TextStyle(color: Colors.black),
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
                          SizedBox(height: size.height * .02),
                          CustomButtonBlack(
                            text: 'Login',
                            ontap: () {
                              developer.log('button is clicked');
                              if (formKey.currentState!.validate()) {
                                developer.log(
                                    'the phone number in textfield is ${phoneNumberController.text}');
                                context.read<AuthenticationProvider>().sendOtpToPhone(
                                      '+91${phoneNumberController.text.trim()}',
                                    );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  customSnackbar(
                                    context,
                                    true,
                                    'Phone number is not valid',
                                  ),
                                );
                              }
                            },
                            btntxt: Consumer<AuthenticationProvider>(
                              builder: (context, authProvider, child) {
                                // Listen to changes in the AuthState
                                if (authProvider.state == AuthState.loading) {
                                  return CircularProgressIndicator(
                                    color: Colors.white,
                                  );
                                }

                                if (authProvider.state == AuthState.error) {
                                  // Schedule the snackbar to display after build
                                  SchedulerBinding.instance
                                      .addPostFrameCallback((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      customSnackbar(
                                        context,
                                        true,
                                        authProvider.errorMessage,
                                      ),
                                    );
                                  });
                                }

                                if (authProvider.state == AuthState.idle) {
                                  return const Text(
                                    'Send Otp',
                                    style: AppTextStyles.button,
                                  );
                                }

                                if (authProvider.state == AuthState.otpSended) {
                                  SchedulerBinding.instance
                                      .addPostFrameCallback((_) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => VerifyOtpScreen(
                                          verificationId:
                                              authProvider.firebaseVerificationId, // Use correct verification ID here
                                        ),
                                      ),
                                    );
                                  });
                                }

                                return const Text('Send Otp',
                                    style: AppTextStyles.button);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(flex: 2, child: SizedBox()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
