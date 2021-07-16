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
  String? _selectedShuttle = 'Select Vehicle';
  bool _toggleState = false;
  bool _lockShuttle = false;

  Driver? _driver;


  LoginBloc() : super(SignedOutPage());


  Driver? get driver => _driver;

  String? get selectedShuttle => _selectedShuttle;

  bool get toggleState => _toggleState;


  Stream<LoginState> mapEventToState(CredEvent event) async* {
    if (event is SignIn) yield* _mapSignInToState(event);
    if (event is chooseVehicle) yield* _mapChooseVehicleToState(event);
    if (event is GetSignInCreds) yield* _mapSignInCredsToState(event);
    if (event is GetSignUpCreds) yield* _mapSignUpCredsToState(event);
    else if (event is SignUp) yield* _mapSignUpToState(event);
    else if (event is SignOut) yield* _mapSignOutToState(event);
    else if (event is SignedIn) yield* _mapSignedInToState(event);
    else if (event is ShowLoading) yield* _mapShowLoadingToState(event);
    if (event is ToggleOnlineStatus) yield* _mapToggleStatusToState(event);

  }




  Stream<LoginState> _mapSignInToState(SignIn event) async* {
    yield LoadingPage();

    try{
      await kAuth.signInWithEmailAndPassword(email: event.email, password: event.password);

      await this.setDriver(kAuth.currentUser!.email!);

      this.resetDashBoard();

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
      
      await this.resetDashBoard();

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

  Stream<LoginState> _mapChooseVehicleToState(chooseVehicle event) async* {
    (event.vehicle != 'Select Vehicle')
        ? {
            _driver!.setShuttle(Shuttle(ID: event.vehicle, current_driver: _driver!.name)),
            _selectedShuttle = event.vehicle,
          }
        : {};

    this.add(SignedIn(email: event.email));
  }

  Stream<LoginState> _mapToggleStatusToState(ToggleOnlineStatus event) async* {
    if (event.status == false) _selectedShuttle = 'Select Vehicle';
    
    _toggleState = event.status ;

    await _driver!.setStatus(event.status);

    (_driver!.hasShuttle == true) ? _lockShuttle = true : _lockShuttle = false;

    this.add(SignedIn(email: event.email));

  }


  Stream<LoginState> _mapSignedInToState(SignedIn event) async* {
    if (_lockShuttle == true) _selectedShuttle = null;
    yield SignedInPage(email: event.email, LockShuttle: _lockShuttle);
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


  setDriver(String email) async {
    DocumentSnapshot user = await kDB.collection('users').doc(email).get();
    if (user.exists) {
      _driver = Driver.fromDocSnap(user);
    }
  }

  resetDashBoard() {
    this._selectedShuttle = 'Select Vehicle';
    this._toggleState = false;
    this._lockShuttle = false;
  }

}