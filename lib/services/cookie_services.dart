import 'package:shared_preferences/shared_preferences.dart';

// Saving cookie
saveCookie({String? key, String? value}) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  await sharedPreferences.setString(key!, value.toString());
}

// Retriving cookie
Future<String?> getCookie({String? key}) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final value = sharedPreferences.getString(key!);
  return value;
}

/// Deleting cookie
deleteCookie({String? key}) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  await sharedPreferences.remove(key!);
}
