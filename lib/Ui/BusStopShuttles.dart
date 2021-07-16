import 'package:flutter/material.dart';
import 'package:shuttle_tracker/blocs/RoutesBloc/BusStopBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repo/ShuttleModel.dart';
import '../repo/constants.dart';

class BusStopShuttles extends StatelessWidget {
  final String stopName;

  BusStopShuttles({required this.stopName});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: BlocBuilder<StandsEta, Map<String, List<Shuttle>>>(
          bloc: kStandsBloc,
          builder: (context, busLocs) {
            return ListView.builder(
              padding: EdgeInsets.all(16.0),
              physics: BouncingScrollPhysics(),
              itemCount: busLocs[stopName]!.length,
              itemBuilder: (context, index) {
                return DisplayShuttle(
                  name: busLocs[stopName]![index].name,
                  image: Image.asset(busLocs[stopName]![index].ImageDir),
                  online: busLocs[stopName]![index].Online!,
                  eta: busLocs[stopName]![index].eta ?? 'Null',
                );
              },
            );
          },
        ),
      ),
    );
  }
}
