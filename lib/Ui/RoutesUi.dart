import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Card(
                  color: Color(0x9FE4E4E4),
                  // Welcome to your dashboard
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Row(children: <Widget>[
                      Expanded(
                        child: Column(
                          children: [
                            // Welcome to your dashboard text
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Text(
                                'Welcome to your Dashboard',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // Mr star text
                            Row(
                              children: [
                                Text(
                                  'Mr Star',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      // Icon on dashboard
                      Column(
                        children: [
                          Image.asset(
                            'images/user.png',
                            height: 100,
                            width: 100,
                          )
                        ],
                      ),
                    ]),
                  ),
                ),
              ),
              // Drop down to pick a vehicle
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: DropdownButton<String>(
                  hint: Text('Pick a vehicle for Today'),
                  items: <String>[
                    'White Sienna',
                    'White Sienna',
                    'White Sienna',
                    'White Sienna'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
              ),
              // Online/ offline toggle
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        /*1*/
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /*2*/
                            Container(
                              padding: const EdgeInsets.only(bottom: 0),
                              child: Text(
                                'Online / Offline',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      /*3*/
                      Icon(
                        Icons.toggle_on_outlined,
                        color: Colors.red[500],
                        size: 35,
                      ),
                    ],
                  ),
                ),
              ),
              // Full / Empty toggle
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        /*1*/
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /*2*/
                            Container(
                              padding: const EdgeInsets.only(bottom: 0),
                              child: Text(
                                'Full / Empty',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      /*3*/
                      Icon(
                        Icons.toggle_on_outlined,
                        color: Colors.red[500],
                        size: 35,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
