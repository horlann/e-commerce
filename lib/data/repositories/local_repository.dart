import 'package:shared_preferences/shared_preferences.dart';

class LocalRepository {
  late final SharedPreferences prefs;

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  String get cachedAccountName => prefs.getString("account_cache_name") ?? "";
  String get cachedAccountPhone => prefs.getString("account_cache_phone") ?? "";
  String get cachedAccountAddress => prefs.getString("account_cache_address") ?? "";

  set setCachedAccountName(String value) => prefs.setString("account_cache_name", value);
  set setCachedAccountPhone(String value) => prefs.setString("account_cache_phone", value);
  set setCachedAccountAddress(String value) => prefs.setString("account_cache_address", value);
}
