import 'package:corporate_health_insurance/models/claims_model.dart';
import 'package:corporate_health_insurance/models/hospital_model.dart';
import 'package:corporate_health_insurance/models/review_list.dart';
import 'package:corporate_health_insurance/services/auth_service.dart';
import 'package:corporate_health_insurance/services/database_service.dart';
import 'package:corporate_health_insurance/utils/decor.dart';
import 'package:corporate_health_insurance/views/claims_list_view.dart';
import 'package:corporate_health_insurance/views/detail_views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardHospital extends StatefulWidget {
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<DashboardHospital> {
  final DatabaseService databaseService =
      DatabaseService(uid: AuthService().getUID());

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          title: HeadingStyle('Dashboard Hospital'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => AuthService().signOut(),
            )
          ],
          bottom: TabBar(
            tabs: [
              Padding(
                  child: Text('Claims', style: TextStyle(fontSize: 20.0)),
                  padding: EdgeInsets.all(5.0)),
              Padding(
                  child: Text('Profile', style: TextStyle(fontSize: 20.0)),
                  padding: EdgeInsets.all(5.0)),
              Padding(
                  child: Text('Dicussions', style: TextStyle(fontSize: 20.0)),
                  padding: EdgeInsets.all(5.0)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            StreamProvider<List<ClaimsModel>>.value(
              value: databaseService.claims,
              child: Container(
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Claims', style: TextStyle(fontSize: 20.0)),
                    SizedBox(height: 20),
                    ClaimsList(),
                  ],
                ),
              ),
            ),
            StreamProvider<HospitalModel>.value(
              value: databaseService.hospital,
              child: Container(
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SemiHeadingStyle('Profile'),
                    SizedBox(height: 20),
                    DetailHospital(),
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
