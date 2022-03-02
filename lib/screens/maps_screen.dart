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
  LatLng? _pickedPosition;

  void _selectPlace(LatLng location) {
    setState(() {
      _pickedPosition = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
                onPressed: _pickedPosition != null
                    ? () {
                        Navigator.of(context).pop(_pickedPosition);
                      }
                    : null,
                icon: const Icon(Icons.check_rounded))
        ],
      ),
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
        onTap: widget.isSelecting ? _selectPlace : null,
        markers: _pickedPosition == null
            ? {}
            : {
                Marker(
                    markerId: const MarkerId('m1'), position: _pickedPosition!)
              },
      ),
    );
  }
}
