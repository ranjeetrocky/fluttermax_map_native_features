import 'package:flutter/material.dart';
import 'package:fluttermax_map_native_features/providers/great_places.dart';
import 'package:fluttermax_map_native_features/screens/add_place_screen.dart';
import 'package:fluttermax_map_native_features/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

class PlaceListScreen extends StatelessWidget {
  const PlaceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AddPlaceScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Places>(context, listen: false).fetchAndSetPlaces(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Consumer<Places>(
                  builder: (context, places, child) {
                    return places.items.isEmpty
                        ? child!
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(places.items[index].image),
                                ),
                                title: Text(places.items[index].title),
                                subtitle:
                                    Text(places.items[index].location.address),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => PlaceDetailScreen(
                                          place: places.items[index])));
                                },
                              );
                            },
                            itemCount: places.items.length,
                          );
                  },
                  child: const Center(
                    child: Text('Got no places yet, add some!'),
                  ),
                );
        },
      ),
    );
  }
}
