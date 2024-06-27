import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class PlaceConverterService
{
  //function for convert longitude latitude to place
  //return Placemark
  Future<Placemark?> getPlace(Position? position) async{
    if(position!=null)
      {
        try{
        final _position= await placemarkFromCoordinates(position.latitude,position.longitude);
        if(_position.isNotEmpty)
          {
            return _position[0];
          }
      }
      catch(e)
      {
        print("error in finding place");
      }
return null;
      }
  }
}