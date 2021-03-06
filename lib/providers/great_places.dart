import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttermax_map_native_features/helpers/db_helper.dart';
import 'package:fluttermax_map_native_features/helpers/location_helper.dart';

import '../models/place.dart';

class Places with ChangeNotifier {
  List<Place> _items = [];
  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation placeLocation) async {
    final address = await LocationHelper.getPlaceAddress(
        placeLocation.lattitude, placeLocation.longitude);
    final locationWithAddress = PlaceLocation(
        lattitude: placeLocation.lattitude,
        longitude: placeLocation.longitude,
        address: address);
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        location: locationWithAddress,
        image: image);
    _items.add(newPlace);
    DBHelper.insert(
      'places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        'loc_lat': newPlace.location.lattitude,
        'loc_lng': newPlace.location.longitude,
        'address': newPlace.location.address,
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
            location: PlaceLocation(
                lattitude: e['loc_lat'] as double,
                longitude: e['loc_lng'] as double,
                address: e['address'] as String),
            image: File(e['image'] as String)))
        .toList();
    print('fetched ' + _items.length.toString() + ' places');
    notifyListeners();
  }
}
