import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:weatherapp/services/bool_provider.dart';
import 'package:weatherapp/services/permission_provider.dart';

import '../services/weatherProvider.dart';


class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  bool isPressedSearch=false;
  TextEditingController searchController=TextEditingController();
  var _currentLocationSublocality;
  var _currentLocationName;
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
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Container(width: _size.width,
            height: _size.height,
            decoration: BoxDecoration(image: DecorationImage(fit:BoxFit.cover,image: AssetImage("assets/bg/bluebg.jpg"))),
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
                          child: Consumer<locationProvider>(builder: (ctx,provider,_){return   Column(mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${provider.placemarker!.name}",style: TextStyle(color: Colors.red),textAlign: TextAlign.start,),
                              Text("${provider.placemarker!.subLocality}",style: TextStyle(color: Colors.red),textAlign: TextAlign.start,),
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
                      ],
                    ),
                  )):SizedBox(width: 150,),
                Center(child: CircleAvatar(maxRadius: 100,child: Image.asset(fit: BoxFit.scaleDown,"assets/seasons/clouds.png"))),
                SizedBox(height: 30,),
                Consumer<Weatherprovider>(
                  builder: (ctx,_weatherprovider,_){

                    return Center(child: Column(
                      children: [
                        Text("${_weatherprovider.weather}°C",style: TextStyle(color: Colors.red,fontSize: 30)),
                        //Text("${_currenthum}",style: TextStyle(color: Colors.red,fontSize: 30)),
                        Text("${formateddatetime}"),
                                ],
                    ));
                  },
                )
              ],
            )

          )
      ),
    );
  }
}
