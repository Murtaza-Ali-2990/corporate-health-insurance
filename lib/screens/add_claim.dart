import 'package:corporate_health_insurance/models/claims_model.dart';
import 'package:corporate_health_insurance/models/employee_model.dart';
import 'package:corporate_health_insurance/models/hospital_model.dart';
import 'package:corporate_health_insurance/screens/loading_screen.dart';
import 'package:corporate_health_insurance/services/auth_service.dart';
import 'package:corporate_health_insurance/utils/decor.dart';
import 'package:corporate_health_insurance/models/policy_model.dart';
import 'package:corporate_health_insurance/services/database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddClaim extends StatefulWidget {
  final model;
  AddClaim(this.model);

  _Add createState() => _Add(model);
}

class _Add extends State<AddClaim> {
  final HospitalModel hospitalModel;
  _Add(this.hospitalModel);

  ClaimsModel model = ClaimsModel();
  int error = 0;
  bool loading = false;
  final _key = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    if (loading) Loading();

    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        margin: EdgeInsets.only(top: 20.0),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeadingStyle('Register your Claim'),
              SizedBox(height: 50.0),
              SizedBox(
                width: 400.0,
                child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: model.claimAmount,
                          decoration:
                              textInputDecor.copyWith(hintText: 'Claim Amount'),
                          validator: (value) {
                            if (value.isEmpty) return 'Enter Claim Amount';
                            if (isNumeric(value)) return null;
                            return 'Enter a number';
                          },
                          onChanged: (value) =>
                              setState(() => model.claimAmount = value),
                        ),
                        SizedBox(height: 30.0),
                      ],
                    )),
              ),
              SizedBox(height: 15.0),
              RaisedButton.icon(
                icon: Icon(Icons.add),
                label: ButtonLayout('Add Claim'),
                color: mainColor,
                textColor: Colors.white,
                onPressed: _addClaim,
              ),
              SizedBox(height: 20.0),
              if (error == 1) ErrorTextStyle('No Policy Found'),
              if (error == 2)
                ErrorTextStyle('Claim Amount cannot exceed the Limit'),
            ],
          ),
        ),
      ),
    );
  }

  Future _addClaim() async {
    if (_key.currentState.validate()) {
      setState(() => loading = true);

      model.hid = hospitalModel.id;
      model.hospital = hospitalModel.name;

      try {
        EmployeeModel employeeModel =
            await DatabaseService(uid: AuthService().getUID()).getEmployee();
        PolicyModel policyModel =
            await DatabaseService(uid: employeeModel.cid).getCurrentPolicy();

        if (policyModel == null) {
          error = 1;
          setState(() => loading = false);
          return;
        } else
          error = 0;

        model.cid = employeeModel.cid;
        model.company = employeeModel.company;
        model.name = employeeModel.name;
        model.eid = AuthService().getUID();

        model.pid = policyModel.id;
        model.claimLimit = policyModel.claimLimit;
        model.details = policyModel.details;

        if (int.parse(model.claimAmount) > int.parse(model.claimLimit)) {
          error = 2;
          setState(() => loading = false);
          return;
        } else
          error = 0;

        await DatabaseService(uid: model.eid).addClaims(model);
      } catch (e) {
        print(e);
      }
      setState(() => loading = false);
      if (error == 0) Navigator.pop(context);
    }
  }
}
