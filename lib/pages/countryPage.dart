import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List countryData;
  fetchCountryData() async {
    http.Response response =
        await http.get("https://disease.sh/v3/covid-19/countries");
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCountryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text("Country Stats"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: null);
            },
          ),
        ],
      ),
      body: countryData == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: countryData == null ? 0 : countryData.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 150.0,
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.cyan.withOpacity(.3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[100],
                        blurRadius: 5,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              countryData[index]['country'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Image.network(
                              countryData[index]['countryInfo']['flag'],
                              height: 80,
                              width: 80,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 50.0,
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "CONFIRMED: ${countryData[index]['cases']}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(
                                height: 2.0,
                              ),
                              Text(
                                "ACTIVE: ${countryData[index]['active']}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                height: 2.0,
                              ),
                              Text(
                                "RECOVERED: ${countryData[index]['recovered']}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(
                                height: 2.0,
                              ),
                              Text(
                                "DEATHS: ${countryData[index]['deaths']}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
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
