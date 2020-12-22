import 'package:corporate_health_insurance/models/employee_model.dart';
import 'package:corporate_health_insurance/utils/decor.dart';
import 'package:corporate_health_insurance/views/model_views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeList extends StatefulWidget {
  _View createState() => _View();
}

class _View extends State<EmployeeList> {
  List<EmployeeModel> model;

  Widget build(BuildContext context) {
    model = Provider.of<List<EmployeeModel>>(context) ?? [];
    if (model.isEmpty) return MiniHeadingStyle('No Employees Available');

    return Expanded(
      child: ListView.builder(
        itemCount: model.length,
        itemBuilder: (context, index) => EmployeeView(model[index]),
        shrinkWrap: true,
      ),
    );
  }
}
