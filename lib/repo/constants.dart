import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../blocs/RoutesBloc/BusStopBloc.dart';
import '../blocs/AdminBloc/AdminBloc.dart';
import '../blocs/CredsBloc/CredsBloc.dart';
import '../blocs/NavBloc/NavBloc.dart';
import 'package:flutter/material.dart';
import '../blocs/ETA/EtaBloc.dart';

Color kBackgroundColor = Color(0xFFEDF1F9);
Color kBaseColor = Color(0xFF70498A);
LoginBloc kLoginBloc = LoginBloc();
NavBloc kNavBloc = NavBloc();
EtaBloc kEtaBloc = EtaBloc();
StandsEta kStandsBloc = StandsEta();

final AdminBloc adminBloc = AdminBloc();
FirebaseAuth kAuth = FirebaseAuth.instance;
FirebaseFirestore kDB = FirebaseFirestore.instance;


class DisplayShuttle extends StatelessWidget {
  const DisplayShuttle({
    required this.name,
    required this.image,
    required this.online,
    required this.eta
  });

  final Image image;
  final bool online;
  final String name, eta;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(children: <Widget>[
            image,
            ListTile(
              leading: Icon(Icons.check_circle_outlined),
              title: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              subtitle: (online == true) ? Text('Online'): Text('Offline'),
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Estimate Time of Arrival:  $eta'))
          ]),
        ),
      ),
    );
  }
}
