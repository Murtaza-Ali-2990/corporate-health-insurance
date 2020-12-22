import 'package:corporate_health_insurance/models/claims_model.dart';
import 'package:corporate_health_insurance/models/employee_model.dart';
import 'package:corporate_health_insurance/models/hospital_model.dart';
import 'package:corporate_health_insurance/models/policy_model.dart';
import 'package:corporate_health_insurance/screens/add_claim.dart';
import 'package:corporate_health_insurance/services/auth_service.dart';
import 'package:corporate_health_insurance/services/database_service.dart';
import 'package:corporate_health_insurance/utils/decor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmployeeView extends StatelessWidget {
  final EmployeeModel model;
  EmployeeView(this.model);

  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Name:   ${model.name}'),
                SizedBox(width: 20.0),
                Text('Department:   ${model.department}')
              ],
            ),
            SizedBox(height: 2.0),
            Text('Address:   ${model.address}'),
            SizedBox(height: 2.0),
            Text('Contact:   ${model.contact}'),
            SizedBox(height: 2.0),
          ],
        ),
      ),
    );
  }
}

class HospitalView extends StatelessWidget {
  final HospitalModel model;
  HospitalView(this.model);

  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Name:   ${model.name}'),
                SizedBox(width: 20.0),
                Text('Type:   ${model.type}')
              ],
            ),
            SizedBox(height: 2.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Address:   ${model.address}'),
                SizedBox(width: 20.0),
                Text('Country:   ${model.country}')
              ],
            ),
            SizedBox(height: 2.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Contact:   ${model.contact}'),
                SizedBox(width: 20.0),
                Text('Capacity:   ${model.capacity}')
              ],
            ),
            SizedBox(height: 5.0),
            RaisedButton.icon(
              icon: Icon(Icons.add),
              color: mainColor,
              textColor: Colors.white,
              label: ButtonLayout('Add new Claim'),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddClaim(model))),
            ),
            SizedBox(height: 2.0),
          ],
        ),
      ),
    );
  }
}

class ClaimsView extends StatelessWidget {
  final ClaimsModel model;
  ClaimsView(this.model);

  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID:   ${model.id}'),
            SizedBox(height: 2.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Beneficiary Name:   ${model.name}'),
                SizedBox(width: 20.0),
                Text('Company:   ${model.company}')
              ],
            ),
            SizedBox(height: 2.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Claim Amount:   ${model.claimAmount}'),
                SizedBox(width: 20.0),
                Text('Claim Limit:   ${model.claimLimit}')
              ],
            ),
            SizedBox(height: 2.0),
            Text('Hospital:   ${model.hospital}'),
            SizedBox(height: 2.0),
            Text('Policy Details:   ${model.details}'),
            SizedBox(height: 2.0),
          ],
        ),
      ),
    );
  }
}

class PolicyView extends StatefulWidget {
  final model, type;
  PolicyView(this.model, this.type);

  _PolicyView createState() => _PolicyView(model, type);
}

class _PolicyView extends State<PolicyView> {
  final PolicyModel model;
  final String type;
  _PolicyView(this.model, this.type);

  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('ID:   ${model.id}'),
                SizedBox(width: 20.0),
                Text('Term:   ${model.term}'),
              ],
            ),
            SizedBox(height: 2.0),
            Text('Details:   ${model.details}'),
            SizedBox(height: 2.0),
            Text('Max Claim Limit:   ${model.claimLimit}'),
            if (type == 'corp') SizedBox(height: 5.0),
            if (type == 'corp')
              RaisedButton.icon(
                icon: Icon(Icons.add),
                color: mainColor,
                textColor: Colors.white,
                label: ButtonLayout('Add Policy'),
                onPressed: _updateCurrentPolicy,
              ),
            SizedBox(height: 2.0),
          ],
        ),
      ),
    );
  }

  Future _updateCurrentPolicy() async {
    try {
      await DatabaseService(uid: AuthService().getUID())
          .setCurrentPolicy(model);
    } catch (e) {
      print(e);
    }
  }
}
