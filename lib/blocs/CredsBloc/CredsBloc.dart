import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:bloc/bloc.dart';
import 'package:shuttle_tracker/blocs/NavBloc/NavBloc.dart';
import 'LoginEvent.dart';
import 'LoginState.dart';

export 'LoginEvent.dart';
export 'LoginState.dart';


enum CredState {
  SIGNED_IN,
  SIGNED_OUT,
}

class LoginBloc extends Bloc<CredEvent, LoginState> {
  CredState _credState = CredState.SIGNED_OUT;

  LoginBloc() : super(SignedOutPage());

  Stream<LoginState> mapEventToState(CredEvent event) async* {
    if (event is SignIn) yield* _mapSignInToState(event);
    else if (event is SignUp) yield* _mapSignUpToState(event);
    else if (event is SignOut) yield* _mapSignOutToState(event);
  }

  Stream<LoginState> _mapSignInToState(SignIn event) async* {
    yield SignedOutPage();
  }

  Stream<LoginState> _mapSignUpToState(SignUp event) async* {
    yield SignUpPage();
  }

  Stream<LoginState> _mapSignOutToState(SignOut event) async* {
  }

}