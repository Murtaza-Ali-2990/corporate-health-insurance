import 'package:corporate_health_insurance/models/user_data.dart';
import 'package:corporate_health_insurance/models/wrapper.dart';
import 'package:corporate_health_insurance/screens/loading_screen.dart';
import 'package:corporate_health_insurance/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(CHI());
}

class CHI extends StatelessWidget {
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialize(),
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return MaterialApp(
            home: Scaffold(
              body: Text(snapshot.error.toString()),
            ),
          );
        else if (snapshot.connectionState == ConnectionState.done)
          return StreamProvider<UserData>.value(
            value: AuthService().user,
            child: MaterialApp(
              home: Wrapper(),
            ),
          );

        return MaterialApp(home: Loading());
      },
    );
  }

  Future<FirebaseApp> _initialize() async {
    try {
      await Firebase.app('SecondaryApp').delete();
    } catch (e) {
      print(e);
    }
    await Firebase.initializeApp(
      name: 'SecondaryApp',
      options: const FirebaseOptions(
        apiKey: "AIzaSyDo6JYkqoAH3yAznR_qtluNRFaJir_AmJw",
        projectId: "corporate-health-insure",
        messagingSenderId: "399742152643",
        appId: "1:399742152643:web:e2502eeeed83475d139776",
      ),
    );
    return await Firebase.initializeApp();
  }
}
