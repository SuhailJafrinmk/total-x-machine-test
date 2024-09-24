// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:totelx_machine_test/blocs/userData/userdata_bloc.dart';
// import 'package:totelx_machine_test/constants/app_images.dart';
// import 'package:totelx_machine_test/development_only/custom_debugger.dart';
// import 'package:totelx_machine_test/model/user_model.dart';
// import 'package:totelx_machine_test/utils/custom_snackbar.dart';
// import 'package:totelx_machine_test/utils/validators.dart';
// import 'package:totelx_machine_test/view/common_widgets/custom_textfield.dart';
// import 'dart:developer' as developer;

// void showCustomBottomSheet(BuildContext context) {
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController userageController = TextEditingController();
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   String ? imageUrl;
//   XFile ? imageFile;
//   showModalBottomSheet(
//     isScrollControlled: true,
//     context: context,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
//     ),
//     builder: (BuildContext context) {
//       final Size size = MediaQuery.of(context).size;

//       return BlocListener<UserdataBloc, UserdataState>(
//         listener: (context, state) {
//           developer.log('the current state of the application is $state');
//           if(state is ImagePickedState){
//             developer.log('the state is imagepicked state and file is ${state.imageFile}');
//             imageFile=state.imageFile;
//           }
//           else if(state is ImageUploadedSuccessState){
//             developer.log('the state is image uploaded success state and the url is ${state.imageUrl}');
//             imageUrl=state.imageUrl;
//           }
//         },
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.only(
//               bottom: MediaQuery.of(context).viewInsets.bottom,
//             ),
//             child: Container(
//               padding: const EdgeInsets.all(16.0),
//               height: size.height * .6,
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
//               ),
//               child: Form(
//                 key: formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Center(
//                       child: Container(
//                         height: 5,
//                         width: 50,
//                         decoration: BoxDecoration(
//                           color: Colors.grey[300],
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     const Text(
//                       'Add new user',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Stack(
//                           children: [
//                             const CircleAvatar(
//                               radius: 50,
//                               backgroundImage: AssetImage(AppImages.profileImg),
//                             ),
//                             Positioned(
//                                 bottom: 0,
//                                 left: size.width * .06,
//                                 child: IconButton(
//                                     onPressed: () {
//                                       BlocProvider.of<UserdataBloc>(context)
//                                           .add(PickImageEvent());
//                                     },
//                                     icon: const Icon(
//                                       Icons.camera_alt_outlined,
//                                       color: Colors.white,
//                                       size: 30,
//                                     )))
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: size.height*.05,),
//                     CustomTextField(
//                         validator: (value) =>
//                             ValidatorFunctions.nameValidation(value),
//                         inputType: TextInputType.text,
//                         hintText: 'User name',
//                         textEditingController: usernameController),
//                     SizedBox(
//                       height: size.height * .01,
//                     ),
//                     CustomTextField(
//                         validator: (value) =>
//                             ValidatorFunctions.ageValidation(value),
//                         inputType: TextInputType.number,
//                         hintText: 'age',
//                         textEditingController: userageController),
//                         SizedBox(height: size.height*.02,),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         ElevatedButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             child: Text('cancel')),
//                         SizedBox(
//                           width: size.width * .05,
//                         ),
//                         ElevatedButton(
//                             onPressed: () {
//                               if (formKey.currentState!.validate()) {
//                                 developer.log('the image url is $imageUrl');
//                                 logInfo('the image picked image file is ${imageFile}');
//                                 BlocProvider.of<UserdataBloc>(context)
//                                 .add(AddNewUser(userModel: UserModel(username: usernameController.text.trim(), age: int.parse(userageController.text.trim()),imageUrl: imageUrl)));
//                                 BlocProvider.of<UserdataBloc>(context).add(GetUserDatasEvent());
//                               } else {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                     customSnackbar(
//                                         context, true, 'Invelid credentials'));
//                               }
//                             },
//                             child: Text('Save')),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }
