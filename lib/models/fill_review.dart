import 'package:corporate_health_insurance/services/database_service.dart';
import 'package:corporate_health_insurance/utils/decor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FillReview extends StatefulWidget {
  _F createState() => _F();
}

class _F extends State<FillReview> {
  String review;

  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 500,
      child: Column(
        children: [
          TextFormField(
            initialValue: review,
            decoration: textInputDecor.copyWith(hintText: 'Review'),
            onChanged: (value) => setState(() => review = value),
          ),
          SizedBox(height: 20),
          SizedBox(
              width: 150.0,
              height: 50.0,
              child: RaisedButton(
                child: Text('Add Review'),
                color: Color(0xFF20C9FF),
                textColor: Colors.white,
                onPressed: () async {
                  await DatabaseService().addReview(review);
                  setState(() {});
                  review = '';
                },
              )),
        ],
      ),
    );
  }
}
