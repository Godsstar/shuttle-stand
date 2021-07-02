import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginState extends Equatable {
  List<Object> get props => [];
}

class SignedInPage extends LoginState{}

class SignedOutPage extends LoginState{}

class SignUpPage extends LoginState {}

