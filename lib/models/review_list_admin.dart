import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewList extends StatefulWidget {
  _View createState() => _View();
}

class _View extends State<ReviewList> {
  List<String> model;

  Widget build(BuildContext context) {
    model = Provider.of<List<String>>(context) ?? [];

    return Expanded(
      child: ListView.builder(
        itemCount: model.length * 2,
        itemBuilder: _listElement,
        shrinkWrap: true,
      ),
    );
  }

  Widget _listElement(BuildContext context, int index) {
    if (index.isOdd) return Divider();
    int idx = index ~/ 2;
    return _element(model[idx]);
  }

  Widget _element(String model) {
    return SizedBox(
        height: 50.0,
        width: 300.0,
        child: ListTile(
          title: Text('Review: $model'),
        ));
  }
}
