import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/services/permission_provider.dart';

import '../services/weatherProvider.dart';


class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  void initState() {
    Provider.of<locationProvider>(context,listen: false).Getposition();
    Provider.of<Weatherprovider>(context,listen: false).weatherFetchingByCityName("thodupuzha");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    locationProvider _provider=Provider.of<locationProvider>(context);
    var _currentLocation;
    if(_provider.placemarker==null)
      {
        return Center(child: Container(height:50,width:50,child: CircularProgressIndicator()));
      }
    else{
      _currentLocation=_provider.placemarker!.name;
    }

    Size _size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Container(width: _size.width,
            height: _size.height,
            decoration: BoxDecoration(image: DecorationImage(fit:BoxFit.cover,image: AssetImage("assets/bg/bluebg.jpg"))),
            child: Consumer<locationProvider>(builder: (ctx,_provider,_){return  Column(mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  child: Row(
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.location_on,color: Colors.red,)),
                      Text("$_currentLocation",style: TextStyle(color: Colors.red),),
                      SizedBox(width: 200,),
                      Expanded(child: IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.red,)))
                    ],
                  ),
                ),
                SizedBox(height: 100,),
                Center(child: CircleAvatar(maxRadius: 100,child: Image.asset(fit: BoxFit.scaleDown,"assets/bg/bg.jpg"))),
                Center(child: Text("21 c",style: TextStyle(color: Colors.red,fontSize: 30),))
              ],
            );},

            ),
          )
      ),
    );
  }
}
