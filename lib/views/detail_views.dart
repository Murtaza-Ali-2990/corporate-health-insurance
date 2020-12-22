import 'package:corporate_health_insurance/models/corporate_model.dart';
import 'package:corporate_health_insurance/models/employee_model.dart';
import 'package:corporate_health_insurance/models/hospital_model.dart';
import 'package:corporate_health_insurance/models/policy_model.dart';
import 'package:corporate_health_insurance/utils/decor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailCorporate extends StatelessWidget {
  Widget build(BuildContext context) {
    CorporateModel model = Provider.of<CorporateModel>(context);
    if (model == null) return MiniHeadingStyle('No Purchased Policy');

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20.0),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MiniHeadingStyle('Name:   ${model.name}'),
                  SizedBox(width: 50.0),
                  MiniHeadingStyle('Type:   ${model.type}'),
                ],
              ),
              SizedBox(height: 5.0),
              MiniHeadingStyle('Address:   ${model.address}'),
              SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MiniHeadingStyle('Country:   ${model.country}'),
                  SizedBox(width: 50.0),
                  MiniHeadingStyle('Contact:   ${model.contact}'),
                ],
              ),
              SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MiniHeadingStyle('HR Manager:   ${model.hrManager}'),
                  SizedBox(width: 50.0),
                  MiniHeadingStyle('Employees:   ${model.employees}')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailPolicy extends StatelessWidget {
  Widget build(BuildContext context) {
    PolicyModel model = Provider.of<PolicyModel>(context);
    if (model == null) return MiniHeadingStyle('No Purchased Policy');

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20.0),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MiniHeadingStyle('ID:   ${model.id}'),
              SizedBox(height: 5.0),
              MiniHeadingStyle('Details:   ${model.details}'),
              SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MiniHeadingStyle('Claim Limit:   ${model.claimLimit}'),
                  SizedBox(width: 50.0),
                  MiniHeadingStyle('Term:   ${model.term}')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailHospital extends StatelessWidget {
  Widget build(BuildContext context) {
    HospitalModel model = Provider.of<HospitalModel>(context);
    if (model == null) return MiniHeadingStyle('No Hospital Found');

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20.0),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MiniHeadingStyle('Name:   ${model.name}'),
                  SizedBox(width: 50.0),
                  MiniHeadingStyle('Type:   ${model.type}'),
                ],
              ),
              SizedBox(height: 5.0),
              MiniHeadingStyle('Address:   ${model.address}'),
              SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MiniHeadingStyle('Country:   ${model.country}'),
                  SizedBox(width: 50.0),
                  MiniHeadingStyle('Contact:   ${model.contact}'),
                ],
              ),
              SizedBox(height: 5.0),
              MiniHeadingStyle('Capacity:   ${model.capacity}'),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailEmployee extends StatelessWidget {
  Widget build(BuildContext context) {
    EmployeeModel model = Provider.of<EmployeeModel>(context);
    if (model == null) return MiniHeadingStyle('No Purchased Policy');

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20.0),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MiniHeadingStyle('Name:   ${model.name}'),
                  SizedBox(width: 50.0),
                  MiniHeadingStyle('Contact:   ${model.contact}'),
                ],
              ),
              SizedBox(height: 5.0),
              MiniHeadingStyle('Address:   ${model.address}'),
              SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MiniHeadingStyle('Company:   ${model.company}'),
                  SizedBox(width: 50.0),
                  MiniHeadingStyle('Department:   ${model.department}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
