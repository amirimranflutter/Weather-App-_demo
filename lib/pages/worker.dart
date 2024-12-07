import 'dart:convert';

import 'package:http/http.dart' as http;

class Worker{
  final key='8031a2987c4578ea828201f77706f203';
  String? location;
  Worker({this.location});

  String? temp;
  String? humidity;
  String? air_speed;
  String? description;
  String? icon;
Future <Map<String,dynamic>> fetchCurrentWeather(String location)async{
  final url= Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$key&units=metric");
  print(" url =$url");
  final response=await http.get(url);
  if(response.statusCode==200)

    {
      final Map<String,dynamic> weatherData=json.decode(response.body);
      print('Clouds ${weatherData['clouds']['all']} ');
      return{
        'icon':weatherData['weather'][0]['icon'],
        'temperature': weatherData['main']['temp'],
        'humidity': weatherData['main']['humidity'],
        'windSpeed': weatherData['wind']['speed'],
        'cloud': weatherData['clouds']['all'],
        'description': weatherData['weather'][0]['description'],
      };
    }else
      {
        throw Exception('Failed to load data');
      }

}
  Future <List<Map<String,dynamic>>> fetchFiveDayForecast(String location)async{
    final url= Uri.parse("https://api.openweathermap.org/data/2.5/forecast?q=$location&appid=$key&units=metric");
    final response=await http.get(url);
    if(response.statusCode==200)
    {
      final Map<String,dynamic> forecastData=json.decode(response.body);
      List <Map<String,dynamic>> forecastList= forecastData['list'].map<Map<String,dynamic>>((item){
      return{
        // 'icon':item['weather']['icon'],
        'icon':item['weather'][0]['icon'],
        'date': item['dt_txt'],
        'temperature': item['main']['temp'],
        'humidity': item['main']['humidity'],
        'windSpeed': item['wind']['speed'],
        'cloud': item['clouds']['all'],
        'description': item['weather'][0]['description'],
      };
      }).toList();
      return forecastList;
    }else
    {
      throw Exception('Failed to load data');
    }
}
}