import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:totelx_machine_test/constants/app_theme.dart';
import 'package:totelx_machine_test/firebase_options.dart';
import 'package:totelx_machine_test/providers/auth_provider.dart';
import 'package:totelx_machine_test/providers/home_screen_provider.dart';
import 'package:totelx_machine_test/providers/signout_provider.dart';
import 'package:totelx_machine_test/utils/connectivity_checker/cubit/connectivity_cubit.dart';
import 'package:totelx_machine_test/utils/no_connection_dilogue.dart';
import 'package:totelx_machine_test/utils/shared_preferences_helper.dart';
import 'package:totelx_machine_test/view/ui_utilities/login_check.dart';
import 'di_container.dart' as di;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // SharedPref.instance.initSharedPreferences();
  await di.initDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationProvider(firebaseService: di.sl(),)),
        ChangeNotifierProvider(create: (context)=>HomeScreenProvider(firebaseService: di.sl())),
        ChangeNotifierProvider(create: (context)=>SignOutProvider(firebaseService: di.sl())),
      ],
      child: const MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
      return  MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: handleAuth(),
      );
  }
}
  //   void dismissNoConnectionDialog() {
  //   if (navigatorKey.currentState?.canPop() ?? false) {
  //     navigatorKey.currentState?.pop();
  //   }
  // }