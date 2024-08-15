import 'package:flutter/material.dart';
import 'package:totelx_machine_test/constants/app_images.dart';
import 'package:totelx_machine_test/utils/validators.dart';
import 'package:totelx_machine_test/view/common_widgets/custom_textfield.dart';

void showCustomBottomSheet(BuildContext context) {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController userageController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    builder: (BuildContext context) {
      final Size size = MediaQuery.of(context).size;

      return SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            height: size.height * .5,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Add new user',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(AppImages.profileImg),
                          ),
                          Positioned(
                              bottom: 0,
                              left: size.width * .06,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                    size: 30,
                                  )))
                        ],
                      ),
                    ],
                  ),
                  CustomTextField(
                    validator: (value) => ValidatorFunctions.nameValidation(value),
                    inputType: TextInputType.text,
                      hintText: 'User name',
                      textEditingController: usernameController),
                  SizedBox(
                    height: size.height * .01,
                  ),
                  CustomTextField(
                    validator: (value) => ValidatorFunctions.ageValidation(value),
                    inputType: TextInputType.number,
                      hintText: 'age',
                       textEditingController: userageController),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(onPressed: () {
                        Navigator.pop(context);
                      }, child: Text('cancel')),
                      SizedBox(
                        width: size.width * .05,
                      ),
                      ElevatedButton(onPressed: () {

                      }, child: Text('Save')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
