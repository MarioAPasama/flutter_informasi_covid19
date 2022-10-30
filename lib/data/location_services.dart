part of 'data.dart';

class LocationServices {
  Future<String> getCoordinate() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var address = addresses.first;
    return address.adminArea.toString();
  }
}
