



import 'package:chan_1_weather_1_2/pages/currentweather.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main(){
  runApp(MaterialApp(
   initialRoute: '/',
    routes: {
     "/":(context)=>WeatherPage(city: 'Madina'
         ),
    },
  ));
}
