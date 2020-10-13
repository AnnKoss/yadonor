import 'package:flutter/material.dart';

import 'package:yadonor/widgets/main_drawer.dart';

class CalendarAddScreen extends StatefulWidget {
  static const routeName = '/calendar-add';

  @override
  _CalendarAddScreenState createState() => _CalendarAddScreenState();
}

class _CalendarAddScreenState extends State<CalendarAddScreen> {
  String dropDownValue = 'Донорство цельной крови';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ПЛАНИРОВАНИЕ ДОНАЦИИ',
          style: Theme.of(context).textTheme.title,
        ),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            elevation: 2,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                elevation: 2,
                value: dropDownValue,
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValue = newValue;
                  });
                },
                items: <String>[
                  'Донорство цельной крови',
                  'Донорство тромбоцитов',
                  'Донорство лейкоцитов',
                  'Донорство плазмы',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Row(
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/images/blood_drop.png'),
                            height: 25,
                            color: Theme.of(context).accentColor,
                          ),
                          SizedBox(width: 10),
                          Text(value),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                // style: TextStyle(decoration: TextDecoration.none),
                // [
                //   // DropdownMenuItem(child: Text('Донорство цельной крови')),
                //   DropdownMenuItem(child: Text('Донорство тромбоцитов')),
                //   DropdownMenuItem(child: Text('Донорство лейкоцитов')),
                //   DropdownMenuItem(child: Text('Донорство плазмы')),
                // ],
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
