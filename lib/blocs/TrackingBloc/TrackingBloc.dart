import 'package:flutter/cupertino.dart';
import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import '../../repo/constants.dart';
import 'package:bloc/bloc.dart';
import 'TrackingEvent.dart';
import 'dart:async';

export 'TrackingEvent.dart';

class MapBloc extends Bloc<MapEvent, Map<String, Marker>> {
  GoogleMapsController? _mapsController;
  BitmapDescriptor? _carIcon;
  Map<String, Marker>? _shuttles;
  Location? _location;

  StreamSubscription? _locationUpdates;

  MapBloc() : super({}) {
    makeCarIcon();
    _location = Location();
  }

  Map<String, Marker> get shuttles => _shuttles ?? {};

  Stream<Map<String, Marker>> mapEventToState(MapEvent event) async* {
    _shuttles = {};

    QuerySnapshot db_shuttles = await kDB.collection('shuttles').get();

    db_shuttles.docs.forEach((shuttle) {
      (shuttle['online_status'] == true)
          ? _shuttles![shuttle.id] = Marker(
              markerId: MarkerId(shuttle.id),
              position: LatLng(shuttle['current_location'].latitude,
                  shuttle['current_location'].longitude),
              infoWindow: InfoWindow(
                title: shuttle.id.toUpperCase(),
                snippet: 'DRIVER: ${shuttle['current_driver'].toString().toUpperCase()}'
              ),
              icon: _carIcon!,
            )
          : {};
    });

    yield this.shuttles;
  }

  void makeCarIcon() async {
    _carIcon = await BitmapDescriptor.fromAssetImage(
    ImageConfiguration(size: Size(0.1, 0.1)), 'images/motto.png');
  }
}
