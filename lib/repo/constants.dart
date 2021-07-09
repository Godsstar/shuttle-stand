import '../blocs/CredsBloc/CredsBloc.dart';
import '../blocs/NavBloc/NavBloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Color kBackgroundColor = Color(0xFFEDF1F9);
Color kBaseColor = Color(0xFF70498A);
LoginBloc kLoginBloc = LoginBloc();
NavBloc kNavBloc = NavBloc();


FirebaseAuth kAuth = FirebaseAuth.instance;
FirebaseFirestore kDB = FirebaseFirestore.instance;