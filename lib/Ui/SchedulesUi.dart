import 'package:shuttle_tracker/repo/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../blocs/ETA/EtaBloc.dart';
import '../repo/constants.dart';

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}


class _ScheduleState extends State<Schedule> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EtaBloc, List<Shuttle>>(
        bloc: kEtaBloc,
        builder: (context, shuttles) {
          return ListView.builder(
              padding: EdgeInsets.all(16.0),
              physics: BouncingScrollPhysics(),
              itemCount: shuttles.length,
              itemBuilder: (context, index) {
                return DisplayShuttle(
                    name: shuttles[index].name,
                    image: Image.asset(shuttles[index].ImageDir),
                    online: shuttles[index].Online!,
                    eta: (shuttles[index].eta ==  '' && shuttles[index].Online == true) ? 'calculating...' : shuttles[index].eta!,
                );
              }

          );
        }
    );
  }
}





// CardDisplay(name: 'Grey Toyota',image: Image.asset('images/shuttles/GreyToyota.jpeg'), eta: '5 Minutes', online: false,),