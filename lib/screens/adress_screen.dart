import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../widgets/main_drawer.dart';
import '../widgets/address_list.dart';

class AdressScreen extends StatefulWidget {
  static const routeName = '/adress';

  @override
  _AdressScreenState createState() => _AdressScreenState();
}

class _AdressScreenState extends State<AdressScreen> {
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
          style: Theme.of(context).textTheme.title,
        ),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              markers: Set<Marker>.of(markers),
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
