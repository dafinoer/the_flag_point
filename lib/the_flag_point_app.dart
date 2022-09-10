import 'package:domain_repository/model/location.dart';
import 'package:flag_point_repository_local_storage/flag_point_repository_local_storage.dart';
import 'package:flag_point_services/flag_point_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_flag_point/components/routes.dart';

class TheFlagPointApp extends StatelessWidget {
  const TheFlagPointApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FloorMainAppDatabase>(
            create: (context) => FloorMainAppDatabase.instance),
        RepositoryProvider<SharedPreferences>(
            create: (context) => SharePrefProvider.instance.sharedPreferences),
        RepositoryProvider<FloorMainAppDatabase>(
            create: (context) => FloorMainAppDatabase.instance),
        RepositoryProvider<LocationDeviceService>(
            create: (context) => LocationDeviceService()),
        RepositoryProvider<AttendanceRepositoryLocalStorage>(
            create: (context) => AttendanceRepositoryLocalStorage(
                FloorMainAppDatabase.instance.attendanceDao)),
        RepositoryProvider<LocalStorageRepository<Location>>(
          create: (context) => PinPointRepositoryLocalStorage(
              SharePrefProvider.instance.sharedPreferences),
        )
      ],
      child: MaterialApp(
        title: 'The Flag Point App',
        theme: ThemeData.light(),
        routes: routes(),
      ),
    );
  }
}
