﻿import 'package:google_maps_flutter/google_maps_flutter.dart';

///Single item of blood donation points, used in address-screen => address_list. 
///Holds visible information about the point and its geo coordinates.
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
