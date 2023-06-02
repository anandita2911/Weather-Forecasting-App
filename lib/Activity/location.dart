import 'package:flutter/material.dart';
import 'package:weather/Worker/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather_icons/weather_icons.dart';


class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}



class _LocationState extends State<Location> {
  String temp = "";
  String hum = "";
  String air_speed = "";
  String des = "";
  String main = "";
  String icon = "";
  String city = "";

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      List<Placemark> placemarks =
      await placemarkFromCoordinates(
          position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        city = placemark.locality ?? "";
      } else {
        city = "Unknown";
      }

      startApp(city);
    } catch (e) {
      print("Error: $e");
      city = "Unknown";
      startApp(city);
    }
  }

  void startApp(String city) async {
    worker instance = worker(location: city);
    await instance.getData();
    temp = instance.temp;
    hum = instance.humidity;
    air_speed = instance.air_speed;
    des = instance.description;
    main = instance.main;
    icon = instance.icon;

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        "temp_value": temp,
        "hum_value": hum,
        "air_speed": air_speed,
        "main_value": main,
        "des_value": des,
        "icon_value": icon,
        "city_value": city,
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Location Page'),),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
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

                              Column(
                                children: [
                                  Text(
                                    "$des",
                                    style: TextStyle(
                                        fontSize: 22, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "In $city",
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
                                Text("$air_speed", style:TextStyle(
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
                          Navigator.pushNamed(context, "/home");
                        },
                        child: Text(
                          'Home page',
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




    );
  }
}
