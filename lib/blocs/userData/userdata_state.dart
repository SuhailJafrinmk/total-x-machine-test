part of 'userdata_bloc.dart';

@immutable
sealed class UserdataState {}

class UserdataInitial extends UserdataState {}
class UserDataAddingState extends UserdataState{}
class UserDataAddedSuccessState extends UserdataState{}
class UserDataAddErrorState extends UserdataState{
  final String message;

  UserDataAddErrorState({required this.message});
}
class ImagePickedState extends UserdataState{
  final XFile imageFile;
  ImagePickedState({required this.imageFile});
}
class ImagePickingErrorState extends UserdataState{
  final String message;
  ImagePickingErrorState({required this.message});
}
class ImageUploadingErrorState extends UserdataState{
  final String message;
  ImageUploadingErrorState({required this.message});
}
class ImageUploadedSuccessState extends UserdataState{
  final String imageUrl;
  ImageUploadedSuccessState({required this.imageUrl});
}

class UserDatasFetchedSuccess extends UserdataState{
  final List<UserModel> users;
  UserDatasFetchedSuccess({required this.users});

}
class UserDatasFetchingError extends UserdataState{
  final String errorMessage;
  UserDatasFetchingError({required this.errorMessage});
}

class UserLogOutSuccess extends UserdataState{}
class UserLogOutError extends UserdataState{
  final String message;
  UserLogOutError({required this.message});

}