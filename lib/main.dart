import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'Ui/GetUi.dart';
import 'blocs/NavBloc/NavBloc.dart';
import 'repo/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BasePage(),
    ),
  );
}

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
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
              return Container();
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
