import 'package:corporate_health_insurance/models/hospital_model.dart';
import 'package:corporate_health_insurance/utils/decor.dart';
import 'package:corporate_health_insurance/views/model_views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HospitalList extends StatefulWidget {
  _View createState() => _View();
}

class _View extends State<HospitalList> {
  List<HospitalModel> model;

  Widget build(BuildContext context) {
    model = Provider.of<List<HospitalModel>>(context) ?? [];
    if (model.isEmpty) return MiniHeadingStyle('No Hospitals Available');

    return Expanded(
      child: ListView.builder(
        itemCount: model.length,
        itemBuilder: (context, index) => HospitalView(model[index]),
        shrinkWrap: true,
      ),
    );
  }
}
