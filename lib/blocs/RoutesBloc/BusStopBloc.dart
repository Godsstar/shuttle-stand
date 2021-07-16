import 'package:google_directions_api/google_directions_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shuttle_tracker/repo/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:shuttle_tracker/repo/models.dart';
import 'BusStopEvent.dart';
import 'dart:async';

export 'BusStopEvent.dart';

class StandsEta extends Bloc<UpdateBusStops, Map<String, List<Shuttle>>> {
  final etaCalculator = DirectionsService();

  int _ETA = 0;

  QuerySnapshot? _snapshot;

  Map<String, GeoPoint> _StopLocations = {
    'lecture theatre' : GeoPoint(6.673729, 3.159949),
    'cst' : GeoPoint(6.673383, 3.159761),
    'round about' : GeoPoint(6.672025, 3.158854),
    'library' : GeoPoint(6.670124, 3.157516),
    'hall of residence' : GeoPoint(6.669351, 3.156985),
    'pg hall' : GeoPoint(6.666922, 3.156356),
    'cds' : GeoPoint(6.671425, 3.159114),
    'senate' : GeoPoint(6.673388, 3.159958),
    'cafeteria two' : GeoPoint(6.672080, 3.162251),
    'aldc' : GeoPoint(6.672218, 3.162643),
    'mech engr building' : GeoPoint(6.673252, 3.162510),
    'civil engr building' : GeoPoint(6.674504, 3.162361),
    'eie building' : GeoPoint(6.675688, 3.162238),
    'covenant gate' : GeoPoint(6.677669, 3.162594),
  };

  Map<String, List<Shuttle>> _BusStops = {
    'lecture theatre' : [],
    'cst' : [],
    'round about' : [],
    'library' : [],
    'hall of residence' : [],
    'pg hall' : [],
    'cds' : [],
    'senate' : [],
    'cafeteria two' : [],
    'aldc' : [],
    'mech engr building' : [],
    'civil engr building' : [],
    'eie building' : [],
    'covenant gate' : [],
  };

  Map<String, int> _carsEta = {
    'Blue Toyota' : 0,
    'Grey Toyota' : 0,
    'White Sienna' : 0,
    'Brown Sienna' : 0,
    'Green Sienna' : 0,
    'Costa Bus' : 0,
  };


  Timer? _updateEta;


  StandsEta() : super({
    'lecture theatre' : [],
    'cst' : [],
    'round about' : [],
    'library' : [],
    'hall of residence' : [],
    'pg hall' : [],
    'cds' : [],
    'senate' : [],
    'cafeteria two' : [],
    'aldc' : [],
    'mech engr building' : [],
    'civil engr building' : [],
    'eie building' : [],
    'covenant gate' : [],
  }) {
    _updateEta = Timer.periodic(Duration(seconds: 4), (timer) => this.add(UpdateBusStops()) );
  }

  Map<String, List<Shuttle>> get BusStops => _BusStops;
  
  @override
  Stream< Map<String, List<Shuttle>>> mapEventToState(event) async* {
    _BusStops = {
      'lecture theatre' : [],
      'cst' : [],
      'round about' : [],
      'library' : [],
      'hall of residence' : [],
      'pg hall' : [],
      'cds' : [],
      'senate' : [],
      'cafeteria two' : [],
      'aldc' : [],
      'mech engr building' : [],
      'civil engr building' : [],
      'eie building' : [],
      'covenant gate' : [],
    };

    _snapshot = await kDB.collection('shuttles').get();

    _snapshot!.docs.forEach((shuttle) async {
      if (shuttle['online_status'] == true) {
        LatLng shuttleLocation = LatLng(shuttle['current_location'].latitude, shuttle['current_location'].longitude);
        _BusStops.keys.forEach((key) async => _BusStops[key]!.add(await getEta(key, shuttleLocation, shuttle)));
      }

    });

    yield _BusStops;
  }







  Future<Shuttle> getEta(String key, LatLng shuttleLoc, QueryDocumentSnapshot shuttle) async {
    final request = DirectionsRequest(
      origin: '${shuttleLoc.latitude},${shuttleLoc.longitude}',
      destination: '${_StopLocations[key]!.latitude},${_StopLocations[key]!.longitude}',
      travelMode: TravelMode.driving,
      optimizeWaypoints: true,
      alternatives: false,
    );

    etaCalculator.route(request, (response, status) {
      _carsEta[shuttle.id] = 0;

      if (status == DirectionsStatus.ok) response.routes![0].legs![0].steps!.forEach( (step) =>
      _carsEta[shuttle.id] = _carsEta[shuttle.id]! + int.parse(step.duration!.text![0])
      );

      if (_carsEta[shuttle.id]! >= 10 && _carsEta[shuttle.id]! < 13) _carsEta[shuttle.id] = _carsEta[shuttle.id]! - 6;
      else if (_carsEta[shuttle.id]! > 5 && _carsEta[shuttle.id]! < 10) _carsEta[shuttle.id] = _carsEta[shuttle.id]! - 4;
      else if (_carsEta[shuttle.id]! >= 13) _carsEta[shuttle.id] = _carsEta[shuttle.id]! - 9;
      else if (_carsEta[shuttle.id]! < 5 && _carsEta[shuttle.id]! > 2) _carsEta[shuttle.id] = _carsEta[shuttle.id]! - 2;


    });

    Shuttle shuttleObj = Shuttle.fromSnapshot(shuttle);

    await shuttleObj.setEta('${_carsEta[shuttle.id]} Minutes');
    return shuttleObj;
  }


  dispose(){
    _updateEta!.cancel();
    super.close();
  }
}