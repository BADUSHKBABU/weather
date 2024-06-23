import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weatherapp/services/permission_provider.dart';
import 'package:weatherapp/services/weatherProvider.dart';

import 'screen/home.dart';

void main() {
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>locationProvider()),
      ChangeNotifierProvider(create: (_)=>Weatherprovider()),
    ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
            useMaterial3: true,
          ),
          home:home()
      ),
    );
  }
}
