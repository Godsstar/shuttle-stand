import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NavState extends Equatable {
  NavState();
  List<Object> get props => [];
}

class RoutesPage extends NavState{}

class SchedulesPage extends NavState{}

class MapPage extends NavState{}

class CredentialsPage extends NavState{}