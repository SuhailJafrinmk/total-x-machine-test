// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:totelx_machine_test/blocs/userData/userdata_bloc.dart';
// import 'package:totelx_machine_test/view/screens/authentication/number_input_screen.dart';

// void showLogoutConfirmationDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Confirm Logout'),
//         content: Text('Are you sure you want to log out?'),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); 
//             },
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//             BlocProvider.of<UserdataBloc>(context).add(LogOutButtonClickedEvent());
//             },
//             child: Text('Logout'),
//           ),
//         ],
//       );
//     },
//   );
// }
