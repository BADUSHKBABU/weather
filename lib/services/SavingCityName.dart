import 'package:flutter/cupertino.dart';

class Savingcityname extends ChangeNotifier
{
  var _CityName="";
   get CityName=> _CityName;
   void CitynamePassing(var city)
   {
     _CityName=city;
     notifyListeners();
   }

}