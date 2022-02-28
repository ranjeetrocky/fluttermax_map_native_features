import 'package:flutter/cupertino.dart';

import '../models/place.dart';

class Places with ChangeNotifier {
  final List<Place> _items = [];
  List<Place> get items {
    return [..._items];
  }
}
