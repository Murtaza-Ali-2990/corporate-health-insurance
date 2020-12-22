import 'package:corporate_health_insurance/login/register_corporate.dart';
import 'package:corporate_health_insurance/login/register_hospital.dart';
import 'package:corporate_health_insurance/screens/loading_screen.dart';
import 'package:corporate_health_insurance/services/auth_service.dart';
import 'package:corporate_health_insurance/utils/decor.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String username, password;
  int error = 0;
  bool loading = false;
  final _key = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    if (loading) return Loading();

    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        margin: EdgeInsets.only(top: 20.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            HeadingStyle('Welcome to Corporate Health Insurance Portal'),
            SizedBox(height: 50.0),
            SizedBox(
              width: 400.0,
              child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: username,
                        decoration:
                            textInputDecor.copyWith(hintText: 'Username'),
                        validator: (value) =>
                            value.isEmpty ? 'Enter Username' : null,
                        onChanged: (value) => setState(() => username = value),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        initialValue: password,
                        obscureText: true,
                        decoration:
                            textInputDecor.copyWith(hintText: 'Password'),
                        validator: (value) =>
                            value.isEmpty ? 'Enter a Password' : null,
                        onChanged: (value) => setState(() => password = value),
                      ),
                    ],
                  )),
            ),
            SizedBox(height: 30.0),
            RaisedButton.icon(
              icon: Icon(Icons.login),
              label: ButtonLayout('Log In'),
              textColor: Colors.white,
              color: mainColor,
              onPressed: _verifyLogin,
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                    child: ButtonLayout('Register as a Corporate'),
                    color: mainColor,
                    textColor: Colors.white,
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegisterCorporate(),
                        ))),
                SizedBox(width: 30.0),
                RaisedButton(
                    child: ButtonLayout('Register as a Hospital'),
                    color: mainColor,
                    textColor: Colors.white,
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegisterHospital(),
                        ))),
              ],
            ),
            SizedBox(height: 20.0),
            if (error == 1) ErrorTextStyle('E-mail is Invalid'),
            if (error == 2) ErrorTextStyle('Wrong Password. Please try again.'),
            if (error == 3) ErrorTextStyle('Weak Password'),
            if (error == 4) ErrorTextStyle('User not Found'),
          ],
        ),
      ),
    );
  }

  Future<void> _verifyLogin() async {
    if (_key.currentState.validate()) {
      setState(() => loading = true);
      dynamic user =
          await AuthService().signIn(email: username, password: password);
      if (user == 'invalid-email')
        error = 1;
      else if (user == 'wrong-password')
        error = 2;
      else if (user == 'weak-password')
        error = 3;
      else if (user == 'user-not-found')
        error = 4;
      else
        error = 0;
      if (error != 0) setState(() => loading = false);
    }
  }
}
