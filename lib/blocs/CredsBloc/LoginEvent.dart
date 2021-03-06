import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CredEvent extends Equatable {
  CredEvent({required this.email, required this.password});

  final String email, password;

  @override
  List<Object> get props => [password, email];
}

class SignIn extends CredEvent {
  final String email, password;
  SignIn({required this.email, required this.password}) : super(email: email, password: password);
}



class SignUp extends CredEvent {
  String fullName, username, email, password;
  SignUp({required this.fullName, required this.username, required this.email, required this.password}) : super(email: email, password: password);

}



class SignOut extends CredEvent {
  SignOut() : super(email: '', password: '');
}



class SignedIn extends CredEvent {
  String email;
  SignedIn({required this.email} ) : super(email: '', password: '');
}


class GetSignUpCreds extends CredEvent {
  GetSignUpCreds() : super(email: 'signup', password: '');
}
class GetSignInCreds extends CredEvent {
  GetSignInCreds() : super(email: 'signin', password: '');
}

class ShowLoading extends CredEvent{
  ShowLoading() : super(email: 'loading', password: 'loading');
}


class chooseVehicle extends CredEvent {
  final String? vehicle;
  chooseVehicle(this.vehicle) : super(email: '', password: '');
}


class ToggleOnlineStatus extends CredEvent {
  final bool status;
  ToggleOnlineStatus({required this.status}) : super(email: '', password: '');
}
