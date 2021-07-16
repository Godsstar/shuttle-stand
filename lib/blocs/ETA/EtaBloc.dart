import 'package:google_directions_api/google_directions_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import '../../repo/constants.dart';
import 'package:bloc/bloc.dart';
import '../../repo/models.dart';
import 'ArrivalEvent.dart';
import 'dart:async';

export 'ArrivalEvent.dart';

class EtaBloc extends Bloc<updateETA, List<Shuttle>> {
  List<Shuttle> _shuttles = [];
  QuerySnapshot? _snapshotVar;
  Location _locator = Location();
  Timer? updateShuttles;
  Map<String, int> carsEta = {
    'Blue Toyota' : 0,
    'Grey Toyota' : 0,
    'White Sienna' : 0,
    'Brown Sienna' : 0,
    'Green Sienna' : 0,
    'Costa Bus' : 0,
  };

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? autoUpdateShuttles;

  final etaCalculator = DirectionsService();

  EtaBloc() : super([
    Shuttle(ID: 'Blue Toyota', current_driver: '', online: false, eta: 'calculating...'),
    Shuttle(ID: 'Grey Toyota', current_driver: '', online: false, eta: 'calculating...'),
    Shuttle(ID: 'Costa Bus', current_driver: '', online: false, eta: 'calculating...'),
    Shuttle(ID: 'Green Sienna', current_driver: '', online: false, eta: 'calculating...'),
    Shuttle(ID: 'Brown Sienna', current_driver: '', online: false, eta: 'calculating...'),
    Shuttle(ID: 'White Sienna', current_driver: '', online: false, eta: 'calculating...'),

  ]) {
    getShuttles();

  }



  List<Shuttle> get shuttles => _shuttles;


  Stream<List<Shuttle>> mapEventToState(updateETA event) async* {
    getShuttles();
    _snapshotVar = await kDB.collection('shuttles').get();
    LocationData deviceLocation = await _locator.getLocation();
    _shuttles = [];
    _snapshotVar!.docs.forEach((shuttle) async {
      if (shuttle['online_status'] == true) {
        LatLng shuttleLocation = LatLng(shuttle['current_location'].latitude, shuttle['current_location'].longitude);
        LatLng deviceLoc = LatLng(deviceLocation.latitude ?? 0.0, deviceLocation.longitude ?? 0.0);

        _shuttles.add(await getEta(shuttle, shuttleLocation, deviceLoc));
      }

      else _shuttles.add(Shuttle(ID: shuttle.id, current_driver: '', online: false, eta: ''));
    });

    yield _shuttles;
  }

  void getShuttles() async {
    _shuttles = [];
    _snapshotVar = await kDB.collection('shuttles').get();

    _snapshotVar!.docs.forEach(
      (shuttle) => _shuttles.add(
        Shuttle.fromSnapshot(shuttle)
      )
    );

    updateShuttles = Timer.periodic(Duration(seconds: 3), (timer) => this.add(updateETA()));

  }


  Future<Shuttle> getEta(QueryDocumentSnapshot shuttle, LatLng shuttleLoc, LatLng deviceLoc) async {

    final request = DirectionsRequest(
      origin: '${shuttleLoc.latitude},${shuttleLoc.longitude}',
      destination: '${deviceLoc.latitude},${deviceLoc.longitude}',
      travelMode: TravelMode.driving,
      optimizeWaypoints: true,
      alternatives: false,
    );

    etaCalculator.route(request, (response, status) {
      carsEta[shuttle.id] = 0;

      if (status == DirectionsStatus.ok) response.routes![0].legs![0].steps!.forEach( (step) =>
        carsEta[shuttle.id] = carsEta[shuttle.id]! + int.parse(step.duration!.text![0])
      );

      if (carsEta[shuttle.id]! >= 10 && carsEta[shuttle.id]! < 13) carsEta[shuttle.id] = carsEta[shuttle.id]! - 6;
      else if (carsEta[shuttle.id]! > 5 && carsEta[shuttle.id]! < 10) carsEta[shuttle.id] = carsEta[shuttle.id]! - 4;
      else if (carsEta[shuttle.id]! >= 13) carsEta[shuttle.id] = carsEta[shuttle.id]! - 9;
      else if (carsEta[shuttle.id]! < 5 && carsEta[shuttle.id]! > 2) carsEta[shuttle.id] = carsEta[shuttle.id]! - 2;
    });
    return Shuttle(ID: shuttle.id, current_driver: shuttle['current_driver'], online: shuttle['online_status'], eta: '${carsEta[shuttle.id]} Minutes');


  }



  @override
  void dispose(){
    updateShuttles!.cancel();
  }

}
