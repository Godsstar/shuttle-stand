import 'package:flutter/material.dart' show Color, Colors;
import 'package:location/location.dart';
import '../../repo/constants.dart';
import 'package:bloc/bloc.dart';
import 'NavEvent.dart';
import 'NavState.dart';

export 'NavEvent.dart';
export 'NavState.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  int _currentIndex = 3;
  Color _fabColor = kBaseColor;



  NavBloc() : super(MapPage());


  int get currentIndex => _currentIndex;
  Color get fabColor => _fabColor;

  @override
  Stream<NavState> mapEventToState(NavEvent event) async* {
    if (event is ViewRoutes) yield* _mapViewRoutesToState(event);
    else if (event is ViewSchedules) yield* _mapViewSchedulesToState(event);
    else if (event is ViewMap) yield* _mapViewMapToState(event);
    else if (event is ViewCredentialsPage) yield* _mapCredentialsPageToState(event);
  }

  Stream<NavState> _mapViewRoutesToState(ViewRoutes event) async* {
    _currentIndex = event.index;
    _fabColor = Colors.grey;
    yield RoutesPage();
  }

  Stream<NavState> _mapViewSchedulesToState(ViewSchedules event) async* {
    _currentIndex = event.index;
    _fabColor = Colors.grey;
    yield SchedulesPage();
  }

  Stream<NavState> _mapViewMapToState(ViewMap event) async* {
    _currentIndex = event.index;
    _fabColor = kBaseColor;
    yield MapPage();
  }

  Stream<NavState> _mapCredentialsPageToState(ViewCredentialsPage event) async* {
    _currentIndex = event.index;
    _fabColor = Colors.grey;
    yield CredentialsPage();
  }
}
