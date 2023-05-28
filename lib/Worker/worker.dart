import 'package:http/http.dart';
import 'dart:convert';
class worker{
  var location;

  //constructor
  worker({this.location}){  //named parameter
    location=this.location;
  }

  String temp="";
  String humidity="";
  String air_speed="";
  String description="";
  String main="";

  //method=
  Future<void> getData() async {

    try{
      Response response = await get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=d08abd9b588d61bd9aa97abbe1ff47c3"));
      Map data = jsonDecode(response.body);

      //getting temp,humidity
      Map temp_data = data['main'];
      var getHumidity=temp_data['humidity'];
      var getTemp = temp_data['temp']-273.15;

      //wind properties
      Map wind=data['wind'];
      var getAir_speed=wind["speed"];

      //getting description
      List weather_data=data['weather'];
      Map weather_main_data= weather_data[0];
      String getMain_des=weather_main_data['main'];
      String getDesc = weather_main_data["description"];


      //assigning
      temp=getTemp.toString();
      humidity=getHumidity.toString();
      air_speed=getAir_speed.toString();
      description=getDesc;
      main= getMain_des;
    } catch(e)
    {
      temp="Can't find data ";
      humidity="Can't find data ";
      air_speed="Can't find data ";
      description="Can't find data ";
      main="Can't find data ";

    }

  }
}