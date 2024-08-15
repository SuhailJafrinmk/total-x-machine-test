part of 'userdata_bloc.dart';

@immutable
sealed class UserdataEvent {}
class AddNewUser extends UserdataEvent{
  final UserModel userModel;
  AddNewUser({required this.userModel});
}
class PickImageEvent extends UserdataEvent{}


