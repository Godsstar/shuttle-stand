import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import '../../blocs/CredsBloc/LoginEvent.dart';
import '../../repo/constants.dart';

class SignUpForm extends StatelessWidget {
  final TextEditingController name = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

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
                Text(
                  'Sign Up',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: 'nunito_regular',
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 20.0),
                  color: Colors.grey[300],
                  height: 2.0,
                ),
                SizedBox(height: 15.0,),
                FormBuilderTextField(
                  controller: name,
                  name: 'FullName',
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
                      labelText: 'Full Name',
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
                      padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
                      primary: kBackgroundColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)
                      ),
                      side: BorderSide(
                          color: kBaseColor
                      )
                  ),
                  onPressed: ()=>kLoginBloc.add(SignUp(fullName: name.text, username: username.text, email: email.text, password: password.text)),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: kBaseColor),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(fontWeight: FontWeight.w400, color: kBaseColor),
                    ),
                    SizedBox(width: 5.0,),
                    TextButton(
                      onPressed: () => kLoginBloc.add(GetSignInCreds()),
                      child: Text(
                        'Log In',
                        style: TextStyle(color: kBaseColor),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}