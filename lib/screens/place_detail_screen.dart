import 'package:flutter/material.dart';
import 'package:fluttermax_map_native_features/models/place.dart';
import 'package:fluttermax_map_native_features/screens/maps_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceDetailScreen extends StatefulWidget {
  final Place place;
  const PlaceDetailScreen({Key? key, required this.place}) : super(key: key);

  @override
  _PlaceDetailScreenState createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.place.title)),
      body: Column(children: [
        SizedBox(
          height: 250,
          width: double.infinity,
          child: Image.file(
            widget.place.image,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          widget.place.location.address,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: ((context) => MapScreen(
                        initialLocation: widget.place.location,
                        mapType: MapType.satellite,
                      )),
                ),
              );
            },
            child: const Text('View on Map'))
      ]),
    );
  }
}
