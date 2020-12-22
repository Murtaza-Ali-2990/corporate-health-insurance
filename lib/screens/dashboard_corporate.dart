import 'package:corporate_health_insurance/models/claims_model.dart';
import 'package:corporate_health_insurance/models/corporate_model.dart';
import 'package:corporate_health_insurance/models/employee_model.dart';
import 'package:corporate_health_insurance/models/policy_model.dart';
import 'package:corporate_health_insurance/models/review_list.dart';
import 'package:corporate_health_insurance/screens/add_employee.dart';
import 'package:corporate_health_insurance/services/auth_service.dart';
import 'package:corporate_health_insurance/services/database_service.dart';
import 'package:corporate_health_insurance/utils/decor.dart';
import 'package:corporate_health_insurance/views/claims_list_view.dart';
import 'package:corporate_health_insurance/views/detail_views.dart';
import 'package:corporate_health_insurance/views/emp_list_view.dart';
import 'package:corporate_health_insurance/views/policy_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardCorporate extends StatefulWidget {
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<DashboardCorporate> {
  DatabaseService databaseService =
      DatabaseService(uid: AuthService().getUID());

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: HeadingStyle('Dashboard Corporate'),
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
                  child: Text('Policy', style: TextStyle(fontSize: 20.0)),
                  padding: EdgeInsets.all(5.0)),
              Padding(
                  child: Text('Employees', style: TextStyle(fontSize: 20.0)),
                  padding: EdgeInsets.all(5.0)),
              Padding(
                  child: Text('Profile', style: TextStyle(fontSize: 20.0)),
                  padding: EdgeInsets.all(5.0)),
              Padding(
                  child: Text('Claims', style: TextStyle(fontSize: 20.0)),
                  padding: EdgeInsets.all(5.0)),
              Padding(
                  child: Text('Discussions', style: TextStyle(fontSize: 20.0)),
                  padding: EdgeInsets.all(5.0)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            StreamProvider<PolicyModel>.value(
              value: databaseService.currentPolicy,
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
            ),
            StreamProvider<List<PolicyModel>>.value(
              value: databaseService.policies,
              child: Container(
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SemiHeadingStyle('Available Policies'),
                    SizedBox(height: 20),
                    PolicyList(type: 'corp'),
                  ],
                ),
              ),
            ),
            StreamProvider<List<EmployeeModel>>.value(
              value: databaseService.employees,
              child: Container(
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SemiHeadingStyle('Employees'),
                    SizedBox(height: 20.0),
                    RaisedButton.icon(
                      icon: Icon(Icons.add),
                      label: ButtonLayout('Add new Employees'),
                      color: mainColor,
                      textColor: Colors.white,
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddEmployee())),
                    ),
                    SizedBox(height: 20),
                    EmployeeList(),
                  ],
                ),
              ),
            ),
            StreamProvider<CorporateModel>.value(
              value: databaseService.corporate,
              child: Container(
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SemiHeadingStyle('Profile'),
                    SizedBox(height: 20),
                    DetailCorporate(),
                  ],
                ),
              ),
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
