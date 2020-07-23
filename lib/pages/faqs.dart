import 'package:covid19app/data_source.dart';
import 'package:flutter/material.dart';

class FAQ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQs'),
      ),
      body: ListView.builder(
        itemCount: DataSource.questionAnswers.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(
              DataSource.questionAnswers[index]['question'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: <Widget>[
              Text(
                DataSource.questionAnswers[index]['answer'],
              ),
            ],
          );
        },
      ),
    );
  }
}
