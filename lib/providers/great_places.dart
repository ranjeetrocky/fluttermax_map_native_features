import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttermax_map_native_features/helpers/db_helper.dart';

import '../models/place.dart';

class Places with ChangeNotifier {
  List<Place> _items = [];
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
    DBHelper.insert(
      'places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path
      },
    );
    notifyListeners();
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('places');
    _items = dataList
        .map((e) => Place(
            id: e['id'] as String,
            title: e['title'] as String,
            location: null,
            image: File(e['image'] as String)))
        .toList();
    print('fetched ' + _items.length.toString() + ' places');
    notifyListeners();
  }
}
