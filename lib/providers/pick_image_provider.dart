import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:totelx_machine_test/services/firebase_service.dart';
enum ImageProviderState{pickedImage,imageNotPicked,errorPickingImage,errorUploading,uploadedImage}
class PickImageProvider with ChangeNotifier{
  final FirebaseService firebaseService;
  PickImageProvider({required this.firebaseService});
  ImageProviderState _state=ImageProviderState.imageNotPicked;
  XFile ? _image;
  String _errorMessage='';
  String ? _imageUrl;
  XFile ? get image => _image;
  ImageProviderState get state => _state;
  String get errorMessage => _errorMessage;
  String ? get imageUrl => _imageUrl;
  Future<void> pickImage()async{
    try {
      final ImagePicker imagePicker=ImagePicker();
      _image=await imagePicker.pickImage(source: ImageSource.gallery);
      _state=ImageProviderState.pickedImage;
    } catch (e) {
      _state=ImageProviderState.errorPickingImage;
      _errorMessage=e.toString();
    }
    notifyListeners();
  }

  Future<void>uploadImage(XFile ? image)async{
    if(image!=null){
      final response=await firebaseService.uploadImage(image);
      response.fold((left){
      _errorMessage=left;
      _state=ImageProviderState.errorUploading;
      }, 
      (right){
        _state=ImageProviderState.uploadedImage;
        _imageUrl=right;
      });
    }
  }
}