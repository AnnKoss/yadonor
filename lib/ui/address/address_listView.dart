import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:yadonor/model/dictionaries/address_list.dart';


List<Marker> markers = [];

class AddressList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: addressList.length,
      itemBuilder: (context, i) {
        // markers.add(
        //   Marker(
        //     markerId: MarkerId(
        //       addressList[i].coordinates.toString(),
        //     ),
        //     position: addressList[i].coordinates,
        //     infoWindow: InfoWindow(
        //       title: addressList[i].title,
        //       snippet: addressList[i].openingHours,
        //     ),
        //   ),
        // );
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              title: Text(addressList[i].title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(addressList[i].contacts),
                  Text(addressList[i].openingHours),
                  Text(
                    addressList[i].address,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}