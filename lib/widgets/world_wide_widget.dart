import 'package:flutter/material.dart';

class WorldWideWidget extends StatelessWidget {
  final Map worldData;

  WorldWideWidget({this.worldData});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2),
        children: <Widget>[
          StatusPanel(
            title: "CONFIRMED",
            textColor: Colors.deepOrange,
            colorPanel: Colors.blue.withOpacity(.3),
            count: worldData['cases'].toString(),
          ),
          StatusPanel(
            title: "ACTIVE",
            textColor: Colors.black54,
            colorPanel: Colors.grey.withOpacity(.3),
            count: worldData['active'].toString(),
          ),
          StatusPanel(
            title: "RECOVERED",
            textColor: Colors.green,
            colorPanel: Colors.amberAccent.withOpacity(.3),
            count: worldData['recovered'].toString(),
          ),
          StatusPanel(
            title: "DEATHS",
            textColor: Colors.deepPurple,
            colorPanel: Colors.red,
            count: worldData['deaths'].toString(),
          ),
        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {
  final Color colorPanel;
  final Color textColor;
  final String title;
  final String count;

  StatusPanel({this.colorPanel, this.textColor, this.title, this.count});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(7),
      color: colorPanel,
      height: 80,
      width: width / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: textColor,
            ),
          ),
          Text(
            count,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
