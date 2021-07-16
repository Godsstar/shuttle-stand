import 'package:shuttle_tracker/blocs/CredsBloc/CredsBloc.dart';
import 'package:shuttle_tracker/repo/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/CredsBloc/LoginEvent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../repo/constants.dart';



class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      bloc: kLoginBloc,
      builder: (context, state) {
        if (state is SignedInPage) {
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
                                        (kLoginBloc.driver?.hasShuttle == true)
                                            ? kLoginBloc.driver!.shuttle!.name
                                            : 'Select Vehicle' ,
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
                    (state.LockShuttle == true)
                        ? Container(width: 0.0, height: 0.0,)
                        : Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: DropdownButton<String>(
                        hint: Text('Select Vehicle'),
                        value: kLoginBloc.selectedShuttle,
                        onChanged: (vehicle) => setState(() => kLoginBloc.add(chooseVehicle(vehicle)) ),
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
                                    padding: EdgeInsets.only(bottom: 0),
                                    child: Text(
                                      'OFFLINE / ONLINE',
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
                                value: kLoginBloc.toggleState,
                                onChanged: (newVal) => (kLoginBloc.selectedShuttle != 'Select Vehicle')
                                  ? setState( () => kLoginBloc.add(ToggleOnlineStatus(status: newVal)) )
                                  : ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: kBaseColor,content: Text('select a vehicle'),),),
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
