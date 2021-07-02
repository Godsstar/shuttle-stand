import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:shuttle_tracker/blocs/NavBloc/NavEvent.dart';
import 'package:shuttle_tracker/repo/constants.dart';

class MapUi extends StatefulWidget {
  @override
  _MapUiState createState() => _MapUiState();
}

class _MapUiState extends State<MapUi> {
  final CameraPosition _kInitialPosition = CameraPosition(
      target: LatLng(6.6726, 3.1612), zoom: 18.0, tilt: 0, bearing: 0);
  Location _location = Location();

  void _onMapCreated(GoogleMapController _cntlr) {
    _location.onLocationChanged.listen((l) {
      _cntlr.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(l.latitude ?? 0.0, l.longitude ?? 0.0), zoom: 20),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: _kInitialPosition,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        compassEnabled: false,
      ),
      Container(
        margin: EdgeInsets.fromLTRB(25.0, 45.0, 0.0, 0.0),
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.deepPurple,
        ),

        child: IconButton(
          iconSize: 40.0,
          color: Colors.white,
          onPressed: () => kNavBloc.add(ViewCredentialsPage()),
          icon: Icon(Icons.person_outline_rounded,),
        ),
      )
    ],);
  }
}
