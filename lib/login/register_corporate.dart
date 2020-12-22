import 'package:corporate_health_insurance/models/corporate_model.dart';
import 'package:corporate_health_insurance/screens/loading_screen.dart';
import 'package:corporate_health_insurance/services/auth_service.dart';
import 'package:corporate_health_insurance/utils/decor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterCorporate extends StatefulWidget {
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterCorporate> {
  CorporateModel model = CorporateModel();
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeadingStyle('Register your Corporate with Us'),
              SizedBox(height: 50.0),
              SizedBox(
                width: 400.0,
                child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: model.name,
                          decoration: textInputDecor.copyWith(hintText: 'Name'),
                          validator: (value) =>
                              value.isEmpty ? 'Enter Name' : null,
                          onChanged: (value) =>
                              setState(() => model.name = value),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          initialValue: model.type,
                          decoration: textInputDecor.copyWith(hintText: 'Type'),
                          validator: (value) =>
                              value.isEmpty ? 'Enter Type' : null,
                          onChanged: (value) =>
                              setState(() => model.type = value),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          initialValue: model.address,
                          decoration:
                              textInputDecor.copyWith(hintText: 'Address'),
                          validator: (value) =>
                              value.isEmpty ? 'Enter Address' : null,
                          onChanged: (value) =>
                              setState(() => model.address = value),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          initialValue: model.country,
                          decoration:
                              textInputDecor.copyWith(hintText: 'Country'),
                          validator: (value) =>
                              value.isEmpty ? 'Enter Country' : null,
                          onChanged: (value) =>
                              setState(() => model.country = value),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          initialValue: model.contact,
                          decoration:
                              textInputDecor.copyWith(hintText: 'Contact'),
                          validator: (value) {
                            if (value.isEmpty) return 'Enter Contact';
                            if (isNumeric(value)) {
                              if (value.length == 10 || value.length == 11)
                                return null;
                              return 'Length should be between 10-11';
                            }
                            return 'Enter a number';
                          },
                          onChanged: (value) =>
                              setState(() => model.contact = value),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          initialValue: model.hrManager,
                          decoration:
                              textInputDecor.copyWith(hintText: 'HR Manager'),
                          validator: (value) =>
                              value.isEmpty ? 'Enter HR Manager\'s Name' : null,
                          onChanged: (value) =>
                              setState(() => model.hrManager = value),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          initialValue: model.employees,
                          decoration: textInputDecor.copyWith(
                              hintText: 'Approx no. of Employees'),
                          validator: (value) {
                            if (value.isEmpty) return 'Enter Capacity';
                            if (isNumeric(value)) return null;
                            return 'Enter a number';
                          },
                          onChanged: (value) =>
                              setState(() => model.employees = value),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          initialValue: model.email,
                          decoration:
                              textInputDecor.copyWith(hintText: 'Username'),
                          validator: (value) =>
                              value.isEmpty ? 'Enter Email' : null,
                          onChanged: (value) =>
                              setState(() => model.email = value),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          initialValue: model.password,
                          obscureText: true,
                          decoration:
                              textInputDecor.copyWith(hintText: 'Password'),
                          validator: (value) =>
                              value.isEmpty ? 'Enter a Password' : null,
                          onChanged: (value) =>
                              setState(() => model.password = value),
                        ),
                        SizedBox(height: 30.0),
                      ],
                    )),
              ),
              SizedBox(height: 15.0),
              RaisedButton.icon(
                icon: Icon(Icons.login),
                label: ButtonLayout('Register'),
                color: mainColor,
                textColor: Colors.white,
                onPressed: _verifyRegister,
              ),
              SizedBox(height: 20.0),
              if (error == 1) ErrorTextStyle('E-mail already in use'),
              if (error == 2) ErrorTextStyle('Weak Password'),
              if (error == 3) ErrorTextStyle('Invalid Email Format'),
            ],
          ),
        ),
      ),
    );
  }

  Future _verifyRegister() async {
    if (_key.currentState.validate()) {
      setState(() => loading = true);
      dynamic user = await AuthService().registerCorporate(model);
      if (user == 'email-already-in-use')
        error = 1;
      else if (user == 'weak-password')
        error = 2;
      else if (user == 'invalid-email')
        error = 3;
      else
        error = 0;
      if (error != 0) setState(() => loading = false);
    }
  }
}
