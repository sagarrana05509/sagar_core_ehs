import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sagar_core_ehs_demo/di.dart';

class NetworkManager extends GetxController {
  //this variable 0 = No Internet, 1 = connected to WIFI ,2 = connected to Mobile Data.
  var connectionType = 0.obs;

  //Instance of Flutter Connectivity
  final Connectivity _connectivity = Connectivity();

  //Stream to keep listening to network change state
  late StreamSubscription _streamSubscription;

  @override
  void onInit() async {
    await getConnectionType();

    _streamSubscription = _connectivity.onConnectivityChanged.listen(
      _updateState,
    );
    Future.delayed(Duration(seconds: 2), () {
      DependencyInjection.isAppOpened.value = true;
    });
    super.onInit();
  }

  // @override
  // void onInit() {
  //   getConnectionType();
  //   _streamSubscription =
  //       _connectivity.onConnectivityChanged.listen(_updateState);
  // }

  // a method to get which connection result, if you we connected to internet or no if yes then which network
  Future<void> getConnectionType() async {
    List<ConnectivityResult>? connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      print(e);
    }
    return _updateState(connectivityResult!);
  }

  // state update, of network, if you are connected to WIFI connectionType will get set to 1,
  // and update the state to the consumer of that variable.
  _updateState(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.none)) {
      Get.snackbar(
        "Alert",
        "Please check Internet connection",
        colorText: Colors.red,
      );
      DependencyInjection.isConnected.value = false;
    } else {
      DependencyInjection.isConnected.value = true;
      if (DependencyInjection.isAppOpened.value) {
        Get.snackbar("Success", "Internet Connected");
        DependencyInjection().fetchData();
      }
    }
  }

  @override
  void onClose() {
    //stop listening to network state when app is closed
    _streamSubscription.cancel();
  }
}
