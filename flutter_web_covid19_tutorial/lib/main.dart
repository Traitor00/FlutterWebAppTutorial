import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MobileViewHomePage());
}

class MobileViewHomePage extends StatefulWidget {
  @override
  _MobileViewHomePageState createState() => _MobileViewHomePageState();
}

class _MobileViewHomePageState extends State<MobileViewHomePage> {
  String url = 'https://www.hpb.health.gov.lk/api/get-current-statistical';
  var data,
      hosData,
      horiBlockSize,
      vertiBlockSize,
      textMul,
      imgRad = 50.0,
      textSize = 14.0,
      hightChange = 200.0,
      appBarIconSize = 50.0,
      appBarTextSize = 10.0;

  String hospital_name;

  @override
  void initState() {
    super.initState();
    this.getJSONdata();
  }

  Future<String> getJSONdata() async {
    var response = await http.get(url);
    setState(() {
      var jsonFile = jsonDecode(response.body);
      data = jsonFile['data'];
    });
    return "Success";
  }

  void doSizeChanges() {
    if (textMul < 3.4) {
      imgRad = 30.0;
      textSize = 9.0;
      hightChange = 155.0;
    } else {
      imgRad = 50.0;
      textSize = 14.0;
      hightChange = 200.0;
    }
    if (textMul > 7.85) {
      appBarIconSize = 50;
      appBarTextSize = 20;
    } else if (textMul > 4) {
      appBarIconSize = 40;
      appBarTextSize = 20;
    } else {
      appBarTextSize = 14;
    }
    if (textMul < 2.9) {
      appBarIconSize = 30;
    }
  }

  Expanded countBoxes(var imgName, var title, var count) {
    return Expanded(
      child: Container(
        height: hightChange,
        width: 200,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 20,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: imgRad,
                  backgroundColor: Colors.white,
                  child: Image(
                    image: AssetImage(imgName),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: textSize,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  count,
                  style: TextStyle(
                    fontSize: textSize + 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrain) {
        horiBlockSize = constrain.maxWidth / 100;
        vertiBlockSize = constrain.maxHeight / 100;
        textMul = horiBlockSize;
        doSizeChanges();
        return OrientationBuilder(builder: (context, orientation) {
          return MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Center(
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                            image: AssetImage('logoicon.JPG'),
                            height: appBarIconSize,
                            width: appBarIconSize,
                          ),
                          Text(
                            'Covid19 Dashboard',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: appBarTextSize,
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                //physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Last Updated ${data['update_date_time']}',
                        style: TextStyle(
                          fontSize: textSize + 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Daily Updates [ LOCAL ]',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: textSize + 5,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              countBoxes('newcases.JPG', 'New Cases',
                                  '${data['local_new_cases']}'),
                              countBoxes('pulse.JPG', 'Deaths',
                                  '${data['local_new_deaths']}'),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Total Updates [ LOCAL ]',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: textSize + 5,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              countBoxes('activecases.JPG', 'Total Active',
                                  '${data['local_active_cases']}'),
                              countBoxes('totalcase.JPG', 'Total Recorded',
                                  '${data['local_total_cases']}'),
                              countBoxes('pulse.JPG', 'Total Deaths',
                                  '${data['local_deaths']}'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              countBoxes('cure.JPG', 'Recovered',
                                  '${data['local_recovered']}'),
                              countBoxes('sus.JPG', 'Suspected & Hospitalized',
                                  '${data['local_total_number_of_individuals_in_hospitals']}')
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Global Updates',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: textSize + 5,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              countBoxes('newcases.JPG', 'New Cases',
                                  '${data['global_new_cases']}'),
                              countBoxes('activecases.JPG', 'Total Cases',
                                  '${data['global_total_cases']}'),
                              countBoxes('pulse.JPG', 'Total Deaths',
                                  '${data['global_deaths']}'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              countBoxes('pulse.JPG', 'New Deaths',
                                  '${data['global_new_deaths']}'),
                              countBoxes('cure.JPG', 'Recovered',
                                  '${data['global_recovered']}'),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
