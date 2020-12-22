import 'package:corporate_health_insurance/models/corporate_model.dart';
import 'package:corporate_health_insurance/models/employee_model.dart';
import 'package:corporate_health_insurance/models/hospital_model.dart';
import 'package:corporate_health_insurance/services/database_service.dart';
import 'package:corporate_health_insurance/models/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signIn({String email, String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      return e.code;
    }
  }

  String getUID() {
    return _auth.currentUser.uid;
  }

  Future registerCorporate(CorporateModel model) async {
    try {
      User user = (await _auth.createUserWithEmailAndPassword(
              email: model.email, password: model.password))
          .user;
      await DatabaseService(uid: user.uid).addCorporate(model);
    } catch (e) {
      return e.code;
    }
  }

  Future registerHospital(HospitalModel model) async {
    try {
      User user = (await _auth.createUserWithEmailAndPassword(
              email: model.email, password: model.password))
          .user;
      await DatabaseService(uid: user.uid).addHospital(model);
    } catch (e) {
      return e.code;
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Problem logging out $e');
    }
  }

  Stream<UserData> get user {
    return _auth.authStateChanges().map(_toUser);
  }

  UserData _toUser(User user) {
    return UserData(user?.uid, type: user?.displayName);
  }
}

class SecondaryAuthService {
  FirebaseApp secondaryApp = Firebase.app('SecondaryApp');

  Future registerEmployee(EmployeeModel model) async {
    FirebaseAuth _auth = FirebaseAuth.instanceFor(app: secondaryApp);

    try {
      UserData data =
          await DatabaseService(uid: AuthService().getUID()).getUser();
      User user = (await _auth.createUserWithEmailAndPassword(
              email: model.email, password: 'abc123'))
          .user;

      model.company = data.name;
      model.cid = data.uid;

      await DatabaseService(uid: user.uid).addEmployee(model);
      await _auth.signOut();
    } catch (e) {
      return e.code;
    }

    return 'success';
  }
}
