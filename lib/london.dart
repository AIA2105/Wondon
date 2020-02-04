import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:london/data.dart';
import 'package:london/restart.dart';


class London extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return LondonStatue();
  }
}

class LondonStatue extends State<London>{

  TextEditingController cityController = new TextEditingController();

  void refresh(){

          //Data().getData();
          //url2.isEmpty;
          //LondonStatue();
          //RestartWidget.restartApp(context);
  }

  void change(){
    setState(() {
        if (temp=='${temp1.round()}°K'){temp='${(temp1.round()- 273)}°C'; weather=temp;}
        else if (temp=='${(temp1.round()- 273)}°C'){temp='${(temp1*(9/5)-459.67).round()}°F'; weather=temp;}
        else if (temp=='${(temp1*(9/5)-459.67).round()}°F'){temp='${temp1.round()}°K'; weather=temp;}
    });
  }

  void search(){
    //setState(() async {
    if(cityController.text.isNotEmpty){
      url2=cityController.text.trim();
      print(url2);
      Data().getData2(url2);
      Navigator.pop(context);
      cityController.clear();
    }
      //});
  }

  Future<dynamic> select(){
    if(url2.isEmpty){return  Data().getData();}else{return  Data().getData2(url2);}
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate=formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd,' •••• ',HH, ':', nn, ':', ss]);
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.pink,
        title: new Text('Weather'),
        leading: new Icon(Icons.ac_unit),
        actions: <Widget>[
          //new IconButton(icon: new Icon(Icons.refresh), onPressed: refresh),
          new IconButton(icon: new Icon(Icons.error_outline), onPressed: (){showDialog<String>(
              context: context,
              builder: (BuildContext context)=> SimpleDialog(
                title: new Text('Info',style: TextStyle(color:Colors.pink),),
                children: <Widget>[
                  new Container(
                    child: Text('By, Ahmed Al-Mahallawey\nAPI, openweathermap'
                        '\n\nNote: Click on temperature to change in between cellulitis , fehrenhite and kelvin '),
                    padding: EdgeInsets.all(10),
                  ),

                ],
              )

          );}),

          new IconButton(icon: new Icon(Icons.search), onPressed: (){showDialog<String>(
              context: context,
              builder: (BuildContext context)=> SimpleDialog(
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.all(10),
                    child:
                    new Column(
                      children: <Widget>[
                        new TextField(
                          style: TextStyle(color: Colors.pink),
                          controller: cityController ,
                          decoration: new InputDecoration(
                              labelText: 'Enter the city name',
                              suffixIcon: IconButton(icon:Icon(Icons.location_on,color: Colors.pink,),onPressed:search,)
                          ),
                        ),
                        //new IconButton(icon: Icon(Icons.location_on), /*onPressed: newCity(cityController.text.trim())*/)
                      ],
                    )
                  ),

                ],
              )

          );}),

        ],
    ),

      body: FutureBuilder(
        future: select(),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          //if(!snapshot.hasData){return Center(child: new Text('Loading'),);}
          return new ListView(children: <Widget>[
            new Container(
              //padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: new Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  new Image.asset('Images/london.jpg',
                    fit: BoxFit.fill,
                  ),
                  new Card(
                    color: Colors.transparent,
                    margin:EdgeInsets.all(50) ,
                    child: new Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        new Image.asset('Images/mostlysunny.gif',),
                        new Padding(padding: EdgeInsets.only(top: 20)),

                        new Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text(city, style: TextStyle(fontSize: 30, color: Colors.white,),),
                            new Text(icon,style: TextStyle(fontSize:30),),

                          ],
                        ),
                        new Divider(color: Colors.white,height: 5,indent: 60,endIndent: 60,),
                        new Text(description, style: TextStyle(fontSize: 17, color: Colors.white,),),

                        GestureDetector(
                          onTap: () {change(); },
                          child: new Text(weather, style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold,color: Colors.pink,fontStyle: FontStyle.italic,),),
                        ),


                        new Row(mainAxisAlignment: MainAxisAlignment.start,children: <Widget>[
                          new Text('• Pressure : ', style: TextStyle(fontSize: 20, color: Colors.pink,)),
                          new Text(pressure, style: TextStyle(fontSize: 20, color: Colors.white,),),
                        ]),

                        new Row(mainAxisAlignment: MainAxisAlignment.start,children: <Widget>[
                          new Text('• Sea level : ', style: TextStyle(fontSize: 20, color: Colors.pink,)),
                          new Text(seaLevel, style: TextStyle(fontSize: 20, color: Colors.white,),),
                        ]),

                        new Row(mainAxisAlignment: MainAxisAlignment.start,children: <Widget>[
                          new Text('• Humidity : ', style: TextStyle(fontSize: 20, color: Colors.pink,)),
                          new Text(humidity, style: TextStyle(fontSize: 20, color: Colors.white,),),
                        ]),

                        new Divider(color: Colors.white,height: 25),

                        new Row(mainAxisAlignment: MainAxisAlignment.end,children: <Widget>[
                          new Text('• Wind Degree : ', style: TextStyle(fontSize: 20, color: Colors.pink,)),
                          new Text(windDegree, style: TextStyle(fontSize: 20, color: Colors.white,),),
                        ]),

                        new Row(mainAxisAlignment: MainAxisAlignment.end,children: <Widget>[
                          new Text('• Wind Speed : ', style: TextStyle(fontSize: 20, color: Colors.pink,)),
                          new Text(windSpeed, style: TextStyle(fontSize: 20, color: Colors.white,),),
                        ]),

                        new Row(mainAxisAlignment: MainAxisAlignment.end,children: <Widget>[
                          new Text('• Clouds : ', style: TextStyle(fontSize: 20, color: Colors.pink,)),
                          new Text(clouds, style: TextStyle(fontSize: 20, color: Colors.white,),),
                        ],),

                        new Divider(color: Colors.white,height: 20),
                        new Padding(padding: EdgeInsets.only(top: 10)),
                        new Text(formattedDate, style: TextStyle(fontSize: 15, color: Colors.yellow,),),
                        new Text(coordination, style: TextStyle(fontSize: 13, color: Colors.yellow,),),




                      ],
                    ),
                  )

                ],
              ),
            )

          ],
          );
        },
      ),

    );
  }
}
