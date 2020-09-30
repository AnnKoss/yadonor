import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressItem {
  final String title;
  final String contacts;
  final String openingHours;
  final String address;
  final LatLng coordinates;

  AddressItem(
    this.title,
    this.contacts,
    this.openingHours,
    this.address,
    this.coordinates,
  );
}
