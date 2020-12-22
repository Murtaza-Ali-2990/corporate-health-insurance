import 'package:corporate_health_insurance/models/claims_model.dart';
import 'package:corporate_health_insurance/utils/decor.dart';
import 'package:corporate_health_insurance/views/model_views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClaimsList extends StatefulWidget {
  _View createState() => _View();
}

class _View extends State<ClaimsList> {
  List<ClaimsModel> model;

  Widget build(BuildContext context) {
    model = Provider.of<List<ClaimsModel>>(context) ?? [];
    if (model.isEmpty) return MiniHeadingStyle('No Claims Available');

    return Expanded(
      child: ListView.builder(
        itemCount: model.length,
        itemBuilder: (context, index) => ClaimsView(model[index]),
        shrinkWrap: true,
      ),
    );
  }
}
