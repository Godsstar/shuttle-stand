import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shuttle_tracker/blocs/AdminBloc/AdminBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../repo/constants.dart';
import '../AddShuttle.dart';
import '../AddDriver.dart';

Color themeColor = Color(0xFFCA3535);
class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}



class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminBloc, AdminPageState>(
        bloc: adminBloc,
        builder: (context, state) {
          if (state is DashBoardPage) {
            return Container(
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                        padding: EdgeInsets.all(30.0),
                        width: double.infinity,
                        color: themeColor,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Welcome,\nAdmin',
                                    style: TextStyle(
                                        color: themeColor,
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Image.asset(
                                    'images/user.png',
                                    scale: 1.5,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () => print('New Driver'),
                                    child: Text('Logout'),
                                    style: ElevatedButton.styleFrom(
                                      primary: themeColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () => adminBloc.add(AddNewDriver()),
                                    child: Text(
                                      'Add Driver',
                                      style: TextStyle(
                                          color: themeColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () => adminBloc.add(AddNewShuttle()),
                                    child: Text(
                                      'Add Shuttle',
                                      style: TextStyle(
                                          color: themeColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      color: Color(0xFFEDF1F9),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () => setState(() =>  adminBloc.add(GetDrivers())),
                                child: Text('Drivers'),
                                style: (adminBloc.driversToggle == true)
                                    ? adminBloc.ONLINE_STYLE
                                    : adminBloc.OFFLINE_STYLE,
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              ElevatedButton(
                                onPressed: () => setState(() => adminBloc.add(GetShuttles())),
                                child: Text('Shuttles'),
                                style: (adminBloc.driversToggle == false)
                                    ? adminBloc.ONLINE_STYLE
                                    : adminBloc.OFFLINE_STYLE,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),

                          (state.Loading == true) ?
                                Expanded(
                                  child: Container(
                                   child: SpinKitDoubleBounce(color: themeColor,),
                                  ),
                                )
                              : (adminBloc.driversToggle == true)

                              ? Expanded(
                                child: ListView.builder(
                                  itemCount: adminBloc.driversList.length,
                                  itemBuilder: (context, index) {
                                    print(index);
                                    return Card(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Text(adminBloc
                                                .driversList[index].name
                                                .toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold),),
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.cancel_outlined,
                                              color: themeColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                ),
                              )
                              : Expanded(
                                child: ListView.builder(
                                itemCount: adminBloc.shuttlesList.length,
                                itemBuilder: (context, index) {
                                  print(index);
                                  return Card(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Text(adminBloc
                                              .shuttlesList[index].name
                                              .toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold),),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.cancel_outlined,
                                            color: themeColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }
                          ),
                              )

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          else if (state is AddDriverPage) return NewDriver();
          else if (state is AddShuttlePage) return NewShuttle();

          return Container();
        });  }
}
