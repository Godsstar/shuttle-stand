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

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? autoUpdateShuttles;

  final etaCalculator = DirectionsService();

  EtaBloc() : super([
    Shuttle(ID: 'Blue Toyota', current_driver: ''),
    Shuttle(ID: 'Grey Toyota', current_driver: ''),
    Shuttle(ID: 'Costa Bus', current_driver: ''),
    Shuttle(ID: 'Green Sienna', current_driver: ''),
    Shuttle(ID: 'Brown Sienna', current_driver: ''),
    Shuttle(ID: 'White Sienna', current_driver: ''),

  ]) {
    getShuttles();

  }


  List<Shuttle> get shuttles => _shuttles;


  Stream<List<Shuttle>> mapEventToState(updateETA event) async* {
    getShuttles();
    _snapshotVar = await kDB.collection('shuttles').get();
    LocationData deviceLocation = await _locator.getLocation();

    _snapshotVar!.docs.forEach((shuttle) async {
      LatLng shuttleLocation = LatLng(shuttle['current_location'].latitude,
          shuttle['current_location'].longitude);
      LatLng deviceLoc = LatLng(
          deviceLocation.latitude ?? 0.0, deviceLocation.longitude ?? 0.0);

      DirectionsResult? response =
          await getEta(shuttle, shuttleLocation, deviceLoc);
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

  Future<dynamic> getEta(QueryDocumentSnapshot shuttle, LatLng shuttleLoc, LatLng deviceLoc) async {
    DirectionsResult? res;

    final request = DirectionsRequest(
      origin: 'New York',
      destination: 'San Francisco',
      travelMode: TravelMode.driving,
      // optimizeWaypoints: true,
      // alternatives: false,
    );

    etaCalculator.route(request,
        (response, status) => (status == DirectionsStatus.ok)
            ? {
          print('\n\n\n\n\n\n\n\n\n\n\nSUCCESSSSSS\n\n\n\n\n\n\n\n\n\n\n\n\n\n')

        }: {});

  }

  @override
  void dispose(){
    updateShuttles!.cancel();
  }
}
