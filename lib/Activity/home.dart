import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:http/http.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/Worker/worker.dart';




class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {




  TextEditingController searchController=new TextEditingController();
  @override
  void initState() {
    super.initState();
    print("This is a init state");
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var city_name = [
      "Mumbai",
      "Delhi",
      "Banglore",
      "Chennai",
      "Dhar",
      "Indore",
      "London"
    ];
    final _random = new Random();
    var city = city_name[_random.nextInt(city_name.length)];
    Map info = ModalRoute.of(context)?.settings.arguments as Map;
    String temp = '';
    String air = '';

    if (info['temp_value'].toString().length >= 4) {
      temp = info['temp_value'].toString().substring(0, 4);
    } else {
      temp = info['temp_value'].toString();
    }

    if (info['air_speed'].toString().length >= 4) {
      air = info['air_speed'].toString().substring(0, 4);
    } else {
      air = info['air_speed'].toString();
    }

    String icon = info['icon_value'];
    String getcity= info['city_value'];
    String hum= info['hum_value'];
    String des=info['des_value'];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [
                    0.1,
                    0.9
                  ],
                  colors: [
                    Colors.blue.shade700,
                    Colors.blue.shade200,
                  ]),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24)),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if((searchController.text).replaceAll(" ", "") ==""){
                            print("Blank Search");
                          }
                          else{
                            Navigator.pushNamed(context, "/loading", arguments: {
                              "searchText": searchController.text,
                            });
                          }

                        },
                        child: Container(
                          child: Icon(
                            Icons.search,
                            color: Colors.lightBlue,
                          ),
                          margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search $city",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5)),
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        padding: EdgeInsets.all(26),
                        child: Row(
                          children: [
                            Image.network("https://openweathermap.org/img/wn/$icon@2x.png"),
                            SizedBox(width:20,) ,
                            Column(
                              children: [
                                Text(
                                  "$des",
                                  style: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "In $getcity",
                                  style: TextStyle(
                                      fontSize: 18,),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5)),
                        margin:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        padding: EdgeInsets.all(26),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                          [Icon(WeatherIcons.thermometer,),
                            SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("$temp", style: TextStyle(
                                    fontSize: 80
                                ),),
                                Text("C", style: TextStyle(
                                    fontSize: 30
                                ),)
                              ],
                            ),
                          ],

                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white.withOpacity(0.5)),
                          margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                          padding: EdgeInsets.all(26),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(WeatherIcons.day_windy),
                                ], ),
                              SizedBox(height: 20),
                              Text("$air", style:TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),),
                              Text("km/hr", style:TextStyle(
                                  fontSize: 15
                              ),)
                            ],
                          )),
                    ),
                    Expanded(
                      child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white.withOpacity(0.5)),
                          margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                          padding: EdgeInsets.all(26),
                          child:Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(WeatherIcons.humidity),
                                ], ),
                              SizedBox(height: 20),
                              Text("$hum", style:TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),),
                              Text("Percent", style:TextStyle(
                                  fontSize: 15
                              ),)
                            ],
                          )),
                    ),
                  ],
                ),
                SizedBox(height:20,),
          Container(
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/location");
              },
              child: Text(
                'Live Location',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ))
              ],
            ),
          ),
          
        ),
      ),

    );
  }
}