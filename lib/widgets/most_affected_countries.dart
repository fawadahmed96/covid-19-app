import 'package:flutter/material.dart';

class MostAffectedWidget extends StatelessWidget {
  final List countryData;

  MostAffectedWidget({this.countryData});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(left: 20.0),
            child: Row(
              children: <Widget>[
                Container(
                  child: Image.network(
                    countryData[index]['countryInfo']['flag'],
                    height: 40.0,
                    width: 40.0,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  countryData[index]['country'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "Deaths : ${countryData[index]['deaths'].toString()}",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
