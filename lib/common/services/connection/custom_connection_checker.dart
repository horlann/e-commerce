import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'dns_check_helper.dart';

@lazySingleton
class CustomConnectionChecker {
  CustomConnectionChecker() : _dnsCheckHelper = DnsCheckHelper.instance {
    _initStatus();
    _internetStatusSubscription = InternetConnectionChecker().onStatusChange.listen(_setInternetStatus);
    _connectivityStatusSubscription = Connectivity().onConnectivityChanged.listen(_setConnectionStatus);
  }

  final DnsCheckHelper _dnsCheckHelper;

  bool _isInternetAvailable = true;
  late StreamSubscription<InternetConnectionStatus> _internetStatusSubscription;
  late StreamSubscription<ConnectivityResult> _connectivityStatusSubscription;
  ConnectivityResult _currentConnectivityState = ConnectivityResult.none;
  final Stream<InternetConnectionStatus> _connectionInternetStream =
      InternetConnectionChecker().onStatusChange.distinct();

  /// Value of network type (wi-fi, mobile, etc)
  ConnectivityResult get currentConnectivityState => _currentConnectivityState;

//Stream that can be listened for internet connection status changes
  Stream<InternetConnectionStatus> get internetConnectionStream => _connectionInternetStream;

  /// Internet connection availability for the past 10 seconds
  bool get isInternetAvailable => _isInternetAvailable;

  Future<void> _initStatus() async {
    InternetConnectionChecker().addresses = await _dnsCheckHelper.getCurrentDnsList();
  }

  Future<void> _setInternetStatus(InternetConnectionStatus status) async {
    switch (status) {
      case InternetConnectionStatus.connected:
        _isInternetAvailable = true;
        break;
      case InternetConnectionStatus.disconnected:
        _isInternetAvailable = false;
        break;
    }
  }

  /// Check connection to wi-fi, bluetooth, etc.
  Future<void> _setConnectionStatus(ConnectivityResult result) async {
    _currentConnectivityState = result;
  }

  /// Internet connection availability
  Future<bool> get isInternetConnectionAvailable async => await InternetConnectionChecker().hasConnection;

  Future<void> changeDNSConnectionType() async {
    InternetConnectionChecker().addresses = await _dnsCheckHelper.getNextDnsList();
  }

  Future<void> dispose() async {
    _internetStatusSubscription.cancel();
    _connectivityStatusSubscription.cancel();
  }
}
