import 'package:flutter/material.dart';
import 'package:weather/Activity/home.dart';
import 'package:weather/Activity/loading.dart';
import 'package:weather/Activity/location.dart';
void main() {
  runApp(MaterialApp(
    home: Loading(),
    routes: {
      "/home" : (context) => Home(),
      "/loading" :(context) => Loading(),
    },
  ));
}

