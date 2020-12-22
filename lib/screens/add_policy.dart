import 'package:corporate_health_insurance/screens/loading_screen.dart';
import 'package:corporate_health_insurance/utils/decor.dart';
import 'package:corporate_health_insurance/models/policy_model.dart';
import 'package:corporate_health_insurance/services/database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPolicy extends StatefulWidget {
  _Add createState() => _Add();
}

class _Add extends State<AddPolicy> {
  PolicyModel model = PolicyModel();
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
              HeadingStyle('Register new Policy'),
              SizedBox(height: 50.0),
              SizedBox(
                width: 400.0,
                child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: model.details,
                          decoration:
                              textInputDecor.copyWith(hintText: 'Details'),
                          validator: (value) =>
                              value.isEmpty ? 'Enter Details' : null,
                          onChanged: (value) =>
                              setState(() => model.details = value),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          initialValue: model.claimLimit,
                          decoration:
                              textInputDecor.copyWith(hintText: 'Claim Limit'),
                          validator: (value) {
                            if (value.isEmpty) return 'Enter Claim Limit';
                            if (isNumeric(value)) return null;
                            return 'Enter a number';
                          },
                          onChanged: (value) =>
                              setState(() => model.claimLimit = value),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          initialValue: model.term,
                          decoration: textInputDecor.copyWith(hintText: 'Term'),
                          validator: (value) {
                            if (value.isEmpty) return 'Enter Term';
                            if (isNumeric(value)) {
                              if (value.length == 1 || value.length == 2)
                                return null;
                              return 'Term should be between 1-99';
                            }
                            return 'Enter a number';
                          },
                          onChanged: (value) =>
                              setState(() => model.term = value),
                        ),
                        SizedBox(height: 30.0),
                      ],
                    )),
              ),
              SizedBox(height: 15.0),
              RaisedButton.icon(
                icon: Icon(Icons.add),
                label: ButtonLayout('Add Policy'),
                color: mainColor,
                textColor: Colors.white,
                onPressed: _addPolicy,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _addPolicy() async {
    if (_key.currentState.validate()) {
      setState(() => loading = true);
      await DatabaseService().addPolicy(model);
      setState(() => loading = false);
      Navigator.pop(context);
    }
  }
}
