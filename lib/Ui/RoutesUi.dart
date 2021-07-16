import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'BusStopShuttles.dart';
import '../repo/constants.dart';


class RoutesUi extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('BUS STOPS', style: TextStyle(fontSize: 25.0),),
        SizedBox(height: 20.0,),
        Expanded(
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: kStandsBloc.BusStops.keys.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BusStopShuttles(stopName: kStandsBloc.BusStops.keys.elementAt(index),))),
                  
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(Icons.location_on_outlined),
                          SizedBox(width: 10.0,),
                          Text(kStandsBloc.BusStops.keys.elementAt(index).toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
                        ],
                      ),
                    ),
                  ),
                );
              }
          ),
        ),
      ],
    );
  }
}

