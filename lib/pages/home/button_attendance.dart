part of 'attendance_dialog.dart';

class ButtonAttendance extends StatelessWidget {
  const ButtonAttendance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: BlocBuilder<AttendanceCubit, AttendanceState>(
          builder: (context, state) {
            if (state is AttendanceLoading) {
              return const ElevatedButton(
                  onPressed: null,
                  child: Text(TheFlagPointConstanta.submitAttendanceWord));
            }
            return ElevatedButton(
              onPressed: () {
                final location = context.read<LocationCubit>().locationDevice;
                if (location != null) {
                  context.read<AttendanceCubit>().userAttendance(location);
                }
              },
              child: const Text(TheFlagPointConstanta.submitAttendanceWord),
            );
          },
        ));
  }
}
