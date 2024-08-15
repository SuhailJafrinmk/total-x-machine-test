import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:totelx_machine_test/model/user_model.dart';
import 'package:totelx_machine_test/services/firebase_service.dart';
import 'package:totelx_machine_test/utils/typedef.dart';

part 'userdata_event.dart';
part 'userdata_state.dart';

class UserdataBloc extends Bloc<UserdataEvent, UserdataState> {
  FirebaseService firebaseService=FirebaseService();
  UserCredential ? userCredential;
  UserdataBloc() : super(UserdataInitial()) {
  on<AddNewUser>(addNewUser);
  on<PickImageEvent>(pickImageEvent);
  }

  FutureOr<void> addNewUser(AddNewUser event, Emitter<UserdataState> emit) {
    emit(UserDataAddingState());
    final Result result=firebaseService.addUser(event.userModel);
    result.fold((failure) => emit(UserDataAddErrorState(message: failure)), (success) => UserDataAddedSuccessState());
  }

  FutureOr<void> pickImageEvent(PickImageEvent event, Emitter<UserdataState> emit)async{
    try {
      final ImagePicker imagePicker=ImagePicker();
      final XFile? image=await imagePicker.pickImage(source: ImageSource.gallery);
      if(image!=null){
        emit(ImagePickedState(imageFile: image));
        final result=await firebaseService.uploadImage(image);
        result.fold((left) => ImageUploadingErrorState(message: left), (right) =>ImageUploadedSuccessState(imageUrl: right) );
      }
    } catch (e) {
      emit(ImagePickingErrorState(message: e.toString()));
    }
  }


}
