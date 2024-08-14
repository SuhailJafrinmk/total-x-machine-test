import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:totelx_machine_test/firebase_options.dart';
import 'package:totelx_machine_test/utils/shared_preferences_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPref.instance.initSharedPreferences();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}