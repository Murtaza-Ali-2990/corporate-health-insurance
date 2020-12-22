import 'package:corporate_health_insurance/login/sign_in.dart';
import 'package:corporate_health_insurance/models/user_data.dart';
import 'package:corporate_health_insurance/screens/dashboard_admin.dart';
import 'package:corporate_health_insurance/screens/dashboard_corporate.dart';
import 'package:corporate_health_insurance/screens/dashboard_employee.dart';
import 'package:corporate_health_insurance/screens/dashboard_hospital.dart';
import 'package:corporate_health_insurance/screens/loading_screen.dart';
import 'package:corporate_health_insurance/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);

    print('User is ${user?.uid} and type is ${user?.type}');

    if (user?.uid == null) return SignIn();

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).user,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error);
        }
        if (snapshot.hasData) {
          UserData user = snapshot.data;
          print(user?.type);
          if (user?.type == 'corp') return DashboardCorporate();
          if (user?.type == 'hosp') return DashboardHospital();
          if (user?.type == 'admin') return DashboardAdmin();
          if (user?.type == 'emp') return DashboardEmployee();
          print(user?.type);
        }
        print('Loading');
        return Loading();
      },
    );
  }
}
