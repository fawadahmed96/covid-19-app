import 'dart:convert';

import 'package:covid19app/pages/countryPage.dart';
import 'package:covid19app/widgets/info_widgets.dart';
import 'package:covid19app/widgets/most_affected_countries.dart';
import 'package:covid19app/widgets/world_wide_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:pie_chart/pie_chart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map worldData;
  String urlPath = "https://disease.sh/v3/covid-19/all";

  Future fetchData() async {
    fetchWorldWideData();
    fetchCountryData();
  }

  fetchWorldWideData() async {
    http.Response response = await http.get(urlPath);
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List countryData;
  fetchCountryData() async {
    http.Response response =
        await http.get("https://disease.sh/v3/covid-19/countries?sort=cases");
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Theme.of(context).brightness == Brightness.light
                  ? Icons.lightbulb_outline
                  : Icons.highlight),
              onPressed: () {
                DynamicTheme.of(context).setBrightness(
                    Theme.of(context).brightness == Brightness.light
                        ? Brightness.dark
                        : Brightness.light);
              })
        ],
        title: Text("Covid-19 TRACKER APP"),
      ),
      body: countryData == null && worldData == null
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: fetchData,
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        color: Colors.orangeAccent.withOpacity(.3),
                        height: MediaQuery.of(context).size.height / 7,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "\"Nothing inn life to be scared,it is only to be understood.Now is the time to understand more,so that we may fear less.\"",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.orange[800],
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Worldwide",
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return CountryPage();
                                }));
                              },
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "Regional",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      worldData == null
                          ? CircularProgressIndicator()
                          : WorldWideWidget(
                              worldData: worldData,
                            ),
                      SizedBox(
                        height: 15.0,
                      ),
                      PieChart(
                        dataMap: {
                          'Confirmed': worldData['cases'].toDouble(),
                          'Active': worldData['active'].toDouble(),
                          'Recovered': worldData['recovered'].toDouble(),
                          'deaths': worldData['deaths'].toDouble(),
                        },
                        colorList: [
                          Colors.blue,
                          Colors.grey,
                          Colors.yellow,
                          Colors.red,
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Most affected countries",
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      countryData == null
                          ? Container()
                          : MostAffectedWidget(
                              countryData: countryData,
                            ),
                      SizedBox(
                        height: 10.0,
                      ),
                      InfoWidget(),
                      SizedBox(
                        height: 30.0,
                      ),
                      Center(
                        child: Text(
                          "WE ARE TOGETHER IN THE FIGHT",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
