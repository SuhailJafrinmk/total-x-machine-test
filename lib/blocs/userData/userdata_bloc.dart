import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:totelx_machine_test/development_only/custom_debugger.dart';
import 'package:totelx_machine_test/model/user_model.dart';
import 'package:totelx_machine_test/services/firebase_service.dart';
import 'package:totelx_machine_test/utils/typedef.dart';
import 'dart:developer' as developer;
part 'userdata_event.dart';
part 'userdata_state.dart';

class UserdataBloc extends Bloc<UserdataEvent, UserdataState> {
  FirebaseService firebaseService = FirebaseService();
  UserCredential? userCredential;
  UserdataBloc() : super(UserdataInitial()) {
    on<AddNewUser>(addNewUser);
    on<PickImageEvent>(pickImageEvent);
    on<GetUserDatasEvent>(getUserDatasEvent);
    on<LogOutButtonClickedEvent>(logOutButtonClickedEvent);
  }

  FutureOr<void> addNewUser(AddNewUser event, Emitter<UserdataState> emit)async{
    emit(UserDataAddingState());
    final result = await firebaseService.addUser(event.userModel);
    result.fold((failure) => emit(UserDataAddErrorState(message: failure)),
        (success) => emit(UserDataAddedSuccessState()));
  }

  FutureOr<void> pickImageEvent(
      PickImageEvent event, Emitter<UserdataState> emit) async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      final XFile? image =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        emit(ImagePickedState(imageFile: image));
        final result = await firebaseService.uploadImage(image);
        result.fold((left) => emit(ImageUploadingErrorState(message: left)),
            (right) => emit(ImageUploadedSuccessState(imageUrl: right)));
      }
    } catch (e) {
      logError('there is an error ${e.toString()}');
      emit(ImagePickingErrorState(message: e.toString()));
    }
  }

  FutureOr<void> getUserDatasEvent(
      GetUserDatasEvent event, Emitter<UserdataState> emit)async{
        logInfo('get user event is running...');
    final result = await firebaseService.getUsers();
    result.fold((left) => emit(UserDatasFetchingError(errorMessage: left)),
        (right) => emit(UserDatasFetchedSuccess(users: right)));
  }

  FutureOr<void> logOutButtonClickedEvent(LogOutButtonClickedEvent event, Emitter<UserdataState> emit)async{
    final  response=await firebaseService.logoutUser();
    response.fold((left) => emit(UserLogOutError(message: left)), (right) => emit(UserLogOutSuccess()));
  }
}
