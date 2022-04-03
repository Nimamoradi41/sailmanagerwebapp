// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:sailmanagerwebapp/Screens/MainMap.dart';
import 'package:sailmanagerwebapp/Screens/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget {



  // final camerainit=CameraPosition(target: LatLng(31.351838, 48.673007));
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {




  Future Runn  ()async{
    // print('text.toString()');
    var text = await rootBundle.loadString('AddressFolder/address.txt');
    print(text.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var base =prefs.getString('Baseurl');
    var UserName =prefs.getString('UserName');
    var Password =prefs.getString('Password');

    if(UserName!=null &&   UserName.isNotEmpty)
    {
      setState(() {
        Flag=false;
      });
    }

  }

  var Flag=true;
  @override
  void initState()  {
    super.initState();
    Runn();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'iransans'
      ),
      // home:mainpage()
      home:   Flag ? mainpage():  MainMap()
      // home:MainMap()
    );
  }
}


