
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

///To be static for london.class
Map data={};
String temp="";
double temp1 =0;
double lat=0;
double lon=0;

class Data{

  setData() async {
    data = await getData();
    temp1 = (data['main']['temp']); //k
    temp='${temp1.round()}°K';
  }

  Future<Map> getData() async {

    try {
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
      lat=position.latitude;
      lon=position.longitude;

    } catch (e) {print(e);}

    http.Response response = await http.get('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=042bfb859e13315436faf371a61f48d8');
    return json.decode(response.body);
  }




}


new IconButton(icon: new Icon(Icons.search), onPressed: (){showDialog<String>(
context: context,
builder: (BuildContext context)=> SimpleDialog(
//title: new Text('Enter city name'),
children: <Widget>[
new Container(
child: new Row(
children: <Widget>[
new TextField(
controller: cityController ,
decoration: new InputDecoration(
labelText: 'Enter the city name'
),
),
new IconButton(icon: Icon(Icons.location_on), onPressed: newCity(cityController.text.trim()))
],
)
),



],
)

)