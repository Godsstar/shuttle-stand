import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:google_directions_api/google_directions_api.dart';
import 'package:shuttle_tracker/Ui/RoutesUi.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'Ui/GetUi.dart';
import 'blocs/NavBloc/NavBloc.dart';
import 'repo/constants.dart';
import 'Ui/dashboard/AdminDashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DirectionsService.init('AIzaSyCBtswCK8sqjQyMSOziKZdUcYSav7se-qU');

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenView(
      backgroundColor: Colors.white,
      imageSrc: 'images/logo.png',
      imageSize: 100,
      duration: 5000,
      navigateRoute: BasePage(),
      )
    ),
  );
}


class BasePage extends StatefulWidget {
  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: kBackgroundColor,
        floatingActionButton: FloatingActionButton(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          onPressed: () => setState(() => kNavBloc.add(ViewMap())),
          backgroundColor: kBackgroundColor,
          child: Icon(
            Icons.location_on_outlined,
            color: kNavBloc.fabColor,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar(
          onTap: (index) => setState(
            () => (index == 0)
                ? kNavBloc.add(ViewRoutes())
                : kNavBloc.add(
                    ViewSchedules(),
                  ),
          ),
          activeIndex: kNavBloc.currentIndex,
          icons: [Icons.alt_route_rounded, Icons.access_time],
          activeColor: kBaseColor,
          inactiveColor: Colors.grey,
          splashRadius: 0.1,
          backgroundColor: kBackgroundColor,
          leftCornerRadius: 5.0,
          rightCornerRadius: 5.0,
          gapLocation: GapLocation.center,
        ),
        body: BlocBuilder<NavBloc, NavState>(
          bloc: kNavBloc,
          builder: (context, state) {
            if (state is RoutesPage)
              return RoutesUi();
            else if (state is MapPage)
              return MapUi();
            else if (state is CredentialsPage)
              return CredsPage();
            else if (state is SchedulesPage) return Schedule();

            return Container();
          },
        ),
      ),
    );
  }
}


/*
*  BasePage()*/