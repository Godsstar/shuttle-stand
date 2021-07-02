import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CredEvent extends Equatable {
  CredEvent({required this.email, required this.password});

  final String email, password;
  String username = '';
  String name = '';


  @override
  List<Object> get props => [username, password, email, name];
}


class SignIn extends CredEvent {
  final String email, password;
  SignIn({required this.email, required this.password}) : super(email: email, password: password);

}

class SignOut extends CredEvent {
  SignOut() : super(email: '', password: '');
}

class SignUp extends CredEvent {
  final String email, password;
  SignUp({required this.email, required this.password}) : super(email: email, password: password);

}
