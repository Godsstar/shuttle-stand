import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:equatable/equatable.dart';
import 'constants.dart';

class Shuttle extends Equatable {
  Shuttle({required ID, required current_driver}) : _id = ID, _current_driver = current_driver;

  final String _id, _current_driver;
  bool _online_status = true;

  @override
  List<Object> get props => [_id, _current_driver, _online_status];

  String get id => _id;

  set online_status(bool val) => _online_status = val;

  updateLocation(double lat, double long) async {
    
    kDB.collection('shuttles').doc(_id).update({
      'current_location' : GeoPoint(lat, long)
    });
  }
  
  setStatus(bool status) async {
    _online_status = status;
    await kDB.collection('shuttles').doc(id).update({'online_status' : status});
  }
  
  UpdateETA(int time) {}

  getETA(int time) {}
}
