import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
  SharedPref._();
  static final _instance=SharedPref._();
  static SharedPref get instance=>_instance;
  late SharedPreferences sharedPref;
  void initSharedPreferences()async{
    sharedPref=await SharedPreferences.getInstance();
  }

}