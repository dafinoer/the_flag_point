import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:the_flag_point/presentations/pin_location/pin_location_cubit.dart';

class PinPointPage extends StatefulWidget {
  const PinPointPage({Key? key}) : super(key: key);

  @override
  State<PinPointPage> createState() => _PinPointPageState();
}

class _PinPointPageState extends State<PinPointPage> {
  late final MarkerPositionController _markerPositionController;
  late final PinLocationCubit pinLocationCubit;

  @override
  void initState() {
    super.initState();
    _markerPositionController = MarkerPositionController(null);
    pinLocationCubit = PinLocationCubit.create(context);
  }

  @override
  void dispose() {
    _markerPositionController.dispose();
    pinLocationCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<PinLocationCubit, PinLocationState>(
        bloc: pinLocationCubit,
        listener: (context, state) {
          if (state is PinLocationSave) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Success Save Pin Location')));
          }
        },
        child: SlidingUpPanel(
          body: FlutterMap(
            options: MapOptions(
              center: LatLng(-6.249976286148754, 106.5872572137163),
              zoom: 9,
              maxZoom: 18,
              minZoom: 3,
              onTap: (tapPosition, point) =>
                  _markerPositionController.onChangePosition(point),
            ),
            children: [
              TileLayerWidget(
                  options: TileLayerOptions(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.iceman.flagpoint.the_flag_point',
              )),
              ValueListenableBuilder<LatLng?>(
                valueListenable: _markerPositionController,
                builder: (context, value, child) {
                  final resultLatLng = value;
                  if (resultLatLng != null) {
                    return MarkerLayerWidget(
                        options: MarkerLayerOptions(markers: [
                      Marker(
                        width: 20,
                        height: 20,
                        point: resultLatLng,
                        builder: (context) =>
                            const Icon(Icons.location_on, color: Colors.red),
                      )
                    ]));
                  }
                  return const SizedBox.shrink();
                },
              )
            ],
          ),
          panel: Column(
            children: [
              Text('Pin Point Location', style: theme.textTheme.headline4),
              ElevatedButton(
                onPressed: () {
                  final value = _markerPositionController.value;
                  if (value != null) pinLocationCubit.onSetPinLocation(value);
                },
                child: const Text('Submit Location'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MarkerPositionController extends ValueNotifier<LatLng?> {
  MarkerPositionController(super.value);

  void onChangePosition(LatLng latLng) {
    value = latLng;
  }
}
