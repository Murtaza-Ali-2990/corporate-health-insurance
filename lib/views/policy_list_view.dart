import 'package:corporate_health_insurance/models/policy_model.dart';
import 'package:corporate_health_insurance/utils/decor.dart';
import 'package:corporate_health_insurance/views/model_views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PolicyList extends StatefulWidget {
  final type;
  PolicyList({this.type});

  _View createState() => _View(type: type);
}

class _View extends State<PolicyList> {
  List<PolicyModel> model;

  final String type;
  _View({this.type});

  Widget build(BuildContext context) {
    model = Provider.of<List<PolicyModel>>(context) ?? [];
    if (model.isEmpty) return MiniHeadingStyle('No Available Policy');

    return Expanded(
      child: ListView.builder(
        itemCount: model.length,
        itemBuilder: (context, index) => PolicyView(model[index], type),
        shrinkWrap: true,
      ),
    );
  }
}
