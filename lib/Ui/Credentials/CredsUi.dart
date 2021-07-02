import 'package:shuttle_tracker/blocs/CredsBloc/CredsBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../repo/constants.dart';
import 'SignUp.dart';
import 'SignIn.dart';

class CredsPage extends StatefulWidget {
  @override
  _CredsPageState createState() => _CredsPageState();
}

class _CredsPageState extends State<CredsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: kLoginBloc,
      builder: (context, state){
        if (state is SignedOutPage) return SignInForm();
        else if (state is SignUpPage) return SignUpForm();
        return Container();
      },
    );
  }
}
