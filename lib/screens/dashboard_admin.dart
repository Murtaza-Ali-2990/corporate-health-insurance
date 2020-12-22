import 'package:corporate_health_insurance/models/policy_model.dart';
import 'package:corporate_health_insurance/models/review_list_admin.dart';
import 'package:corporate_health_insurance/screens/add_policy.dart';
import 'package:corporate_health_insurance/services/auth_service.dart';
import 'package:corporate_health_insurance/services/database_service.dart';
import 'package:corporate_health_insurance/utils/decor.dart';
import 'package:corporate_health_insurance/views/policy_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardAdmin extends StatefulWidget {
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<DashboardAdmin> {
  final DatabaseService databaseService =
      DatabaseService(uid: AuthService().getUID());

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: HeadingStyle('Dashboard Admin'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => AuthService().signOut(),
            )
          ],
          bottom: TabBar(
            tabs: [
              Padding(
                  child: Text('Policies', style: TextStyle(fontSize: 20.0)),
                  padding: EdgeInsets.all(5.0)),
              Padding(
                  child: Text('Reviews', style: TextStyle(fontSize: 20.0)),
                  padding: EdgeInsets.all(5.0)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            StreamProvider<List<PolicyModel>>.value(
              value: databaseService.policies,
              child: Container(
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SemiHeadingStyle('Available Policies'),
                    SizedBox(height: 20),
                    RaisedButton.icon(
                      icon: Icon(Icons.add),
                      label: ButtonLayout('Add new Policies'),
                      color: mainColor,
                      textColor: Colors.white,
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddPolicy())),
                    ),
                    SizedBox(height: 20),
                    PolicyList(type: 'admin'),
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
