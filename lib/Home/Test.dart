import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override

  Widget build(BuildContext context) {
    Location location = new Location();
    location.onLocationChanged.listen((LocationData currentLocation) {
      // Use current location
    });
    return GoogleMap(initialCameraPosition: CameraPosition(target: LatLng(0, 0)),);
  }
}
