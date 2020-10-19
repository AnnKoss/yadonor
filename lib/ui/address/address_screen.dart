import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:yadonor/ui/main_drawer.dart';
import 'package:yadonor/ui/address/address_listView.dart';

class AddressScreen extends StatefulWidget {
  static const routeName = '/adress';

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(59.9311, 30.3609);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'АДРЕСА ОТДЕЛЕНИЙ ПЕРЕЛИВАНИЯ КРОВИ',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              // markers: Set<Marker>.of(markers),
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 10.0,
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: AddressList(),
          ),
        ],
      ),
    );
  }
}
