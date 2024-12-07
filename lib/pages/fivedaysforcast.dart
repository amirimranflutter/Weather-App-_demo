
import 'package:chan_1_weather_1_2/pages/worker.dart';
import 'package:chan_1_weather_1_2/text_style/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_icons/weather_icons.dart';

class FiveDayForecastPage extends StatefulWidget {
  final String city;

  const FiveDayForecastPage({Key? key, required this.city}) : super(key: key);

  @override
  _FiveDayForecastPageState createState() => _FiveDayForecastPageState();
}

class _FiveDayForecastPageState extends State<FiveDayForecastPage> {
  final Worker weatherService = Worker();
  List<Map<String, dynamic>>? forecastData;
  Map<String, dynamic>? currentWeather;

  @override
  void initState() {
    super.initState();
    _loadForecast();

  }


  void _loadForecast() async {
    final data = await weatherService.fetchFiveDayForecast(widget.city);
    setState(() {
      forecastData = data;
      if (data.isNotEmpty) {
        // Set initial current weather to the first forecast entry
        currentWeather = data[0];
        // print("icon :$currentWeather['icon']");
      }
    });
  }

  void _updateCurrentWeather(Map<String, dynamic> selectedWeather) {
    setState(() {
      currentWeather = selectedWeather;
    });
  }

  String _extractDay(String? fullDate) {
    if (fullDate != null) {
      return fullDate.split('-')[2].split(' ')[0]; // Extract the day part
    }
    return ''; // Return empty if null
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000A18),
      appBar: AppBar(
        title: Text('5-Day Forecast for ${widget.city}'),
        backgroundColor: const Color(0xff1370F3),
      ),
      body: forecastData == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          // Current Weather Display (Top half)
          if (currentWeather != null)
            SingleChildScrollView(
              child: Container(
                // width: MediaQuery.of(context).size.width,
                height: 200,
                // height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff2F98EC),
                      blurRadius: 1,
                      spreadRadius: 2,
                    ),
                  ],
                  border: Border.all(width: 2, color: Color(0xff2F98EC)),
                  borderRadius: BorderRadius.only(
                    // bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff11ACFE),
                      Color(0xff1370F3),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _extractDay(currentWeather!['date']),
                      style: TextStyles.headingText                  ),
                    Center(
                      child: Row(
                        children: [
                          Container(
                            width: 130, // Set your desired width
                            height: 130, // Set your desired height
                            decoration: BoxDecoration(
                              shape: BoxShape.circle, // If you want to make it circular
                            ),
                            child: Image.network(
                              "https://openweathermap.org/img/wn/${currentWeather!['icon']}@2x.png",
                              fit: BoxFit.cover, // This ensures the image fits the container
                            ),
                          ),
                          Column(
                            children: [
                              SingleChildScrollView(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 68, // Main text size
                                      color: Color(0xffFDFDFD), // Text color
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '${(currentWeather!['temperature'] as double).toStringAsFixed(0)} ', // Main temperature text
                                        style: TextStyles.alteraheadingText, // Bold for the temperature
                                      ),
                                      TextSpan(
                                        text: ' °C', // Unit text

                                        style: TextStyles.subheadingText,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                '${currentWeather!['description']}',
                                style: TextStyles.subheadingText,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Color.fromRGBO(255, 255, 255, 0.7), // Color of the divider
                      thickness: 1, // Thickness of the divider line
                      indent: 20, // Indent from the left
                      endIndent: 20, // Indent from the right
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Icon(WeatherIcons.humidity, color: Colors.white),
                              Text('Humidity', style: TextStyles.normalText),
                              Text('${currentWeather!['humidity']}%', style: TextStyles.normalText),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Icon(WeatherIcons.day_windy, color: Colors.white),
                              Text('Wind Speed', style: TextStyles.normalText),
                              Text('${currentWeather!['windSpeed']} ', style: TextStyles.normalText),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Icon(WeatherIcons.cloud, color: Colors.white),
                              Text('Cloud  ', style: TextStyles.normalText),
                              Text('${currentWeather!['cloud']} ', style: TextStyles.normalText),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          SizedBox(height: 10),
          // 5-Day Forecast (Horizontally scrollable)
          Expanded(
            child: Container(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: forecastData!.length,
                itemBuilder: (context, index) {
                  final item = forecastData![index];

                  return GestureDetector(
                    onTap: () {
                      _updateCurrentWeather(item);
                    },
                    child: Container(
                      width: 120,
                      height: 30,
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff11ACFE),
                            Color(0xff1370F3),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff2F98EC),
                            blurRadius: 1,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              _extractDay(item['date']),
                              style: TextStyles.normalText,
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: Text(
                              ' ${(item['temperature']as double).toStringAsFixed(0)} °C',
                              style: TextStyles.subheadingText,
                            ),
                          ),
                          SizedBox(height: 20,),
                          Image.network(
                            "https://openweathermap.org/img/wn/${item['icon']}@2x.png",
                            // Weather icon
                            width: 70, // Set desired width for the icon
                            height: 70, // Set desired height for the icon
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
