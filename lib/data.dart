
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

///To be static for london.class
Map data={};
String temp="";
double temp1 =0;
String icon= '';
double lat=0;
double lon=0;
String url2 ='';

String city='Loading...';
String description='';
String weather='';
String pressure='';
String seaLevel='';
String humidity='';
String windDegree='';
String windSpeed='';
String clouds='';
String coordination='';


class Data{

  Future<dynamic> getData() async {
    try {
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
      lat=position.latitude;
      lon=position.longitude;

      http.Response response = await http.get('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=042bfb859e13315436faf371a61f48d8');
      data= json.decode(response.body);
      setData(data);
      print(data);
    } catch (e) {print(e);}
  }

  Future<dynamic> getData2(String city) async {
    try {

      http.Response response = await http.get('https://api.openweathermap.org/data/2.5/weather?q=$city,&appid=042bfb859e13315436faf371a61f48d8');
      data= json.decode(response.body);

      setData(data);
      print(data);
    } catch (e) {print(e);}
  }

  void setData(var data){
    temp1 = (data['main']['temp']); //k
    temp='${temp1.round()}°K';
    getWeatherIcon(temp1);
    city='${data['name']}, ${data['sys']['country']} ';
    description='${data['weather'][0]['description']}';
    weather='$temp';
    pressure='${data['main']['pressure']} mb';
    seaLevel='${data['main']['sea_level']/1000} km';
    humidity='${data['main']['humidity']}%';
    windDegree='${data['wind']['deg']}%';
    windSpeed='${data['wind']['speed']} km/h';
    clouds='${data['clouds']['all']} %';
    coordination='• coordination : (longitude: ${data['coord']['lon']} , latitude: ${data['coord']['lat']})';
    print(data);
  }


  void getWeatherIcon(double condition) {
    if (condition < 300) {
      icon= '🌩';
    } else if (condition < 400) {
      icon= '🌧';
    } else if (condition < 600) {
      icon= '☔️';
    } else if (condition < 700) {
      icon= '☃️';
    } else if (condition < 800) {
      icon= '🌫';
    } else if (condition == 800) {
      icon= '☀️';
    } else if (condition <= 804) {
      icon= '☁️';
    } else {
      icon= '🤷‍';
    }
  }





}