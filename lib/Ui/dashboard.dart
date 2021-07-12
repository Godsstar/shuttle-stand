import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shuttle_tracker/blocs/CredsBloc/CredsBloc.dart';
import 'package:shuttle_tracker/repo/constants.dart';
import '../blocs/CredsBloc/LoginEvent.dart';
import '../repo/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Dashboard extends StatefulWidget {

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool onlineToggle = false;
  bool temp = false;
  int count = 0;
  String Selectedshuttle = 'Select Vehicle';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      bloc: kLoginBloc,
      builder: (context, state) {
        if (state is SignedInPage) {
          count += 1;
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                child: Column(
                  children: [
                    Text('Counter: $count'),
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
                                      'Welcome, ${kLoginBloc.driver?.username}',
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
                                        (kLoginBloc.driver!.hasShuttle == true) ? kLoginBloc.driver!.shuttle!.name : 'Select Vehicle' ,
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
                        hint: Text('Select Vehicle'),
                        value: Selectedshuttle,
                        onChanged: (vehicle) => setState(()=> Selectedshuttle = vehicle ?? ''),
                        items: [
                          'Select Vehicle',
                          'White Sienna',
                          'Brown Sienna',
                          'Green Sienna',
                          'Costa Bus',
                          'Grey Toyota',
                          'Blue Toyota',
                        ].map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
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
                            Switch(
                                activeColor: Colors.red,
                                value: onlineToggle,
                                onChanged: (newVal) => (Selectedshuttle != 'Select Vehicle')
                                    ? {
                                      onlineToggle = newVal,
                                      setState(()=>
                                        kLoginBloc.add(SignedIn(email: kAuth.currentUser!.email ?? '' ,
                                        ToggleOnlineStatus: newVal,
                                        selectedVehicle: Selectedshuttle),)
                                        )
                                      }

                                    : ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: kBaseColor,content: Text('select a vehicle'),)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Full / Empty toggle

                    SizedBox(height: 10.0,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      onPressed: () => kLoginBloc.add(SignOut()),
                      child: Text('Logout'),
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return Container();
      }
    );
  }
}
