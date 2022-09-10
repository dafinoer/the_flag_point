import 'package:flag_point_repository_local_storage/flag_point_repository_local_storage.dart';
import 'package:flutter/material.dart';

import 'the_flag_point_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharePrefProvider.initialSharedPreferences();
  await FloorAppDatabase.create();
  runApp(const TheFlagPointApp());
}
