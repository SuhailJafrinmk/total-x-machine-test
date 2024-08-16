import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:totelx_machine_test/blocs/authentication/authentication_bloc.dart';
import 'package:totelx_machine_test/blocs/userData/userdata_bloc.dart';
import 'package:totelx_machine_test/constants/app_theme.dart';
import 'package:totelx_machine_test/firebase_options.dart';
import 'package:totelx_machine_test/utils/shared_preferences_helper.dart';
import 'package:totelx_machine_test/view/ui_utilities/login_check.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPref.instance.initSharedPreferences();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthenticationBloc(LoginScreenInitialState()),
      ),
      BlocProvider(
        create: (context) => UserdataBloc(),
      )
    ],
    child: const MyApp(),
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: handleAuth(),
    );
  }
}
