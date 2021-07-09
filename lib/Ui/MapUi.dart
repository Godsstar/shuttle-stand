import 'dart:async';

import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shuttle_tracker/blocs/NavBloc/NavEvent.dart';
import 'package:shuttle_tracker/repo/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/TrackingBloc/TrackingBloc.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class MapUi extends StatefulWidget {
  MapBloc bloc = MapBloc();
  @override
  _MapUiState createState() => _MapUiState();
}

class _MapUiState extends State<MapUi> {
  Location location = Location();
  Timer? tracker;
  void _onMapCreated(GoogleMapController miniController) {
    location.onLocationChanged.listen((event) {
      miniController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(event.latitude ?? 0.0, event.longitude ?? 0.0),
                zoom: 18.0),
          )
    );});
  }

  @override
  void dispose() {
    tracker!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, Map<String, Marker>>(
        bloc: widget.bloc,

        builder: (context, markers) {
          Timer.periodic(Duration(seconds: 5), (timer) {
            widget.bloc.add(updateMap());
          });

          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(6.6726, 3.1612), zoom: 18.0, tilt: 0, bearing: 0),
                // onMapCreated: _onMapCreated,
                compassEnabled: false,
                mapToolbarEnabled: false,
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                markers: Set<Marker>.of(markers.values),
              ),
              // GoogleMaps(controller: widget.bloc.controller),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () => kNavBloc.add(ViewCredentialsPage()),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(Icons.person_outline_rounded, size: 100.0, color: Colors.blue,),
                  )
                  ,
                ),

              )
            ],
          );
        }
    );

  }
}
