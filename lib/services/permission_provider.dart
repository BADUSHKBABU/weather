import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/services/place_converter_service.dart';


///1, ask permissison
///2,get the location
///3.convert to place


class locationProvider extends ChangeNotifier {

  Position? _position_lattitude_longitude;
  Position? get position => _position_lattitude_longitude;


  //create instance of placeconverter class
  final PlaceConverterService _placeConverterService = PlaceConverterService();
  Placemark? _placemark;
  Placemark? get placemarker => _placemark;


  Future Getposition() async
  {
    bool service_enabled;
    LocationPermission? _permisssion;
    service_enabled = await Geolocator.isLocationServiceEnabled();

    ///checking whether location enabled
    if (!service_enabled) {
      _position_lattitude_longitude = null;
      notifyListeners();
      return;
    }
else {

      ///check the permission
      _permisssion = await Geolocator.checkPermission();
      if (_permisssion == LocationPermission.denied) {
        _permisssion = await Geolocator.requestPermission();
        if (_permisssion == LocationPermission.denied) {
          _position_lattitude_longitude = null;
          notifyListeners();
          return;
        }
        if (_permisssion == LocationPermission.deniedForever) {
          _position_lattitude_longitude = null;
          notifyListeners();
          return;
        }
      }
    }

        _position_lattitude_longitude = await Geolocator.getCurrentPosition();
        ///give current position as ltitude and as longitude
        print(_position_lattitude_longitude);
        notifyListeners();
        _placemark = await _placeConverterService.getPlace(_position_lattitude_longitude);
        notifyListeners();
        print("convertd  lati and longi is : $_placemark");


  }
}