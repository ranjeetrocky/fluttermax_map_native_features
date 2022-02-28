import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttermax_map_native_features/providers/great_places.dart';
import 'package:fluttermax_map_native_features/screens/add_place_screen.dart';
import 'package:fluttermax_map_native_features/screens/place_list_screen.dart';
import 'package:provider/provider.dart';

const themeSeedColors = [
  Colors.purple,
  Colors.blue,
  Colors.lightBlue,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.red
];
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Places(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          colorSchemeSeed:
              themeSeedColors[Random().nextInt(themeSeedColors.length)],
        ),
        debugShowCheckedModeBanner: false,
        home: const PlaceListScreen(),
        routes: {
          AddPlaceScreen.routeName: (context) => const AddPlaceScreen(),
        },
      ),
    );
  }
}
