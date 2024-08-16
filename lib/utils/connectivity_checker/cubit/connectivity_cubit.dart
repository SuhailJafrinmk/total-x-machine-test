
import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<InternetStatus> {
  ConnectivityCubit() : super(const InternetStatus(ConnectivityStatus.disconnected)){
    checkConnectivity();
  }

  void checkConnectivity()async{
    var connectivityResult=await Connectivity().checkConnectivity();
    _updateConnectivityStatus(connectivityResult);
  }
  void _updateConnectivityStatus(List<ConnectivityResult> result){
    if(result.contains(ConnectivityResult.mobile)||result.contains(ConnectivityResult.wifi)){
      emit(const InternetStatus(ConnectivityStatus.connected));
    }else{
      emit(const InternetStatus(ConnectivityStatus.disconnected));
    }
    log('The function is checking the intenet connection');
  }

  late StreamSubscription<List<ConnectivityResult?>> _subscription;
  void trackConnectivityChange(){
    _subscription=Connectivity().onConnectivityChanged.listen((result) { 
    _updateConnectivityStatus(result);
    });

  }
  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}