import 'package:flutter/material.dart';
import 'package:weather/Worker/worker.dart';

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

  void startApp() async{
    worker instance = worker(location: "Indore");
    await instance.getData();
    temp=instance.temp;
    hum=instance.humidity;
    air_speed=instance.air_speed;
    des= instance.description;
    main= instance.main;
    Navigator.pushReplacementNamed(context, '/home', arguments:{
      "temp_value": temp,
      "hum_value": hum,
      "air_speed": des,
      "main_value": main,
      "des_value": des,
    });


  }

  @override
  void initState(){
    startApp();
       super.initState();

  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: <Widget>[
          TextButton.icon(onPressed: (){
            Navigator.pushNamed(context,"/home");

          }, icon: Icon(Icons.add_to_home_screen), label : Text("Loading"))
        ],),
      ),
    );
  }
}
