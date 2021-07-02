import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NavEvent extends Equatable {
  final int index;
  NavEvent({required this.index});
  @override
  List<Object> get props => [index];
}

class ViewRoutes extends NavEvent {
  ViewRoutes() : super(index: 0);
}

class ViewSchedules extends NavEvent {
  ViewSchedules() : super(index: 1);
}

class ViewMap extends NavEvent {
  ViewMap() : super(index: 2);
}

class ViewCredentialsPage extends NavEvent {
  ViewCredentialsPage() : super(index: 3);
}