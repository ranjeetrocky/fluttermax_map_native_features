import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pathProvider;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  const ImageInput({Key? key, required this.onSelectImage}) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  Future<void> _takePicture() async {
    try {
      final imageFile = await ImagePicker()
          .pickImage(source: ImageSource.camera, maxWidth: 600);
      setState(() {
        _storedImage = File(imageFile!.path);
      });
      final appDir = await pathProvider.getExternalStorageDirectory();
      var fileName = path.basename(_storedImage!.path);
      fileName = DateTime.now().toString() + "." + fileName.split(".").last;
      // appDir?.forEach((element) {
      //   return print(element.path);
      // });
      print('${appDir!.path}/$fileName');
      // final savedFile = await _storedImage!.copy(
      //     '/storage/emulated/0/Android/media/com.cheemsinfotech.fluttermax_map_native_features/$fileName');
      final savedFile = await _storedImage!.copy('${appDir.path}/$fileName');
      print('Saved in ${savedFile.path}');
      widget.onSelectImage(savedFile);
    } catch (e) {
      print('Exception : ' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 100,
          child: _storedImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.file(
                    _storedImage!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                )
              : const Center(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'No image taken',
                        textAlign: TextAlign.center,
                      )),
                ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(15)),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: TextButton.icon(
            label: const Text('Take Picture'),
            icon: const Icon(Icons.camera_alt_rounded),
            onPressed: _takePicture,
          ),
        )
      ],
    );
  }
}
