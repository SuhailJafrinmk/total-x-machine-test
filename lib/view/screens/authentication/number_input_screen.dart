import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:totelx_machine_test/blocs/authentication/authentication_bloc.dart';
import 'package:totelx_machine_test/constants/app_images.dart';
import 'package:totelx_machine_test/utils/custom_snackbar.dart';
import 'package:totelx_machine_test/utils/validators.dart';
import 'package:totelx_machine_test/view/common_widgets/custom_button.dart';
import 'package:totelx_machine_test/view/common_widgets/custom_textfield.dart';
import 'dart:developer' as developer;

class PhoneNumberVerificationScreen extends StatefulWidget {
  const PhoneNumberVerificationScreen({super.key});

  @override
  State<PhoneNumberVerificationScreen> createState() =>
      _PhoneNumberVerificationScreenState();
}

class _PhoneNumberVerificationScreenState
    extends State<PhoneNumberVerificationScreen> {
  final  formkey = GlobalKey<FormState>();
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
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                        child: Center(
                         child: Image.asset(AppImages.numberInputScreenSvg),
                        ),
                      )),
                  Expanded(
                      flex: 2,
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Enter phone number'),
                            CustomTextField(
                              validator: (value) =>ValidatorFunctions.phoneNumberValidate(value),
                              inputType: TextInputType.number,
                                hintText: 'Enter phone number',
                                textEditingController: phoneNumberController
                                ),
                            const Text.rich(
                              TextSpan(
                                text: 'By continuing, I agree to TotalX\'s ',
                                style: const TextStyle(
                                    color: Colors.black), 
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
                            CustomButtonBlack(
                              text: 'Login',
                              ontap: () {
                                developer.log('button is clicked');
                                if(formkey.currentState!.validate()){
                                  BlocProvider.of<AuthenticationBloc>(context).add(SendOtpToPhone(phoneNumber: '+91${phoneNumberController.text.trim()}'));
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(customSnackbar(context, true, 'Phone number is not valid'));
                                }
                              },
                              btntxt: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                                builder: (context, state) {
                                  if(state is LoginScreenLoadingState){
                                    return CircularProgressIndicator();
                                  }else{
                                    return Text('Login');
                                  }
                                 
                                },
                              ),
                              ),
                          ],
                        ),
                      )),
                  const Expanded(flex: 2, child: SizedBox())
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
