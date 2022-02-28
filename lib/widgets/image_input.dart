import 'dart:io';

import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key}) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 100,
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
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
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
