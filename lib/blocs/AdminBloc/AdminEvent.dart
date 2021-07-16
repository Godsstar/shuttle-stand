import 'package:equatable/equatable.dart';

class AdminEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddNewDriver extends AdminEvent {}

class AddDriver extends AdminEvent {
  final String FirstName, LastName, Username, Email, Password, Phone;
  AddDriver({
    required this.FirstName,
    required this.LastName,
    required this.Username,
    required this.Email,
    required this.Password,
    required this.Phone,
  }) :super();

  @override
  List<Object> get props => [FirstName, LastName, Username, Email, Password, Phone];
}

class AddNewShuttle extends AdminEvent {}

class AddShuttle extends AdminEvent {
  final String name, PlateNumber;
  AddShuttle({required this.name, required this.PlateNumber});

  @override
  List<Object> get props => [name, PlateNumber];
}

class GetDrivers extends AdminEvent {}

class GetShuttles extends AdminEvent {}

class ViewDashboard extends AdminEvent {
  String listName = 'Drivers';
  ViewDashboard({required this.listName});

  @override
  List<Object> get props => [listName];

}

class Logout extends AdminEvent {}