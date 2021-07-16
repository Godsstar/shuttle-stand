import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'constants.dart';


class Shuttle extends Equatable {
  final String _name, _current_driver;
  bool? _online_status = false;
  String? _ImageDir, _eta;
  LatLng? _location;


  Shuttle({required ID, required current_driver, location, online, eta}) : _name = ID, _current_driver = current_driver, _eta = eta{
    _assignImageDir();
    _location = location ?? LatLng(0.0, 0.0);
    _online_status = online ?? false;
  }


  factory Shuttle.fromSnapshot(var docSnap) {
    DocumentSnapshot snapshot = docSnap as DocumentSnapshot;
     return Shuttle(
         ID: snapshot.id,
         current_driver: snapshot['current_driver'].toString(),
         location: LatLng(snapshot['current_location'].latitude, snapshot['current_location'].longitude),
         online: snapshot['online_status']
     );
  }

  String get name => _name;

  String? get eta => _eta;

  setEta(String eta) => _eta = eta;

  String get ImageDir => _ImageDir!;

  bool? get Online => _online_status;

  set online_status(bool val) => _online_status = val;



  @override
  List<Object> get props => [_name, _current_driver, _online_status!];


  updateLocation(double lat, double long) async {
    
    kDB.collection('shuttles').doc(_name).update({
      'current_location' : GeoPoint(lat, long)
    });
  }
  
  setStatus(bool status) async {
    _online_status = status;

    await kDB.collection('shuttles').doc(_name).update({'online_status' : status, 'current_driver' : _current_driver});

  }


  _assignImageDir() {
    String imageName= _name.splitMapJoin(RegExp(r'\ '), onMatch: (m) => '');
    _ImageDir = 'images/shuttles/$imageName.jpeg';
  }


  @override
  String toString() {
    return """name: $_name 
    \ndriver: $_current_driver 
    \nlocation: lat ${_location!.latitude}, long ${_location!.longitude} 
    \nOnline: $_online_status\n\n""";
  }

  alertDB() {
    kDB.collection('shuttles').doc(_name).update({'current_driver' : _current_driver});
  }

  resetDriver() => kDB.collection('shuttles').doc(this._name).update({'current_driver' : ''});

}
