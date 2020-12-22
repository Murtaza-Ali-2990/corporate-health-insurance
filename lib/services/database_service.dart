import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corporate_health_insurance/models/claims_model.dart';
import 'package:corporate_health_insurance/models/corporate_model.dart';
import 'package:corporate_health_insurance/models/employee_model.dart';
import 'package:corporate_health_insurance/models/hospital_model.dart';
import 'package:corporate_health_insurance/models/policy_model.dart';
import 'package:corporate_health_insurance/models/user_data.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference policyRef =
      FirebaseFirestore.instance.collection('Policies');
  final CollectionReference reviewRef =
      FirebaseFirestore.instance.collection('Reviews');
  final CollectionReference hospitalRef =
      FirebaseFirestore.instance.collection('Hospitals');

  Stream<UserData> get user {
    return usersRef
        .doc(uid)
        .snapshots()
        .map((snap) => UserData(uid, type: snap.data()['user']));
  }

  Future<UserData> getUser() async {
    return await usersRef
        .doc(uid)
        .get()
        .then((value) => UserData(uid, name: value.data()['name']))
        .catchError((e) => print(e));
  }

  Future addReview(String review) async {
    try {
      await reviewRef.add({'review': review});
    } catch (e) {
      print(e);
    }
  }

  Stream<List<String>> get reviews {
    return reviewRef.snapshots().map(_getReviews);
  }

  List<String> _getReviews(QuerySnapshot query) {
    return query.docs.map((snap) => snap.data()['review'].toString()).toList();
  }

  Stream<List<ClaimsModel>> get claims {
    return usersRef.doc(uid).collection('Claims').snapshots().map(_getClaims);
  }

  List<ClaimsModel> _getClaims(QuerySnapshot snapshot) {
    return snapshot.docs.map(_getClaim).toList();
  }

  ClaimsModel _getClaim(DocumentSnapshot snap) {
    return ClaimsModel(
      id: snap.data()['id'],
      name: snap.data()['name'],
      company: snap.data()['company'],
      hospital: snap.data()['hospital'],
      claimAmount: snap.data()['claimAmount'],
      claimLimit: snap.data()['claimLimit'],
      details: snap.data()['details'],
      eid: snap.data()['eid'],
      hid: snap.data()['hid'],
      cid: snap.data()['cid'],
      pid: snap.data()['pid'],
    );
  }

  Future<PolicyModel> getCurrentPolicy() async {
    return await usersRef
        .doc(uid)
        .collection('Policy')
        .doc('policy')
        .get()
        .then(_getPolicy)
        .catchError(() => print('Error'));
  }

  Stream<PolicyModel> get currentPolicy {
    return usersRef
        .doc(uid)
        .collection('Policy')
        .doc('policy')
        .snapshots()
        .map(_getPolicy);
  }

  Stream<List<PolicyModel>> get policies {
    return policyRef.snapshots().map(_getPolicies);
  }

  List<PolicyModel> _getPolicies(QuerySnapshot snapshot) {
    return snapshot.docs.map(_getPolicy).toList();
  }

  PolicyModel _getPolicy(DocumentSnapshot snapshot) {
    try {
      return PolicyModel(
          claimLimit: snapshot.data()['claimLimit'],
          details: snapshot.data()['details'],
          id: snapshot.data()['id'],
          term: snapshot.data()['term']);
    } catch (e) {
      print('Here');
    }
    return null;
  }

  Future<EmployeeModel> getEmployee() async {
    return await usersRef
        .doc(uid)
        .get()
        .then(_getEmployee)
        .catchError(() => print('Error'));
  }

  Stream<List<EmployeeModel>> get employees {
    return usersRef
        .doc(uid)
        .collection('Employees')
        .snapshots()
        .map(_getEmployees);
  }

  Stream<EmployeeModel> get employee {
    return usersRef.doc(uid).snapshots().map(_getEmployee);
  }

  List<EmployeeModel> _getEmployees(QuerySnapshot snapshot) {
    return snapshot.docs.map(_getEmployee).toList();
  }

  EmployeeModel _getEmployee(DocumentSnapshot snap) {
    return EmployeeModel(
      address: snap.data()['address'],
      name: snap.data()['name'],
      email: snap.data()['email'],
      contact: snap.data()['contact'],
      department: snap.data()['department'],
      company: snap.data()['company'],
      cid: snap.data()['cid'],
    );
  }

  Stream<CorporateModel> get corporate {
    return usersRef.doc(uid).snapshots().map(_getCorporate);
  }

  CorporateModel _getCorporate(DocumentSnapshot snap) {
    return CorporateModel(
      address: snap.data()['address'],
      name: snap.data()['name'],
      email: snap.data()['email'],
      contact: snap.data()['contact'],
      type: snap.data()['type'],
      country: snap.data()['country'],
      hrManager: snap.data()['hrManager'],
      employees: snap.data()['employees'],
    );
  }

  Stream<List<HospitalModel>> get hospitals {
    return hospitalRef.snapshots().map((_getHospitals));
  }

  Stream<HospitalModel> get hospital {
    return usersRef.doc(uid).snapshots().map(_getHospital);
  }

  List<HospitalModel> _getHospitals(QuerySnapshot snapshot) {
    return snapshot.docs.map(_getHospital).toList();
  }

  HospitalModel _getHospital(DocumentSnapshot snap) {
    return HospitalModel(
      id: snap.data()['id'],
      address: snap.data()['address'],
      name: snap.data()['name'],
      email: snap.data()['email'],
      contact: snap.data()['contact'],
      type: snap.data()['type'],
      country: snap.data()['country'],
      capacity: snap.data()['capacity'],
    );
  }

  Future addCorporate(CorporateModel model) async {
    try {
      await usersRef.doc(uid).set({
        'name': model.name,
        'type': model.type,
        'address': model.address,
        'country': model.country,
        'contact': model.contact,
        'hrManager': model.hrManager,
        'employees': model.employees,
        'email': model.email,
        'user': 'corp'
      });
    } catch (e) {
      print(e);
    }
  }

  Future addHospital(HospitalModel model) async {
    try {
      await usersRef.doc(uid).set({
        'id': uid,
        'name': model.name,
        'type': model.type,
        'address': model.address,
        'country': model.country,
        'contact': model.contact,
        'capacity': model.capacity,
        'email': model.email,
        'user': 'hosp'
      });
      hospitalRef.doc(uid).set({
        'id': uid,
        'name': model.name,
        'type': model.type,
        'address': model.address,
        'country': model.country,
        'contact': model.contact,
        'capacity': model.capacity,
        'email': model.email,
      });
    } catch (e) {
      print(e);
    }
  }

  Future addEmployee(EmployeeModel model) async {
    try {
      await usersRef.doc(uid).set({
        'name': model.name,
        'address': model.address,
        'contact': model.contact,
        'email': model.email,
        'department': model.department,
        'company': model.company,
        'cid': model.cid,
        'user': 'emp',
      });
      await usersRef.doc(model.cid).collection('Employees').doc(uid).set({
        'name': model.name,
        'address': model.address,
        'contact': model.contact,
        'email': model.email,
        'department': model.department,
        'company': model.company,
        'cid': model.cid,
      });
    } catch (e) {
      print(e);
    }
  }

  Future setCurrentPolicy(PolicyModel model) async {
    try {
      await usersRef.doc(uid).collection('Policy').doc('policy').set({
        'id': model.id,
        'claimLimit': model.claimLimit,
        'term': model.term,
        'details': model.details,
      });
    } catch (e) {
      print(e);
    }
  }

  Future addPolicy(PolicyModel model) async {
    try {
      DocumentReference docRef = await policyRef.add({
        'claimLimit': model.claimLimit,
        'term': model.term,
        'details': model.details,
      });
      await docRef.set({'id': docRef.id}, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }

  Future addClaims(ClaimsModel model) async {
    try {
      DocumentReference docRef =
          await usersRef.doc(uid).collection('Claims').add({
        'name': model.name,
        'hospital': model.hospital,
        'claimAmount': model.claimAmount,
        'details': model.details,
        'claimLimit': model.claimLimit,
        'company': model.company,
        'cid': model.cid,
        'eid': model.eid,
        'hid': model.hid,
        'pid': model.pid,
      });
      await docRef.update({'id': docRef.id});
      await usersRef.doc(model.hid).collection('Claims').doc(docRef.id).set({
        'id': docRef.id,
        'name': model.name,
        'hospital': model.hospital,
        'claimAmount': model.claimAmount,
        'details': model.details,
        'claimLimit': model.claimLimit,
        'company': model.company,
        'cid': model.cid,
        'eid': model.eid,
        'hid': model.hid,
        'pid': model.pid,
      });
      await usersRef.doc(model.cid).collection('Claims').doc(docRef.id).set({
        'id': docRef.id,
        'name': model.name,
        'hospital': model.hospital,
        'claimAmount': model.claimAmount,
        'details': model.details,
        'claimLimit': model.claimLimit,
        'company': model.company,
        'cid': model.cid,
        'eid': model.eid,
        'hid': model.hid,
        'pid': model.pid,
      });
    } catch (e) {
      print(e);
    }
  }
/*
  Future updateCorpData(CorporateModel model) async {
    try {
      await healthInsuranceCollection.doc(uid).update({
        'name': model.name,
        'type': model.type,
        'address': model.address,
        'state': model.state,
        'country': model.country,
        'hrManager': model.hrManager,
        'scale': model.scale,
        'numEmployees': model.numEmployees
      });
    } catch (e) {
      print(e);
    }
  }

  Future setPolData(PolicyModel model) async {
    try {
      await healthInsuranceCollection
          .doc(uid)
          .collection('Policy')
          .doc('policy')
          .set({
        'name': model.name,
        'policyID': model.policyID,
        'claimLimit': model.claimLimit,
        'term': model.term,
        'details': model.details,
      });
    } catch (e) {
      print(e);
    }
  }

  Future addCorpData(CorporateModel model) async {
    try {
      await healthInsuranceCollection.doc(uid).set({
        'name': model.name,
        'type': model.type,
        'address': model.address,
        'state': model.state,
        'country': model.country,
        'hrManager': model.hrManager,
        'scale': model.scale,
        'numEmployees': model.numEmployees,
        'userType': 'corp'
      });
    } catch (e) {
      print(e);
    }
  }

  Future addPolData(PolicyModel model) async {
    try {
      await policyCollection.add({
        'name': model.name,
        'policyID': model.policyID,
        'claimLimit': model.claimLimit,
        'term': model.term,
        'details': model.details,
      });
    } catch (e) {
      print(e);
    }
  }

  Future addEmpData(EmployeeModel model) async {
    try {
      await healthInsuranceCollection.doc(uid).collection('Employees').add({
        'name': model.name,
        'address': model.address,
        'contact': model.contact,
        'email': model.email,
        'department': model.department,
      });
    } catch (e) {
      print(e);
    }
  }

  Future updateHospData(HospitalModel model) async {
    try {
      await healthInsuranceCollection.doc(uid).update({
        'name': model.name,
        'type': model.type,
        'address': model.address,
        'state': model.state,
        'country': model.country,
        'scale': model.scale,
        'capacity': model.capacity
      });
    } catch (e) {
      print(e);
    }
  }

  Future addHospData(HospitalModel model) async {
    try {
      await usersRef.doc(uid).set({
        'name': model.name,
        'type': model.type,
        'address': model.address,
        'state': model.state,
        'country': model.country,
        'scale': model.scale,
        'capacity': model.capacity,
        'userType': 'hosp'
      });
    } catch (e) {
      print(e);
    }
  }*/
}
