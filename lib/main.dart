// @dart=2.9
import 'package:flutter/material.dart';

import 'package:sailmanagerwebapp/Screens/MainMap.dart';
import 'package:sailmanagerwebapp/Screens/mainpage.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // final camerainit=CameraPosition(target: LatLng(31.351838, 48.673007));
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'iransans'
      ),
      // home:mainpage()
      home:MainMap()
      // home:MainMap()
    );
  }
}


