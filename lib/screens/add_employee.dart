import 'package:corporate_health_insurance/models/employee_model.dart';
import 'package:corporate_health_insurance/screens/loading_screen.dart';
import 'package:corporate_health_insurance/utils/decor.dart';
import 'package:corporate_health_insurance/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddEmployee extends StatefulWidget {
  _Add createState() => _Add();
}

class _Add extends State<AddEmployee> {
  EmployeeModel model = EmployeeModel();
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
              HeadingStyle('Register Employee here'),
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
                          initialValue: model.department,
                          decoration:
                              textInputDecor.copyWith(hintText: 'Department'),
                          validator: (value) =>
                              value.isEmpty ? 'Enter Department' : null,
                          onChanged: (value) =>
                              setState(() => model.department = value),
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
                          initialValue: model.email,
                          decoration:
                              textInputDecor.copyWith(hintText: 'Username'),
                          validator: (value) =>
                              value.isEmpty ? 'Enter Email' : null,
                          onChanged: (value) =>
                              setState(() => model.email = value),
                        ),
                        SizedBox(height: 30.0),
                      ],
                    )),
              ),
              SizedBox(height: 15.0),
              RaisedButton.icon(
                icon: Icon(Icons.login),
                label: ButtonLayout('Add Details'),
                color: mainColor,
                textColor: Colors.white,
                onPressed: _addPolicy,
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

  _addPolicy() async {
    if (_key.currentState.validate()) {
      setState(() => loading = true);
      dynamic user = await SecondaryAuthService().registerEmployee(model);
      print(user);
      if (user == 'email-already-in-use')
        error = 1;
      else if (user == 'weak-password')
        error = 2;
      else if (user == 'invalid-email')
        error = 3;
      else
        error = 0;
      if (error != 0) {
        setState(() => loading = false);
      } else {
        Navigator.pop(context);
      }
    }
  }
}
