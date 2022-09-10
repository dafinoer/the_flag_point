import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_flag_point/presentations/attendance/attendance_cubit.dart';
import 'package:the_flag_point/presentations/location/location_cubit.dart';

import '../../components/constanta.dart';
import 'attendance_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final LocationCubit _locationCubit;
  late final AttendanceCubit _attendanceCubit;

  @override
  void initState() {
    super.initState();
    _locationCubit = LocationCubit.create(context);
    _attendanceCubit = AttendanceCubit.create(context);
    _locationCubit.checkPermission();
    _attendanceCubit.onListenListAttendances();
  }

  @override
  void dispose() {
    _locationCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/create_pin_point');
              },
              icon: const Icon(Icons.map))
        ],
      ),
      body: MultiBlocListener(
          listeners: [
            BlocListener(
              bloc: _locationCubit,
              listener: (context, state) {
                if (state is LocationPermissionDenied) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please Activate Location Permission')));
                }
              },
            )
          ],
          child: BlocBuilder<AttendanceCubit, AttendanceState>(
            bloc: _attendanceCubit,
            builder: (context, state) {
              if (state is EmptyAttendances) {
                return const Center(
                  child: Text('Attendences Empty'),
                );
              } else if (state is AttendanceList) {
                return ListView.builder(
                  itemCount: state.attendances.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(state.attendances[index].id ?? 'No Id'),
                    subtitle: Text(
                        'Check in : ${DateTime.fromMillisecondsSinceEpoch(state.attendances[index].createdAt)}'),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          )),
      floatingActionButton: FloatingActionButton(
        tooltip: TheFlagPointConstanta.attendanceWord,
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const AttendanceDialog(),
          );
        },
      ),
    );
  }
}
