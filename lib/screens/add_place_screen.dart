import 'package:flutter/material.dart';
import 'package:fluttermax_map_native_features/widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/addPlaceScreen';
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _textEditingController = TextEditingController();
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
                          controller: _textEditingController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(),
                        const ImageInput()
                      ],
                    )))),
        ElevatedButton.icon(
          onPressed: () {},
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
