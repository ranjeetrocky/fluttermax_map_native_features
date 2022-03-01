import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttermax_map_native_features/providers/great_places.dart';
import 'package:fluttermax_map_native_features/widgets/image_input.dart';
import 'package:fluttermax_map_native_features/widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/addPlaceScreen';
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<Places>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!);
    Navigator.of(context).pop({'message': 'from Add Place Screen'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Place'),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextField(
                          decoration:
                              const InputDecoration(label: Text("Title")),
                          controller: _titleController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ImageInput(
                          onSelectImage: _selectImage,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const LocationInput(),
                      ],
                    )))),
        ElevatedButton.icon(
          onPressed: _savePlace,
          label: const Text('Add Place'),
          icon: const Icon(Icons.add),
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.tertiary)),
        )
      ]),
    );
  }
}
