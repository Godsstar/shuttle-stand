import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(children: <Widget>[
                      Image.asset(
                        'images/car.png',
                      ),
                      ListTile(
                        leading: Icon(Icons.check_circle_outlined),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'White Sienna',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        subtitle: Text('Online'),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('Estimate Time of Arrival:  12:00pm'))
                    ]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(children: <Widget>[
                      Image.asset(
                        'images/car.png',
                      ),
                      ListTile(
                        leading: Icon(Icons.check_circle_outlined),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'White Sienna',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        subtitle: Text('Online'),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('Estimate Time of Arrival:  12:00pm'))
                    ]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(children: <Widget>[
                      Image.asset(
                        'images/car.png',
                      ),
                      ListTile(
                        leading: Icon(Icons.check_circle_outlined),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'White Sienna',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        subtitle: Text('Online'),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('Estimate Time of Arrival:  12:00pm'))
                    ]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(children: <Widget>[
                      Image.asset(
                        'images/car.png',
                      ),
                      ListTile(
                        leading: Icon(Icons.check_circle_outlined),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'White Sienna',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        subtitle: Text('Online'),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('Estimate Time of Arrival:  12:00pm'))
                    ]),
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
