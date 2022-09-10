import 'package:flutter/material.dart';
import 'package:the_flag_point/pages/create_attendance/create_attendance_page.dart';

import '../pages/home/home_page.dart';
import '../pages/pin_point_location/pin_point_page.dart';

Map<String, WidgetBuilder> routes() {
  return {
    '/': (_) => const HomePage(),
    '/create-attendance': (_) => const CreateAttendancePage(),
    '/create_pin_point': (context) => const PinPointPage(),
  };
}
