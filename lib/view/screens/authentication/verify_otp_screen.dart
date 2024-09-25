
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'package:totelx_machine_test/constants/app_colors.dart';
import 'package:totelx_machine_test/constants/app_images.dart';
import 'package:totelx_machine_test/constants/app_text_styles.dart';
import 'package:totelx_machine_test/development_only/custom_debugger.dart';
import 'package:totelx_machine_test/providers/auth_provider.dart';
import 'package:totelx_machine_test/utils/custom_snackbar.dart';
import 'package:totelx_machine_test/view/common_widgets/countdown_timer.dart';
import 'package:totelx_machine_test/view/common_widgets/custom_button.dart';
import 'package:totelx_machine_test/view/screens/user/home_screen.dart';


class VerifyOtpScreen extends StatefulWidget {
  final String verificationId;
  const VerifyOtpScreen({super.key, required this.verificationId});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  String otpCode = '';
  @override
  void initState() {
    super.initState();
    context.read<AuthenticationProvider>().resetStates();
    logInfo('current state is ${context.read<AuthenticationProvider>().state}');
    
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    child: Center(child: Image.asset(AppImages.laptopImage)),
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
                          'OTP verification',
                          style: AppTextStyles.subtitle,
                        ),
                        SizedBox(height: size.height * .02),
                        const Text('Enter the verification code that we just sent to your number'),
                        SizedBox(height: size.height * .02),
                        OtpTextField(
                          borderColor: Colors.black38,
                          focusedBorderColor: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          contentPadding: const EdgeInsets.all(3),
                          fieldHeight: size.width * .12,
                          fieldWidth: size.width * .12,
                          keyboardType: TextInputType.number,
                          textStyle: const TextStyle(color: Colors.black),
                          filled: true,
                          fillColor: Colors.white,
                          numberOfFields: 6,
                          showFieldAsBox: true,
                          onCodeChanged: (String code) {},
                          onSubmit: (String verificationCode) {
                            otpCode = verificationCode;
                          },
                        ),
                        SizedBox(height: size.height * .01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CountdownTimerWidget(),
                          ],
                        ),
                        SizedBox(height: size.height * .01),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text.rich(TextSpan(text: 'Didn\'t get OTP?', children: [TextSpan(text: ' Resend')])),
                          ],
                        ),
                        SizedBox(height: size.height * .02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Use Consumer to listen for changes in AuthenticationProvider
                            Consumer<AuthenticationProvider>(
                              builder: (context, authProvider, child) {
                                // Handle different states from AuthProvider
                                if (authProvider.state == AuthState.loading) {
                                  return const CircularProgressIndicator();
                                }

                                if (authProvider.state == AuthState.error) {
                                  Future.delayed(Duration.zero, () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(authProvider.errorMessage),
                                      ),
                                    );
                                  });
                                }

                                if (authProvider.state == AuthState.verified) {
                                  Future.delayed(Duration.zero, () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HomeScreen(),
                                      ),
                                    );
                                  });
                                }

                                return CustomButtonBlack(
                                  text: 'verfiy',
                                  btntxt: Consumer<AuthenticationProvider>(builder: (context, value, child) {
                                    logInfo('current value of state is ${value.state}');
                                    if(value.state==AuthState.loading){
                                       return CircularProgressIndicator(
                                    color: Colors.white,
                                  );   
                                    }
                                      return const Text('Send Otp',
                                    style: AppTextStyles.button);
                                  },),
                                  ontap: () {
                                    Provider.of<AuthenticationProvider>(context,listen: false).verifyRecievedOtp(widget.verificationId, otpCode);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
