import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginState extends Equatable {
  List<Object> get props => [];
}

class SignedInPage extends LoginState{
  String email;
  bool LockShuttle;
  SignedInPage({required this.email, required this.LockShuttle});

  @override
  List<Object> get props => [email, LockShuttle];
}

class SignedOutPage extends LoginState{}

class SignUpPage extends LoginState {}


class LoadingPage extends LoginState{}
