import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:totelx_machine_test/providers/auth_provider.dart';
import 'package:totelx_machine_test/services/firebase_service.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Registering Firebase instances
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);
  sl.registerLazySingleton(() => User);

  // Registering FirebaseService with injected dependencies
  sl.registerLazySingleton(() => FirebaseService(
    auth: sl<FirebaseAuth>(),
    firestore: sl<FirebaseFirestore>(),
    storage: sl<FirebaseStorage>(),
    user: sl<User>()
  ));

  // Registering other providers/services
  // sl.registerLazySingleton(() => AuthenticationProvider(
  //   firebaseService: sl(),
  // ));
}
