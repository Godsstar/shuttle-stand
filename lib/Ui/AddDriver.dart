import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:shuttle_tracker/blocs/AdminBloc/AdminEvent.dart';
import '../../repo/constants.dart';

class NewDriver extends StatelessWidget {
  final TextEditingController FirstName = TextEditingController();
  final TextEditingController LastName = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController phone = TextEditingController();

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
                    IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () => adminBloc.add(ViewDashboard(listName: 'drivers')),),
                  ],
                ),
                Text(
                  'Add Driver',
                  style: TextStyle(fontSize: 25.0, color: Colors.black),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 20.0),
                  color: Colors.grey[300],
                  height: 2.0,
                ),
                FormBuilderTextField(
                  controller: FirstName,
                  name: 'FirstName',
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
                      labelText: 'First Name',
                      labelStyle: TextStyle(color: Colors.black)),
                ),
                SizedBox(
                  height: 50.0,
                ),
                FormBuilderTextField(
                  controller: LastName,
                  name: 'LastName',
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
                      labelText: 'Last Name',
                      labelStyle: TextStyle(color: Colors.black)),
                ),
                SizedBox(
                  height: 50.0,
                ),
                FormBuilderTextField(
                  name: 'username',
                  controller: username,
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
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Colors.black)),
                ),
                SizedBox(
                  height: 50.0,
                ),
                FormBuilderTextField(
                  name: 'email',
                  controller: email,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0x9FE4E4E4),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Email Address',
                      labelStyle: TextStyle(color: Colors.black)),
                ),
                SizedBox(
                  height: 50.0,
                ),
                FormBuilderTextField(
                  name: 'phone',
                  controller: phone,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0x9FE4E4E4),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(color: Colors.black)),
                ),
                SizedBox(
                  height: 50.0,
                ),
                FormBuilderTextField(
                  name: 'password',
                  controller: password,
                  obscureText: true,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0x9FE4E4E4),
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        color: Colors.black,
                      ),
                      suffixIcon: Icon(
                        Icons.remove_red_eye_sharp,
                        color: Colors.black,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.black)),
                ),
                SizedBox(
                  height: 50.0,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 100.0, vertical: 20.0),
                      primary: Color(0xFFCA3535),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      side: BorderSide(color: Colors.black)),
                  onPressed: () => adminBloc.add(AddDriver(
                      FirstName: FirstName.text,
                      LastName: LastName.text,
                      Username: username.text,
                      Email: email.text,
                      Password: password.text,
                      Phone: phone.text)),
                  child: Text(
                    'Add',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
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
