import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../blocs/AdminBloc/AdminBloc.dart';
import 'package:flutter/material.dart';
import '../../repo/constants.dart';

class NewShuttle extends StatelessWidget {
  final TextEditingController name  = TextEditingController();
  final TextEditingController PlateNum = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: double.infinity,
        padding: EdgeInsets.all(30.0),
        color: kBackgroundColor,
        child: FormBuilder(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () async => adminBloc.add(ViewDashboard(listName: 'drivers')),),
                  ],
                ),
                Text(
                  'Add Shuttle',
                  style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.black),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 20.0),
                  color: Colors.grey[300],
                  height: 2.0,
                ),

                FormBuilderTextField(
                  controller: name,
                  name: 'name',
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0x9FE4E4E4),
                      prefixIcon: Icon(
                        Icons.person_outline_rounded,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.black)),
                ),
                SizedBox(
                  height: 50.0,
                ),
                FormBuilderTextField(
                  controller: PlateNum,
                  name: 'plateNumber',
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0x9FE4E4E4),
                      prefixIcon: Icon(
                        Icons.person_outline_rounded,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Plate Number',
                      labelStyle: TextStyle(color: Colors.black)),
                ),
                SizedBox(
                  height: 150.0,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 100.0, vertical: 20.0),
                      primary: Color(0xFFCA3535),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      side: BorderSide(color: Colors.black)),
                  onPressed: () => adminBloc.add(AddShuttle(name: name.text, PlateNumber: PlateNum.text)),
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
