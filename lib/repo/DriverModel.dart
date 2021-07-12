import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:location/location.dart';
import 'ShuttleModel.dart';
import 'constants.dart';
import 'dart:async';


class Driver extends Equatable {
  Driver({required name, required email, required username}) : _name = name, _email = email, _username = username;

  factory Driver.fromDocSnap(DocumentSnapshot docSnap) {
    return Driver(
        name: docSnap['name'].toString(),
        email: docSnap['email'].toString(),
        username: docSnap['username'].toString()
    );
  }

  final String _name, _email, _username;
  
  Shuttle? _shuttle;

  bool _online = false;

  bool get hasShuttle => (_shuttle != null) ? true : false;

  StreamSubscription<LocationData>? _newLocation;

  String get username => _username;
  String get email => _email;
  String get name => _name;

  Location? _currentLocation;
  List<Object> get props => [_name, _email, _username, _online];

  Shuttle? get shuttle => _shuttle;

  bool get online_status => _online;

  
  
  setShuttle(Shuttle? shuttle) => _shuttle = shuttle;

  goOnline() async {
    await _shuttle?.setStatus(true);
    await kDB.collection('online_users').doc(_username).set(
        {
          'shuttle': _shuttle?.name,
        }
    );


    _online = true;
    _currentLocation = Location();
    _newLocation = _currentLocation!.onLocationChanged.listen((event) {
      _shuttle?.updateLocation(event.latitude ?? 0.0, event.longitude ?? 0.0);
    });
  }
  
  
  goOffline() async {

    _online = false;

    await _newLocation?.cancel();

    _currentLocation = null;

    await _shuttle?.setStatus(false);

    await kDB.collection('online_users').doc(_username).delete();

    await _shuttle?.updateLocation(0.0, 0.0);

    await _exitShuttle();

  }


  _exitShuttle() async {
    await kDB.collection('shuttles').doc(_shuttle?.name).update({'current_driver' : ''});

    _shuttle = null;

  }
  
}
