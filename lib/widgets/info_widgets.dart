import 'package:covid19app/data_source.dart';
import 'package:covid19app/pages/faqs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: <Widget>[
          Buttons(
            text: "FAQs",
            check: false,
            widget: FAQ(),
          ),
          SizedBox(
            height: 10.0,
          ),
          Buttons(
            text: "DONATE (open WHO website)",
            urlString: "https://covid19responsefund.org/en/",
          ),
          SizedBox(
            height: 10.0,
          ),
          FittedBox(
            child: Buttons(
              text: "MYTH BUSTERS (rumors busted)",
              urlString:
                  "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public/myth-busters",
            ),
          ),
        ],
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  final bool check;
  final String text;
  final StatelessWidget widget;
  final String urlString;
  Buttons({this.text, this.urlString, this.check = true, this.widget});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: check == true
          ? () {
              launch(urlString);
            }
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return widget;
                }),
              );
            },
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          color: primaryBlack,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
