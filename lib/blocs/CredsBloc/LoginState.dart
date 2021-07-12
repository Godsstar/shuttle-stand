import 'package:equatable/equatable.dart';
import 'package:google_directions_api/google_directions_api.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginState extends Equatable {
  List<Object> get props => [];
}

class SignedInPage extends LoginState{
  String? email, selectedVehicle;
  bool? OnlineStatus, CapacityStatus, LockShuttle;
  SignedInPage({this.email, this.selectedVehicle, this.OnlineStatus, this.CapacityStatus, this.LockShuttle});

  @override
  List<Object> get props => [email ?? '', selectedVehicle ?? '', OnlineStatus ?? false, CapacityStatus ?? false];
}

class SignedOutPage extends LoginState{}

class SignUpPage extends LoginState {}


class LoadingPage extends LoginState{}
