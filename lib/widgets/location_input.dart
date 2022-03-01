import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
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
                onPressed: () {},
                icon: const Icon(Icons.location_on),
                label: const Text('Current Location')),
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.map_rounded),
                label: const Text('Select on Map')),
          ],
        )
      ],
    );
  }
}
