import 'package:corporate_health_insurance/models/claims_model.dart';
import 'package:corporate_health_insurance/models/employee_model.dart';
import 'package:corporate_health_insurance/models/hospital_model.dart';
import 'package:corporate_health_insurance/models/policy_model.dart';
import 'package:corporate_health_insurance/models/review_list.dart';
import 'package:corporate_health_insurance/services/auth_service.dart';
import 'package:corporate_health_insurance/services/database_service.dart';
import 'package:corporate_health_insurance/utils/decor.dart';
import 'package:corporate_health_insurance/views/claims_list_view.dart';
import 'package:corporate_health_insurance/views/detail_views.dart';
import 'package:corporate_health_insurance/views/hosp_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardEmployee extends StatefulWidget {
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<DashboardEmployee> {
  DatabaseService databaseService =
      DatabaseService(uid: AuthService().getUID());

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: HeadingStyle('Dashboard Employee'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => AuthService().signOut(),
            )
          ],
          bottom: TabBar(
            tabs: [
              Padding(
                  child: Text('Home', style: TextStyle(fontSize: 20.0)),
                  padding: EdgeInsets.all(5.0)),
              Padding(
                  child: Text('Claims', style: TextStyle(fontSize: 20.0)),
                  padding: EdgeInsets.all(5.0)),
              Padding(
                  child: Text('Hospitals', style: TextStyle(fontSize: 20.0)),
                  padding: EdgeInsets.all(5.0)),
              Padding(
                  child: Text('Profile', style: TextStyle(fontSize: 20.0)),
                  padding: EdgeInsets.all(5.0)),
              Padding(
                  child: Text('Discussions', style: TextStyle(fontSize: 20.0)),
                  padding: EdgeInsets.all(5.0)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            StreamProvider<EmployeeModel>.value(
              value: databaseService.employee,
              child: EmployeeListener(),
            ),
            StreamProvider<List<ClaimsModel>>.value(
              value: databaseService.claims,
              child: Container(
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SemiHeadingStyle('Claims'),
                    SizedBox(height: 20),
                    ClaimsList(),
                  ],
                ),
              ),
            ),
            StreamProvider<List<HospitalModel>>.value(
              value: databaseService.hospitals,
              child: Container(
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SemiHeadingStyle('Hospitals'),
                    SizedBox(height: 20),
                    HospitalList(),
                  ],
                ),
              ),
            ),
            StreamProvider<EmployeeModel>.value(
              value: databaseService.employee,
              child: Container(
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SemiHeadingStyle('Profile'),
                    SizedBox(height: 20),
                    DetailEmployee(),
                  ],
                ),
              ),
            ),
            StreamProvider<List<String>>.value(
              value: databaseService.reviews,
              child: Container(
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SemiHeadingStyle('Reviews'),
                    SizedBox(height: 20),
                    ReviewList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmployeeListener extends StatefulWidget {
  _Listener createState() => _Listener();
}

class _Listener extends State<EmployeeListener> {
  Widget build(BuildContext context) {
    EmployeeModel model = Provider.of<EmployeeModel>(context);
    if (model == null) return MiniHeadingStyle('No Employer Available');

    return StreamProvider<PolicyModel>.value(
      value: DatabaseService(uid: model.cid).currentPolicy,
      child: Container(
        padding: EdgeInsets.all(20.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            SemiHeadingStyle('Policy Details'),
            SizedBox(height: 20),
            DetailPolicy(),
          ],
        ),
      ),
    );
  }
}
