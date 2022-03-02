import 'package:flutter/material.dart';
import 'package:fluttermax_map_native_features/helpers/location_helper.dart';
import 'package:fluttermax_map_native_features/screens/maps_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final void Function({required double lat, required double lng})
      selectLocation;
  const LocationInput({Key? key, required this.selectLocation})
      : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  Future<void> _selectOnMap() async {
    print('opening Google map');
    final LatLng? selectedLocation =
        await Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => const MapScreen(
                  isSelecting: true,
                )));
    if (selectedLocation == null) {
      return;
    }

    print(selectedLocation.latitude);
    print(selectedLocation.longitude);

    _showPreview(
      selectedLocation.latitude,
      selectedLocation.longitude,
    );

    widget.selectLocation(
      lat: selectedLocation.latitude,
      lng: selectedLocation.longitude,
    );
  }

  void _showPreview(double lat, double lng) {
    print("Lattitude : $lat\nLongitude : $lng");

    final previewUrl = LocationHelper.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );
    setState(() {
      _previewImgUrl = previewUrl;
      print('Reloading Location Image');
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      final location = await Location().getLocation();
      _showPreview(location.latitude!, location.longitude!);
      widget.selectLocation(lat: location.latitude!, lng: location.longitude!);
    } catch (e) {
      print(e);
      return;
    }
  }

  String? _previewImgUrl;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          child: _previewImgUrl == null
              ? const Text(
                  'Choose Location',
                )
              : Image.network(
                  _previewImgUrl!,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, imageChunkEvent) {
                    return imageChunkEvent == null
                        ? child
                        : Center(
                            child: CircularProgressIndicator.adaptive(
                              strokeWidth: 1,
                              semanticsLabel: "Loading",
                              value: imageChunkEvent.expectedTotalBytes == null
                                  ? null
                                  : imageChunkEvent.cumulativeBytesLoaded /
                                      imageChunkEvent.expectedTotalBytes!,
                            ),
                          );
                  },
                ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
                onPressed: _getCurrentLocation,
                icon: const Icon(Icons.location_on),
                label: const Text('Current Location')),
            TextButton.icon(
                onPressed: _selectOnMap,
                icon: const Icon(Icons.map_rounded),
                label: const Text('Select on Map')),
          ],
        )
      ],
    );
  }
}
