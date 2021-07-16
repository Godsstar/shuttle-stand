import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shuttle_tracker/blocs/CredsBloc/CredsBloc.dart';
import '../../repo/constants.dart';
import '../../repo/models.dart';
import 'package:bloc/bloc.dart';
import 'AdminEvent.dart';
import 'AdminState.dart';

export 'AdminState.dart';
export 'AdminEvent.dart';


class AdminBloc extends Bloc<AdminEvent, AdminPageState> {
  final ButtonStyle ONLINE_STYLE = ElevatedButton.styleFrom(primary: Color(0xFFCA3535));
  final ButtonStyle OFFLINE_STYLE = ElevatedButton.styleFrom(primary: Colors.white, onPrimary: Colors.black);

  bool _bDrivers = true, _bShuttles = false;

  String active = 'shuttles';

  FirebaseAuth tempAuth = FirebaseAuth.instance;



  List<Driver> _driversList = [];
  List<Shuttle> _shuttlesList = [];

  AdminBloc(): super(DashBoardPage(Loading: true)) {
    _bDrivers = true;

    this.add(GetDrivers());
  }

  bool get driversToggle => _bDrivers;
  bool get shuttlesToggle => _bShuttles;
  List<Driver> get driversList => _driversList;
  List<Shuttle> get shuttlesList => _shuttlesList;


  @override
  Stream<AdminPageState> mapEventToState(AdminEvent event) async* {

    if ( event is AddNewDriver ) yield AddDriverPage();

    else if ( event is AddNewShuttle ) yield AddShuttlePage();

    else if  ( event is ViewDashboard) yield* _mapViewDashboardToState(event);

    else if ( event is GetDrivers ) yield* _mapGetDriversToState();

    else if ( event is GetShuttles ) yield* _mapGetShuttlesToState();

    else if ( event is Logout ) yield* _mapLogoutToState();

    else if ( event is AddShuttle ) yield* _mapAddShuttleToState(event);

    else if ( event is AddDriver ) yield* _mapAddDriverToState(event);

  }


  Stream<AdminPageState> _mapGetDriversToState() async* {
    yield(DashBoardPage(Loading: true));

    print('drivers\n\n\n');

    _driversList = []; //empty prior data

    QuerySnapshot drivers = await kDB.collection('users').get();

    drivers.docs.forEach((snapshot) => _driversList.add( Driver.fromDocSnap(snapshot)) );

    // await Future.forEach(drivers.docs, (snapshot) => _driversList.add( Driver.fromDocSnap(snapshot)) );

    this.add(ViewDashboard(listName: 'drivers'));

  }


  Stream<AdminPageState> _mapGetShuttlesToState() async* {
    yield(DashBoardPage(Loading: true));

    print('shuttles\n\n\n');
    _shuttlesList = [];           //empty prior data

    QuerySnapshot shuttles = await kDB.collection('shuttles').get();

    shuttles.docs.forEach((snapshot) => _shuttlesList.add( Shuttle.fromSnapshot(snapshot)) );

    // await Future.forEach(shuttles.docs, (snapshot) => _shuttlesList.add( Shuttle.fromSnapshot(snapshot)) );

    this.add(ViewDashboard(listName: 'shuttles'));

  }

  Stream<AdminPageState> _mapLogoutToState() async* {
    _driversList = [];
    _shuttlesList = [];
    kLoginBloc.add(SignOut());
  }

  Stream<AdminPageState> _mapViewDashboardToState(ViewDashboard dashboard) async* {
    (dashboard.listName == 'drivers') ? {_bDrivers = true, _bShuttles = false} : {_bDrivers = false, _bShuttles = true};
    print(_bDrivers);
    yield DashBoardPage(Loading: false, );
  }

  Stream<AdminPageState> _mapAddShuttleToState(AddShuttle shuttle) async* {
    await kDB.collection('shuttles').doc(shuttle.name).set({
      'current_driver' : '',
      'current_location' : GeoPoint(0.0, 0.0),
      'plate_number' : shuttle.PlateNumber,
      'online_status' : false,
    });
  }

  Stream<AdminPageState> _mapAddDriverToState(AddDriver driver) async* {
    await tempAuth.createUserWithEmailAndPassword(email: driver.Email, password: driver.Password);
    await kDB.collection('users').doc(driver.Email).set({
      'email': driver.Email.toString(),
      'name' : '${driver.FirstName} ${driver.LastName}',
      'phone' : driver.Phone,
      'username' : driver.Username,
    });
    await tempAuth.signOut();

  }
}