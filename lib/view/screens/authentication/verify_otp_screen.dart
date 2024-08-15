import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:totelx_machine_test/constants/app_colors.dart';
import 'package:totelx_machine_test/constants/app_images.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:totelx_machine_test/constants/app_text_styles.dart';
import 'package:totelx_machine_test/view/common_widgets/countdown_timer.dart';
import 'package:totelx_machine_test/view/common_widgets/custom_button.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  String otpCode='00';
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(flex: 1,
                child: SizedBox(
                  child: Center(child: Image.asset(AppImages.laptopImage)),
                )),
                Expanded(flex: 2,child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height*.03,),
                      const Text('OTP verification',style: AppTextStyles.subtitle,),
                      SizedBox(height: size.height*.02,),
                      const Text('Enter the verification code that we just send to your number'),
                      SizedBox(height: size.height*.02,),
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
                              // borderColor: AppColors.primaryColor,
                              showFieldAsBox: true,
                              onCodeChanged: (String code) {},
                              onSubmit: (String verificationCode) {
                                otpCode = verificationCode;
                              }, // end onSubmit
                            ),
                            SizedBox(height: size.height*.01,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CountdownTimerWidget(),
                              ],
                            ),
                            SizedBox(height: size.height*.01,),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: 'Dont get otp? ',
                                    children: [
                                      TextSpan(
                                        text: 'Resend'
                                      )
                                    ]
                                  )
                                ),
                              ],
                            ),
                            SizedBox(height: size.height*.02,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomButtonBlack(text: 'Verify'),
                              ],
                            ),
                    ],
                  ),
                )),
                const Expanded(flex: 2,child: SizedBox()),
              ],
            ),
          ),
        )
        ,
      ),
    );
  }
}