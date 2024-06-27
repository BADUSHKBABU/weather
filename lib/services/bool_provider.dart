import 'package:flutter/cupertino.dart';

class BoolProvider extends ChangeNotifier
{
  bool? _isSearch;
  bool? get isSerach=>_isSearch;
  void IsSearch(bool value)
  {
    _isSearch=!value;
    print("valiue is :$_isSearch");
    notifyListeners();
  }
}