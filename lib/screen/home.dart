import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/services/permission_provider.dart';

import '../data/images.dart';
import '../services/weatherProvider.dart';


class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  bool isPressedSearch=false;
  TextEditingController searchController=TextEditingController();
  late var CityName;
  DateTime? date;
   String formateddatetime="";
  @override
  void initState() {
    date=DateTime.now();
    formateddatetime=DateFormat('yyyy-MM-dd  kk:mm').format(date!);
 final Locationprovider=Provider.of<locationProvider>(context,listen: false);
 Locationprovider.Getposition().then((_){
   if(Locationprovider.placemarker!=null){//checking converted place list is present or not..latlog coverted to place list conatin all the details about the latlog
      var CityName=Locationprovider.placemarker!.name;
     if(CityName!=null)
     {
       Provider.of<Weatherprovider>(context,listen: false).weatherFetchingByCityName(CityName);
     }
   }
 });
// Provider.of<locationProvider>(context,listen: false).Getposition();
 //Provider.of<Weatherprovider>(context,listen: false).weatherFetchingByCityName("kochi");
    super.initState();
  }
  @override
  void dispose() {
    Provider.of<locationProvider>(context,listen: false).Getposition();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    Size _size=MediaQuery.of(context).size;
    return Scaffold(
      //appBar: AppBar(forceMaterialTransparency:true),
      body: SingleChildScrollView(
          child: Consumer<Weatherprovider>(builder: (ctx,_weather,_){
            var backgroundImage=imagePath[_weather.weather?.weather[0].main];
            var temperature=_weather.weather?.main.temp;
            var weatherConfdition=_weather.weather?.weather[0].main;
            return  SafeArea(
              child: Container(width: _size.width,
                height: _size.height,
                decoration: BoxDecoration(image: DecorationImage(fit:temperature==null?BoxFit.contain:BoxFit.cover
                    ,image: AssetImage(background[_weather.weather?.weather[0].main]??"assets/img/nointernet3.gif"))),
                child:
                // if(_provider.placemarker!=null)
                //   {
                //     _currentLocationName=_provider.placemarker!.name;
                //     Provider.of<Weatherprovider>(context,).weatherFetchingByCityName("$_currentLocationName");
                //     _currentLocationSublocality=_provider.placemarker!.subLocality;
                //   }
                // else
                //   {
                //     _currentLocationSublocality="unknown";
                //     Provider.of<Weatherprovider>(context,).weatherFetchingByCityName("$_currentLocationName");
                //   }
                Column(mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      child: Row(
                        children: [
                          IconButton(onPressed: (){
                          }, icon: Icon(Icons.location_on,color: Colors.red,)),
                          Container(
                              child: Consumer<locationProvider>(builder: (ctx,provider,_){
                                return   Column(mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(provider.placemarker?.name??"na",style: TextStyle(color: Colors.white),textAlign: TextAlign.start,),
                                  Text(provider.placemarker?.subLocality??"na",style: TextStyle(color: Colors.white),textAlign: TextAlign.start,),
                                ],
                              ); },

                              )),

                          //check whether serachicon pressed or not
                          SizedBox(width: 150,),

                          IconButton(onPressed: (){
                            setState(() {
                              isPressedSearch=!isPressedSearch;
                            });
                          },
                              icon: Icon(Icons.search,color: Colors.red,))
                        ],
                      ),
                    ),

                    SizedBox(height: 50,),
                    isPressedSearch? Center(child: Container(width:200,decoration:BoxDecoration(color: Colors.white10),child:
                    Row(
                      children: [
                        Expanded(child: TextFormField(
                          controller: searchController,
                        )),
                        Expanded(child: IconButton(onPressed: (){
                         searchController!=null? _weather.weatherFetchingByCityName(searchController.text.trim()):_weather.weather?.main.temp;
                        }, icon: Icon(Icons.search)))
                      ],
                    ),
                    )):SizedBox(width: 150,),
                     Center(child: backgroundImage!=null?Image.asset(backgroundImage,fit: BoxFit.cover,):Text("please enable GPS and Internet...!")),

                    SizedBox(height: 30,),
                    Consumer<locationProvider>(
                      builder: (ctx,_location,_){

                        return Center(child: Column(
                          children: [
                            Text(_location.placemarker?.subLocality??"",style: TextStyle(color: Colors.white,fontSize: 30)),
                            Text(temperature!=null?"${temperature}°C".toString():"",style: TextStyle(color: temperature!=null?Colors.white:Colors.black,fontSize: 30)),
                            Text(weatherConfdition??"na",style: TextStyle(color: Colors.white,fontSize: 20)),
                            Text("${formateddatetime}",style: TextStyle(color: temperature!=null?Colors.white:Colors.black),),
                          ],
                        ));
                      },
                    )
                  ],
                )

                        ),
            );},

          )
      ),
    );
  }
}







