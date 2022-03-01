import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../models/place.dart';

class Places with ChangeNotifier {
  final List<Place> _items = [];
  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        location:
            PlaceLocation(lattitude: 22.0, longitude: 22.00, address: 'surat'),
        image: image);
    _items.add(newPlace);
    notifyListeners();
  }
}
