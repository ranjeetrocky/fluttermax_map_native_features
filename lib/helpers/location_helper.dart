const GOOGLE_API_KEY = 'AIzaSyBTNMsKa_LKWQs8wYcxXF5a0RgGsaGC0eA';

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
}