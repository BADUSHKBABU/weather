import 'dart:convert';

import 'package:flutter/widgets.dart';

import '../model/weather_model.dart';
import '../secrets/api_key.dart';
import '../secrets/base_url.dart';
import 'package:http/http.dart'as http;

class Weatherprovider extends ChangeNotifier{
//https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
  Weather? _weather;//model class
  Weather? get weather=>_weather;
  bool _isLoading=false;  //loading
bool get isLoading =>_isLoading;
 String error="";

Future<void> weatherFetchingByCityName(String city) async
{
  _isLoading=true;
  error="";
 try
     {
       final url="${ApiEndpoints().base_city_url}${city}${ApiEndpoints().appId}${ApiKey}";
       final response=await http.get(Uri.parse(url));
       if(response.statusCode==200)
       {
         final data=jsonDecode(response.body);
         print(data);//write logic
         _weather= Weather.fromJson(data);//convert coming json file to dart
         notifyListeners();
       }
       else
       {
         error="failed to load data";
         notifyListeners();
       }
     }
     catch(e)
  {
    error="failed to load data : $e";
  }
  finally{
   _isLoading=false;
   notifyListeners();
  }

}



}