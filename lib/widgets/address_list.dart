import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yadonor/models/address-item.dart';

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

final List addressList = [
  AddressItem(
    'Военно-медицинская академия им. С.М. Кирова, отделение переливания крови',
    '8-812-495-72-51',
    'пн-пт 09:00-13:00',
    'Загородный проспект, д. 47',
    LatLng(59.919825, 30.326015),
  ),
  AddressItem(
    'Всероссийский центр экстренной и радиационной медицины им. А.М. Никифорова МЧС России, Отделение трансфузиологии',
    '8-911-003-40-74',
    'пн-чт 09:00-12:00',
    'ул. Оптиков д. 54',
    LatLng(60.001133, 30.198207),
  ),
  AddressItem(
    'ГКУЗ "Центр крови Ленинградской области", филиал №1',
    ' 8-812-511-09-18',
    'пн-пт 08:30-16:30',
    'пр. Луначарского, д.45, корп 2',
    LatLng(60.035148, 30.359273),
  ),
  AddressItem(
    'Городской клинический онкологический диспансер, отделение переливания крови',
    ' 8-812-607-06-71',
    'пн 15:30-18:00 (по предварительной записи); вт-чт 09:00-11:00',
    'пр-т Ветеранов, д. 56',
    LatLng(59.839158, 30.238855),
  ),
  AddressItem(
    'Отделение переливания крови Первого Санкт-Петербургского государственного медицинского университета им. акад. И.П.Павлова',
    '8-812-429-24-13 с 13.00 до 15.00',
    'пн-пт 8.30 - 12.00',
    'ул. Льва Толстого, д. 19, корпус 53',
    LatLng(59.964796, 30.321092),
  ),
  AddressItem(
    'Отделение переливания крови ФГБУ "НМИЦ онкологии им. Н.Н. Петрова" Минздрава России',
    '8-812-439-95-17',
    'пн-пт 09:30-12:30',
    'ул. Ленинградская д. 68',
    LatLng(60.119312, 30.179806),
  ),
  AddressItem(
    'ФГБУ "Российский научно-исследовательский институт гематологии и трансфузиологии Федерального медико-биологического агентства", отделение переливания крови',
    '8-812-274-57-21',
    'пн-чт 8.30-11.30',
    'ул. 2-я Советская, д.16',
    LatLng(59.930807, 30.371955),
  ),
  AddressItem(
    'Санкт-Петербургская Детская городская клиническая больница № 5 им. Н.Ф. Филатова, отделение переливания крови',
    '8-812-366-71-66',
    'пн-пт 9:00-12:00. Прием догоров крови по записи, при себе иметь паспорт и полис',
    'ул. Бухарестская, д. 134',
    LatLng(59.838297, 30.416197),
  ),
];
