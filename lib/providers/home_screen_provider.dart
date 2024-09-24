import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:totelx_machine_test/model/user_model.dart';
import 'package:totelx_machine_test/services/firebase_service.dart';

enum HomeScreenState{idle,loading,success,error}
class HomeScreenProvider with ChangeNotifier{
  HomeScreenProvider({required this.firebaseService});
  final FirebaseService firebaseService;
  HomeScreenState _state = HomeScreenState.idle;
  String _errorMessage='';
  List<UserModel> _users=[];
  HomeScreenState get state => _state;
  String get errorMessage => _errorMessage;
  List<UserModel> get users => _users;
  Future<void> addNewUser(UserModel userModel)async{
    _state=HomeScreenState.loading;
    try {
      final response=await firebaseService.addUser(userModel);
      response.fold((left){
        _state=HomeScreenState.error;
        _errorMessage=left;
      }, (right){
        _state=HomeScreenState.success;
      });
    } catch (e) {
      _state=HomeScreenState.error;
      _errorMessage=e.toString();
    }
  }

  Future<void> getAllUsers()async{
    _state=HomeScreenState.loading;
    try {
      final response=firebaseService.getUsers();
      response.fold((left){
        _errorMessage=left;
        _state=HomeScreenState.error;
      }, (right){
        _users=right;
        _state=HomeScreenState.success;
      });
    } catch (e) {
      _state=HomeScreenState.error;
      _errorMessage=e.toString();
    }
  }
}