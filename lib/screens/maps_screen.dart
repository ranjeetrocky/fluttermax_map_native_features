import "package:flutter/material.dart";
import 'package:fluttermax_map_native_features/models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;
  const MapScreen({
    Key? key,
    this.initialLocation = const PlaceLocation(
        lattitude: 28.6926341, longitude: 76.9512634, address: 'Delhi'),
    this.isSelecting = false,
  }) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Location')),
      body: GoogleMap(
        mapType: MapType.normal,
        buildingsEnabled: true,
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.lattitude,
            widget.initialLocation.longitude,
          ),
          zoom: 17,
        ),
      ),
    );
  }
}
