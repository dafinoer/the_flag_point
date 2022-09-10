import 'package:shared_preferences/shared_preferences.dart';

class SharePrefProvider {
  final SharedPreferences sharedPreferences;

  SharePrefProvider(this.sharedPreferences);

  static late final SharePrefProvider instance;

  static Future<void> initialSharedPreferences() async {
    final result = await SharedPreferences.getInstance();
    instance = SharePrefProvider(result);
    return;
  }
}
