import 'dart:convert';

import 'package:http/http.dart';

const GOOGLE_API_KEY = 'AIzaSyAQKcSHxr9TTfZYrKBDsaKbcQTi4CBOmb4';

enum MapType {
  sattelite,
}

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longitude}) {
    String url =
        'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=17&size=600x300&maptype=satellite&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
    print(url);
    return url;
  }

  static Future<String> getPlaceAddress(double lat, double long) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$GOOGLE_API_KEY';
    print(url);
    final response = await get(Uri.parse(url));
    final result = jsonDecode(response.body);
    print(result);
    return result['results'][0]['formatted_address'];
  }
}
