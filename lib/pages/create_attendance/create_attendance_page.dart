import 'package:flutter/material.dart';
import 'package:the_flag_point/components/constanta.dart';

class CreateAttendancePage extends StatefulWidget {
  const CreateAttendancePage({Key? key}) : super(key: key);

  @override
  State<CreateAttendancePage> createState() => _CreateAttendancePageState();
}

class _CreateAttendancePageState extends State<CreateAttendancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text(TheFlagPointConstanta.createAttendanceWord)),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }
}
