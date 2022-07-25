import 'dart:io';

import 'package:internet_connection_checker/internet_connection_checker.dart';

class DnsCheckHelper {
  DnsCheckHelper._();

  static final DnsCheckHelper instance = DnsCheckHelper._();

  OpenDNS? _currentOpenDns;
  static const _timeOut = Duration(seconds: 8);

  OpenDNS? get currentOpenDns => _currentOpenDns;

  //Google open DNS
  final List<AddressCheckOptions> _google8888 = List<AddressCheckOptions>.unmodifiable([
    AddressCheckOptions(InternetAddress('8.8.8.8', type: InternetAddressType.IPv4), timeout: _timeOut),
    AddressCheckOptions(InternetAddress('2001:4860:4860::8844', type: InternetAddressType.IPv6), timeout: _timeOut),
  ]);

  final List<AddressCheckOptions> _google8844 = List<AddressCheckOptions>.unmodifiable([
    AddressCheckOptions(InternetAddress('8.8.4.4', type: InternetAddressType.IPv4), timeout: _timeOut),
    AddressCheckOptions(InternetAddress('2001:4860:4860::8844', type: InternetAddressType.IPv6), timeout: _timeOut),
  ]);

  //CloudFire open DNS
  final List<AddressCheckOptions> _cloudFire1111 = List<AddressCheckOptions>.unmodifiable([
    AddressCheckOptions(InternetAddress('1.1.1.1', type: InternetAddressType.IPv4), timeout: _timeOut),
    AddressCheckOptions(InternetAddress('2606:4700:4700::1111', type: InternetAddressType.IPv6), timeout: _timeOut),
  ]);

  final List<AddressCheckOptions> _cloudFire1001 = List<AddressCheckOptions>.unmodifiable([
    AddressCheckOptions(InternetAddress('2606:4700:4700::1001', type: InternetAddressType.IPv6), timeout: _timeOut),
    AddressCheckOptions(InternetAddress('1.0.0.1', type: InternetAddressType.IPv4), timeout: _timeOut),
  ]);

  //OpenDNS
  final List<AddressCheckOptions> _openDNS222 = List<AddressCheckOptions>.unmodifiable([
    AddressCheckOptions(InternetAddress('208.67.222.222', type: InternetAddressType.IPv4), timeout: _timeOut),
    AddressCheckOptions(InternetAddress('2620:0:ccd::2', type: InternetAddressType.IPv6), timeout: _timeOut),
  ]);

  final List<AddressCheckOptions> _openDNS220 = List<AddressCheckOptions>.unmodifiable([
    AddressCheckOptions(InternetAddress('208.67.220.220', type: InternetAddressType.IPv4), timeout: _timeOut),
    AddressCheckOptions(InternetAddress('2620:0:ccc::2', type: InternetAddressType.IPv6), timeout: _timeOut),
  ]);

  List<AddressCheckOptions> _getCheckList(OpenDNS? dns) {
    switch (dns) {
      case OpenDNS.google8888:
        return _google8888;
      case OpenDNS.google8844:
        return _google8844;
      case OpenDNS.cloudFire1111:
        return _cloudFire1111;
      case OpenDNS.cloudFire1001:
        return _cloudFire1001;
      case OpenDNS.openDNS222:
        return _openDNS222;
      case OpenDNS.openDNS220:
        return _openDNS220;
      case null:
        return _google8888;
    }
  }

  Future<List<AddressCheckOptions>> getNextDnsList() async {
    if (_currentOpenDns == null) {
      return getCurrentDnsList();
    }
    if (_currentOpenDns == OpenDNS.values.last) {
      _currentOpenDns = OpenDNS.values.first;
    } else if (_currentOpenDns!.index < OpenDNS.values.length) {
      int newIndex = _currentOpenDns!.index;
      newIndex++;
      if (newIndex >= OpenDNS.values.length) {
        _currentOpenDns = OpenDNS.values.first;
      } else {
        try {
          _currentOpenDns = OpenDNS.values[newIndex];
        } on Exception catch (_) {
          _currentOpenDns = OpenDNS.google8888;
        }
      }
    } else {
      _currentOpenDns = OpenDNS.values.first;
    }
    return _getCheckList(_currentOpenDns);
  }

  Future<List<AddressCheckOptions>> getCurrentDnsList() async {
    return _getCheckList(_currentOpenDns);
  }
}

enum OpenDNS {
  google8888,
  cloudFire1111,
  openDNS222,
  google8844,
  cloudFire1001,
  openDNS220,
}
