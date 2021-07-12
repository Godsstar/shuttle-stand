import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../repo/constants.dart';
import 'package:bloc/bloc.dart';
import '../../repo/models.dart';
import 'LoginEvent.dart';
import 'LoginState.dart';

export 'LoginEvent.dart';
export 'LoginState.dart';




class LoginBloc extends Bloc<CredEvent, LoginState> {
  String selectedShuttle = 'Select Vehicle';
  bool toggleState = false;

  Driver? _driver;


  LoginBloc() : super(SignedOutPage());


  Driver? get driver => _driver;


  Stream<LoginState> mapEventToState(CredEvent event) async* {
    if (event is SignIn) yield* _mapSignInToState(event);
    if (event is GetSignInCreds) yield* _mapSignInCredsToState(event);
    if (event is GetSignUpCreds) yield* _mapSignUpCredsToState(event);
    else if (event is SignUp) yield* _mapSignUpToState(event);
    else if (event is SignOut) yield* _mapSignOutToState(event);
    else if (event is SignedIn) yield* _mapSignedInToState(event);
    else if (event is ShowLoading) yield* _mapShowLoadingToState(event);

  }




  Stream<LoginState> _mapSignInToState(SignIn event) async* {
    yield LoadingPage();

    try{
      await kAuth.signInWithEmailAndPassword(email: event.email, password: event.password);

      await setDriver(kAuth.currentUser!.email);

      this.add(SignedIn(email: event.email));

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        yield SignedOutPage();
      } else if (e.code == 'wrong-password') {
        yield SignedOutPage();
        print('Wrong password provided for that user.');
      }
      yield SignedOutPage();

    } catch (e) {
      yield SignedOutPage();
    }
  }



  Stream<LoginState> _mapSignUpToState(SignUp event) async* {
    yield LoadingPage();

    try{
      await kAuth.createUserWithEmailAndPassword(email: event.email, password: event.password);
      await kDB.collection('users').doc(event.email).set({
        'email' : event.email,
        'username' : event.username,
        'name' : event.fullName,
      });

      await kAuth.currentUser!.sendEmailVerification();

      this.add(SignedIn(email: event.email));

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('weak password');
      }
      else if (e.code == 'email-already-in-use') {
        print('email is already in use.');
      }
    } catch (e) {
      yield SignUpPage();
    }
  }



  Stream<LoginState> _mapSignOutToState(SignOut event) async* {
    yield LoadingPage();

    await _driver!.goOffline();
    await kAuth.signOut();

    this.add(GetSignInCreds());
  }


  Stream<LoginState> _mapSignedInToState(SignedIn event) async* {
    //
    bool lockShuttle = false;

    //Give default values if they come back null
    bool onlineToggle = event.ToggleOnlineStatus ?? false;
    bool capacityToggle = event.ToggleCapacityStatus ?? false;
    String vehicle = event.selectedVehicle ?? '';


    //process values
    (vehicle != '') ? await _driver!.setShuttle(Shuttle(ID: event.selectedVehicle, current_driver: event.email)) : {};

    (onlineToggle == true && vehicle != '') ? await _driver!.goOnline() : _driver?.goOffline();
    (_driver!.hasShuttle == true) ? lockShuttle = true : lockShuttle = false;

    (capacityToggle == true) ? {} : {};

    await this.setDriver(event.email);

    yield SignedInPage(email: event.email, LockShuttle: lockShuttle, OnlineStatus: this.driver?.online_status, selectedVehicle: this.driver?.shuttle?.name);
  }


  Stream<LoginState> _mapSignInCredsToState(GetSignInCreds event) async* {
    yield SignedOutPage();
  }


  Stream<LoginState> _mapSignUpCredsToState(GetSignUpCreds event) async* {
    yield SignUpPage();
  }

  Stream<LoginState> _mapShowLoadingToState(ShowLoading event) async* {
    yield LoadingPage();
  }


  Future<void> setDriver(String? email) async {
    DocumentSnapshot user = await kDB.collection('users').doc(email).get();
    if (user.exists) {
      _driver = Driver.fromDocSnap(user);
      _driver!.goOnline();
    }
  }


}