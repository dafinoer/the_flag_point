import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_flag_point/components/constanta.dart';

import '../../presentations/attendance/attendance_cubit.dart';
import '../../presentations/location/location_cubit.dart';

part 'button_attendance.dart';

class AttendanceDialog extends StatefulWidget {
  const AttendanceDialog({Key? key}) : super(key: key);

  @override
  State<AttendanceDialog> createState() => _AttendanceDialogState();
}

class _AttendanceDialogState extends State<AttendanceDialog> {
  late final LocationCubit _locationCubit;
  late final AttendanceCubit _attendanceCubit;

  @override
  void initState() {
    super.initState();
    _locationCubit = LocationCubit.create(context);
    _locationCubit.getLocation();
    _attendanceCubit = AttendanceCubit.create(context);
  }

  @override
  void dispose() {
    _locationCubit.close();
    _attendanceCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _attendanceCubit),
        BlocProvider.value(value: _locationCubit)
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<LocationCubit, LocationState>(
            bloc: _locationCubit,
            listener: (context, state) {
              if (state is LocationError) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
              return;
            },
          )
        ],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(TheFlagPointConstanta.createAttendanceWord,
                  style: theme.textTheme.headline5),
            ),
            BlocBuilder(
              bloc: _locationCubit,
              buildWhen: (previous, current) {
                return current is LocationError ? false : true;
              },
              builder: (context, state) {
                if (state is LocationLoading) {
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(children: const [
                      Text('Waiting get your Location'),
                      Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                      CircularProgressIndicator(),
                    ]),
                  ));
                }
                if (state is LocationPosition) return const ButtonAttendance();
                return const SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }
}
