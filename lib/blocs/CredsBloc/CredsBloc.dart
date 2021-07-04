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
  FirebaseAuth auth = FirebaseAuth.instance;


  CredState _credState = CredState.SIGNED_OUT;


  LoginBloc() : super(SignedOutPage());

  Stream<LoginState> mapEventToState(CredEvent event) async* {
    if (event is SignIn) yield* _mapSignInToState(event);
    if (event is GetSignInCreds) yield* _mapSignInCredsToState(event);
    if (event is GetSignUpCreds) yield* _mapSignUpCredsToState(event);
    else if (event is SignUp) yield* _mapSignUpToState(event);
    else if (event is SignOut) yield* _mapSignOutToState(event);
    else if (event is SignedIn) yield* _mapSignedInToState(event);

  }

  Stream<LoginState> _mapSignInToState(SignIn event) async* {
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: event.email, password: event.password);
      this.add(SignedIn(email: event.email));

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Stream<LoginState> _mapSignUpToState(SignUp event) async* {
    try{
      UserCredential user = await auth.createUserWithEmailAndPassword(email: event.email, password: event.password);
      this.add(SignedIn(email: event.email));
      await auth.currentUser!.sendEmailVerification();

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('weak password');
      }
      else if (e.code == 'email-already-in-use') {
        print('email is already in use.');
      }
    }
  }

  Stream<LoginState> _mapSignOutToState(SignOut event) async* {
    await auth.signOut();
    this.add(GetSignInCreds());
  }

  Stream<LoginState> _mapSignedInToState(SignedIn event) async* {
    yield SignedInPage(email: event.email);
  }

  Stream<LoginState> _mapSignInCredsToState(GetSignInCreds event) async* {
    yield SignedOutPage();
  }

  Stream<LoginState> _mapSignUpCredsToState(GetSignUpCreds event) async* {
    yield SignUpPage();
  }


}