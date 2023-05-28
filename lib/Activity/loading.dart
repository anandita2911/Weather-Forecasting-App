import 'package:flutter/material.dart';
import 'package:weather/Worker/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String temp="";
  String hum="";
  String air_speed="";
  String des="";
  String main="";
  String icon="";
  String city="Indore";

  void startApp(String city) async{
    worker instance = worker(location: city);
    bool success = await instance.getData();
    if(success){
      temp=instance.temp;
      hum=instance.humidity;
      air_speed=instance.air_speed;
      des= instance.description;
      main= instance.main;
      icon= instance.icon;
    }
    else{
      print("Data Retrieval failed");
    }

    Future.delayed(Duration(seconds:3),(){
      Navigator.pushReplacementNamed(context, '/home', arguments:{
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
  void initState(){

       super.initState();

  }

  Widget build(BuildContext context) {
    Map? search =ModalRoute.of(context)?.settings.arguments as Map?;

    if (search != null && search.containsKey('searchText')) {
      city = search['searchText'];
    }

    startApp(city);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("images/logo-fotor-bg-remover-20230528165524.png", height:240,width:240),
            SizedBox(height:10),
            Text("Weather App",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w800,
                color:Colors.white
            ),),
            SizedBox(height: 15,),
            Text("Made by Anandita",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color:Colors.white
              ),),
            SizedBox(height: 30,),
        SpinKitSpinningLines(
          color: Colors.white,
          size: 60.0,
        ),

          ],
        )
      ),
      backgroundColor: Colors.blue[300],
    );
  }
}
