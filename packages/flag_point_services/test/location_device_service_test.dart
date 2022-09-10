import 'dart:io';

import 'package:flag_point_services/location_device_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class GeoLocatorPlatformMock extends Mock
    with MockPlatformInterfaceMixin
    implements GeolocatorPlatform {}

void main() {
  group('Location Device Service Test', () {
    late GeoLocatorPlatformMock geoLocatorPlatformMock;
    late LocationDeviceService locationDeviceService;

    setUpAll(() {
      geoLocatorPlatformMock = GeoLocatorPlatformMock();
      locationDeviceService = LocationDeviceService();
      GeolocatorPlatform.instance = geoLocatorPlatformMock;
    });

    test('Permission Location Test', () async {
      when(() => geoLocatorPlatformMock.checkPermission())
          .thenAnswer((invocation) async => LocationPermission.always);
      await locationDeviceService.permissionAccessLocation();
      expect(locationDeviceService.locationEnable, true);
    });

    test('Between Distance Test', () {
      when(() => geoLocatorPlatformMock.distanceBetween(
          any(), any(), any(), any())).thenReturn(2.0);
      final result = locationDeviceService.betweenDistance(
        startLat: 0.0,
        startLon: 0.0,
        endLat: 0.0,
        endLon: 0.0,
      );
      expect(result, 2.0);
    });
  });
}
