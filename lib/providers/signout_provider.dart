import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:totelx_machine_test/services/firebase_service.dart';
enum AuthState{signedIn,signedOut,error}
class SignOutProvider with ChangeNotifier{
final FirebaseService firebaseService;
SignOutProvider({required this.firebaseService});
AuthState _state=AuthState.signedIn;
String _errorMessage = '';
String get errorMessage => _errorMessage;
AuthState get state => _state;
Future<void> signOutUser()async{
if(firebaseService.auth.currentUser!=null){
  final response=await firebaseService.logoutUser();
  response.fold((left){
    _state=AuthState.error;
    _errorMessage=left;
  }, (right){
    _state=AuthState.signedOut;
  });
}
notifyListeners();
}
}