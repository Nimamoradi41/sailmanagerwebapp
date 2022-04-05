import 'dart:async';

import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map/plugin_api.dart';
// import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';


import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:latlong2/latlong.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';


// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sailmanagerwebapp/ApiService.dart';
import 'package:sailmanagerwebapp/Constants.dart';
import 'package:sailmanagerwebapp/DataBseFile.dart';
import 'package:sailmanagerwebapp/Models/ListCustomer.dart';
import 'package:sailmanagerwebapp/Models/ListPersonel.dart';
import 'package:sailmanagerwebapp/Models/OfflineModel.dart';
import 'package:sailmanagerwebapp/Models/OnlineModel.dart';
import 'package:sailmanagerwebapp/Screens/Personels.dart';
import 'package:sailmanagerwebapp/Screens/PishFactorNotAccept.dart';
import 'package:sailmanagerwebapp/Screens/PishFactorsAll.dart';
import 'package:sailmanagerwebapp/Screens/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';


import 'Customers.dart';





class MainMap extends StatefulWidget {
  const MainMap({Key? key}) : super(key: key);


  @override
  State<MainMap> createState() => _MainMapState();
}

enum TypeMap { normal, hybrid, terrain ,satellite}
class _MainMapState extends State<MainMap>   with WidgetsBindingObserver  {

  TypeMap _site = TypeMap.normal;

  bool TypeSwitch_Now=true;
  bool TypeSwitch_After=false;
  int group=1;
  List<RePerson> Customer_temps2 = <RePerson>[];
  List<RePerson> Customer = <RePerson>[];
  //     CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(31.319743, 48.677719),
  //   zoom: 13.4746,
  // );



  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
        Mcontrol.invalidateAmbientCache();
       setState(() {

       });
    }
  }



  ShowModall_()
  {
    showModalBottomSheet(context: context, builder: (ctx){
      return  Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back,size: 25,color: Color(0xff1F3C84),),
                  ),
                ),
                Expanded(
                  child: Card(

                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                        onChanged: (val){
                          if(val.isNotEmpty)
                          {
                            Customer.clear();
                            // val=val.replaceAll('ی','ي');
                            // val=val.replaceAll('ک','ك');
                            var data   =Customer_temps2.where((i) => i.name.contains(val)||i.visRdf.toString().contains(val.toString())||i.tell2.contains(val.toString())
                                ||i.tell1.contains(val)||i.cell.toString().contains(val)).toList();


                            setState(() {

                              if(data.length==0)
                              {
                                Customer.clear();
                              }
                            });
                          }else{

                            setState(() {
                              Customer.clear();
                            });

                          }
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            border: InputBorder.none,
                            hintStyle: TextStyle(

                                color: Color(0xff1F3C84).withOpacity(0.80)
                            ),
                            hintText: 'پرسنل خود را جستجو کنید...'
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        // itemCount: Customer_temps2.take(30).length,
                        itemCount: Customer.length>30?Customer.take(30).length:
                        Customer.length,
                        itemBuilder: (ctx,item){
                          return   InkWell(
                            onTap: (){
                              // final data = { "id" : Customer[item].id
                              //     .toString(), "name" : Customer[item].name.toString() };
                              // Navigator.pop(context,data);
                            },
                            child:  Card(
                              margin: EdgeInsets.all(8),
                              // child: DoubleRowMultyOne_Customer(
                              //   'موبایل','تلفن ثابت','نام مشتری','آدرس',
                              //   'assets/pngs/mobile_1.svg',
                              //   'assets/pngs/tel_1.svg',
                              //   'assets/pngs/ad_1.svg',
                              //   'assets/pngs/loccc.svg',
                              //   Customer_temps2[item].mobile,
                              //   Customer_temps2[item].tell1,
                              //   Customer_temps2[item].name,
                              //   Customer_temps2[item].address,
                              // ),
                            ),
                          );

                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ) ;
    });
  }






  ShowModall_setting()
  {
    showModalBottomSheet(context: context, builder: (ctx){
      return  Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child:
                  Container(
                  child:  Text('تنظیمات',
                    textAlign: TextAlign.end,
                    style: TextStyle(color:
                    BaseColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w100),),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.settings_rounded,size: 25,color: Color(0xff1F3C84),),
                  ),

                ],
              ),
              Divider(height: 10,color: ColorLine,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('نسخه 1.0.0',style: TextStyle(
                    color: BaseColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12
                  ),),
                  Expanded(child: Container(
                    child:  Text('حالت های نمایش نقشه',
                      textAlign: TextAlign.end,
                      style: TextStyle(color:
                      BaseColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w100),),
                  )),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.map,size: 25,color: Color(0xff1F3C84),),
                    ),
                  ),

                ],
              ),
              Divider(height: 10,color: ColorLine,),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(child:  Text('normal',
                        textAlign: TextAlign.end,
                        style: TextStyle(color:
                        BaseColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),),),
                      Radio(
                        value: TypeMap.normal,
                        groupValue: _site,
                        activeColor: BaseColor,
                        onChanged: (dynamic value) {
                          setState(() {
                            _site = value;
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child:  Text('hybrid',
                        textAlign: TextAlign.end,
                        style: TextStyle(color:
                        BaseColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),),),
                      Radio(
                        value: TypeMap.hybrid,
                        groupValue: _site,
                        activeColor: BaseColor,
                        onChanged: (dynamic value) {
                          setState(() {
                            _site = value;
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child:  Text('satellite',
                        textAlign: TextAlign.end,
                        style: TextStyle(color:
                        BaseColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),),),
                      Radio(
                        value: TypeMap.satellite,
                        groupValue: _site,
                        activeColor: BaseColor,
                        onChanged: (dynamic value) {
                          setState(() {
                            _site = value;
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child:  Text('terrain',
                        textAlign: TextAlign.end,
                        style: TextStyle(color:
                        BaseColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),),),
                      Radio(
                        value: TypeMap.terrain,
                        groupValue: _site,
                        activeColor: BaseColor,
                        onChanged: (dynamic value) {
                          setState(() {
                            _site = value;
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ) ;
    });
  }


  ShowModall_Date(String Da)
  {
    print(Da);
    showModalBottomSheet(context: context, builder: (ctx){
      return  Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(Da==null?'نامشخص':Da,
                    textAlign: TextAlign.end,
                    style: TextStyle(color:
                    BaseColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w100),),
                  Text(': زمان و تاریخ موقعیت ',
                    textAlign: TextAlign.end,
                    style: TextStyle(color:
                    BaseColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w100),),
                ],
              ),
            ],
          ),
        ),
      ) ;
    });
  }


  ShowModall_MainMenu()
  {
    showModalBottomSheet(context: context, builder: (ctx){
      return  Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Customers()));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Container(
                      child:  Text('لیست مشتریان',
                        textAlign: TextAlign.end,
                        style: TextStyle(color:
                        BaseColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w100),),
                    )),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset('images/admin2.svg',width: 20,height: 20,color: Color(0xff1F3C84),),
                      ),
                    ),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(height: 10,color: ColorLine,),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context)
                              => PishFactorsAll()));
                    },
                    child: Container(
                      child:  Text('لیست پیش فاکتور ها(همه)',
                        textAlign: TextAlign.end,
                        style: TextStyle(color:
                        BaseColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w100),),
                    ),
                  )),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset('images/list_4.svg',width: 15,height: 15,color: Color(0xff1F3C84),),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ) ;
    });
  }





  List<LatLng>_Markers=[];
  //
  // late GoogleMapController controller2;
  //
  // Set<Polyline> _poly=Set<Polyline>();
  //
  // List<LatLng> _cordinate=[];
  List<LatLng> Polygons=[];



  late RePerson myperson;
  // late Marker myperson_Markre;
  late RePerson myperson2;


  late PolylinePoints polylinePoints;
  // late BitmapDescriptor pinLocationIcon;


  // void Setm() async{
  //   pinLocationIcon= await BitmapDescriptor.fromAssetImage(
  //       ImageConfiguration(devicePixelRatio: 5),
  //       'images/locpng.png');
  // }
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: Align(
            alignment: Alignment.topRight,
            child: Text('مجوز',textAlign: TextAlign.right,)),
        content:
        SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const <Widget>[
                Text('برای خروج از فرم اطمینان دارید?',textAlign: TextAlign.end,),
              ],
            ),
          ),
        )
        ,
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child:  Text('نه',style: TextStyle(fontSize: 16)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child:  Text('بله',style: TextStyle(fontSize: 16),),
          ),
        ],
      ),
    )) ?? false;
  }

  Future<bool> _onWillPop_exit() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: Align(
            alignment: Alignment.topRight,
            child: Text('مجوز',textAlign: TextAlign.right,)),
        content:
        SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const <Widget>[
                Text('آیا می خواهید از حساب کاربری خود خارج شوید؟',textAlign: TextAlign.end,),
              ],
            ),
          ),
        )
        ,
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child:  Text('نه',style: TextStyle(fontSize: 16)),
          ),
          TextButton(
            onPressed: () async{
              SharedPreferences prefs2 = await SharedPreferences.getInstance();
              await  prefs2.clear();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => mainpage()),
                // MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false,
              );
            },
            child:  Text('بله',style: TextStyle(fontSize: 16),),
          ),
        ],
      ),
    )) ?? false;
  }
  late Timer _timer;
  updateMarkers() {
    _timer = Timer.periodic(Duration(seconds: 15), (timer) {
      if(TypeSwitch_Now)
      {
        GetAll();
      }

    });
  }


  // late BitmapDescriptor markerbitmap;
  // late BitmapDescriptor markerbitmap2;
  Future GetAll()async{
    //   markerbitmap = await BitmapDescriptor.fromAssetImage(
    //   ImageConfiguration(),
    //   "images/loc_1.png",
    // );



    var markerImage = await loadMarkerImage();
    Mcontrol.addImage('marker', markerImage);



      // markerbitmap2 = await BitmapDescriptor.fromAssetImage(
      //   ImageConfiguration(),
      //   "images/niman.png",
      //   // "images/locloc2.png",
      // );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var base =prefs.getString('Baseurl');
    var UserName =prefs.getString('UserName');
    var Password =prefs.getString('Password');
    var data=    await   ApiService.
    GetPerson( base.toString(), UserName!, Password!);
    // var data=    await   ApiService.GetPerson( 'http://91.108.148.38:9595/manager', 'نیما', '1');
    print(data.toString());
    if(data.code==200)
      {
        if(data.res.length>0)
          {
            Customer_temps2=data.res;
            // _Markers.clear();
            // _poly.clear();

            _Markers.clear();
            Mcontrol.clearSymbols();
            Mcontrol.clearLines();

            // _cordinate.clear();
           data.res.forEach((element) {
             if(element.lat!=null&&element.lat!=0)
               {
                 _Markers.add(LatLng(element.lat,element.lng));
                  Mcontrol.addSymbol(SymbolOptions(
                     iconSize: 0.2,
                     iconImage: "marker",
                    textHaloColor: element.datetime,
                     // iconImage: "assets/locloc2.png",
                     geometry: LatLng(element.lat,element.lng),
                      ));
               }
            });

           setState((){});
          }
      }







    if(TypeSwitch_Now)
      {

        print('Data iS herre');
        if(myperson.visRdf!=-9)
        {
          print('Data iS herre2');
          var markerImage = await loadMarkerImage2();
          Mcontrol.addImage('marker', markerImage);

          // Mcontrol=sd;

          Mcontrol.addImage('marker', markerImage);
          Mcontrol.addSymbol(SymbolOptions(
            iconSize: 0.2,
            iconImage: "marker",
            textHaloColor:myperson.datetime ,
            // iconImage: "assets/locloc2.png",
            geometry: LatLng(myperson.lat,myperson.lng),
          ));
          // myperson_Markre=Marker(
          //     markerId:MarkerId('MarkId'+myperson.lat.toString()+myperson.lng.toString()),
          //     icon: markerbitmap2,
          //     position: LatLng(myperson.lat,myperson.lng),
          //     infoWindow: InfoWindow(
          //         title: myperson.name,
          //         snippet: myperson.datetime,
          //     )
          // );
          _Markers.add(LatLng(myperson.lat,myperson.lng));


          setState(() {
          });
        }
      }else{
      myperson.visRdf=-9;
      setState(() {

      });
    }

  }
  // MapController mycontroler=MapController();


  // Future<Uint8List> getBytesFromAsset(String path, int width) async {
  //   ByteData data = await rootBundle.load(path);
  //   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  // }





  @override
  void initState()   {
    super.initState();
    myperson=RePerson(
      lng: 0, lat: 0, tell1: '', tell2: '', datetime: '',
      visRdf: -9, name: '', cell: '',);
    // polylinePoints=PolylinePoints();


    // GetAll();

    // final Uint8List markerIcon = await getBytesFromAsset('images/locloc2.png', 100);














    // updateMarkers();
    // Setm();
    // Setm();ad


  }






  @override
  void dispose() {

    super.dispose();

  }




  late MapboxMap _map;


  Future<Uint8List> loadMarkerImage() async {
    var byteData = await rootBundle.load("images/loc_1.png");
    return byteData.buffer.asUint8List();
  }


  Future<Uint8List> loadMarkerImage2() async {
    var byteData = await rootBundle.load("images/niman.png");
    return byteData.buffer.asUint8List();
  }



  // late MapController Mcontrol;
  late MapboxMapController Mcontrol;

  void _Oncreatmap(MapboxMapController s)
  {
    Mcontrol=s;
    Mcontrol.invalidateAmbientCache();

  }


  aFunction(Symbol symbol){
    print(symbol.data);
    print(symbol.options.geometry);
    print(symbol.options.textHaloColor);
    print(symbol.id);
    ShowModall_Date(symbol.options.textHaloColor.toString().trim());
    // code goes here
  }

  void addCirc(MapboxMapController sd)  async
  {
    // sd.addCircle(CircleOptions(
    //   geometry: LatLng(31.331725, 48.686134),
    //   circleColor: '#23d2aa',
    //   circleRadius: 15
    // ));
    var markerImage = await loadMarkerImage();
    sd.addImage('marker', markerImage);

     Mcontrol=sd;


     Mcontrol.onSymbolTapped.add(aFunction);


    // textHaloColor: '1400/05/12 14:30:30',


    GetAll();

    updateMarkers();









  }








  var Flag_map=false;
  @override
  Widget build(BuildContext context) {
    var Sizewid=MediaQuery.of(context).size.width;
    var Sizewid2=MediaQuery.of(context).size;
    print(Sizewid.toString());
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: Sizewid2.height,
              width: Sizewid2.width,
                child:
                    MapboxMap(
                  accessToken: 'pk.eyJ1IjoibmltYTE2IiwiYSI6ImNsMGR0M2dwMDBjOXEzY3Bzc2I4MWVrdG0ifQ.h5z0leQwUb4QE04yjUPiCA',
                  // accessToken: 'https://api.mapbox.com/styles/v1/nima16/cl0f23lg2001f14o2e1ji391d/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibmltYTE2IiwiYSI6ImNsMGR0M2dwMDBjOXEzY3Bzc2I4MWVrdG0ifQ.h5z0leQwUb4QE04yjUPiCA',
                  onMapCreated: _Oncreatmap,
                  // styleString: 'mapbox://styles/nima16/cl0f23lg2001f14o2e1ji391d',
                  onStyleLoadedCallback:()=>addCirc(Mcontrol) ,
                  onMapClick:(a,b) async {
                    print(b.toString());
                  },
                  initialCameraPosition: CameraPosition(
                      target: LatLng(31.330587,48.684865),
                      zoom: 12,
                  ),
                )
            ),
            Positioned(

                top: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32,horizontal: 6),
                  child: Row(
              children: [
                 BtnSmall2('images/logout.png',18,Colors.white,(){
                   _onWillPop_exit();
                 }),
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: Sizewid>796?MainAxisAlignment.end:MainAxisAlignment.center,
                        children: [
                          buildContainer(Sizewid),
                        ],
                      ),
                    ),
                  )
              ],
            ),
                )),

            Positioned(
           bottom: 0,
           left: 0,
           right: 0,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              children: [
                BtnSmall2('images/list.png',18,Colors.white, (){
                  ShowModall_MainMenu();
                }),
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child:  BtnSmall2('images/menu1.png',18,Colors.white,(){
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context)
                            => PishFactorNotAccept()));
                  }),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: Sizewid>796?Sizewid/4:Sizewid<=450?Sizewid/2:Sizewid/2,
                        margin: EdgeInsets.only(left: 6),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 3,
                                  spreadRadius: 1
                              )
                            ],
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(child: Container(
                              child: InkWell(
                                onTap: () async{
                                  var resuilt=await    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => Personels(TypeSwitch_Now,Customer_temps2)));
                                  if(TypeSwitch_Now)
                                    {
                                      print('TypeSwitch_Now'+ 'Is True');
                                      if(resuilt!=null)
                                      {
                                        print('2302020202020200');
                                        if(myperson.visRdf!=-9)
                                          {
                                            // _Markers.remove(myperson_Markre);
                                          }
                                        // _Markers.clear();
                                        var markerImage = await loadMarkerImage2();
                                        Mcontrol.addImage('marker', markerImage);
                                        myperson=resuilt;
                                        print(myperson.lat.toString());
                                        // _poly.clear();
                                        // _cordinate.clear();
                                        Polygons.clear();
                                        _Markers.clear();
                                        Mcontrol.clearSymbols();
                                        Mcontrol.clearLines();
                                        if(myperson.lat>0)
                                          {
                                            Mcontrol.addSymbol(SymbolOptions(
                                              iconSize: 0.2,
                                              iconImage: "marker",
                                              textHaloColor:myperson.datetime ,
                                              // iconImage: "assets/locloc2.png",
                                              geometry: LatLng(myperson.lat,myperson.lng),
                                            ));
                                            // var newPosition = CameraPosition(
                                            //     target: LatLng(myperson.lat,myperson.lng),
                                            //     zoom: 16);
                                            // CameraUpdate update =CameraUpdate.newCameraPosition(newPosition);
                                            // controller2.moveCamera(update);
                                            // myperson_Markre=Marker(
                                            //     markerId:MarkerId(myperson.lat.toString()),
                                            //     icon: markerbitmap2,
                                            //     position: LatLng(myperson.lat,myperson.lng),
                                            //     infoWindow: InfoWindow(
                                            //         title: myperson.name,
                                            //         snippet: myperson.datetime
                                            //     )
                                            // );
                                            // _Markers.add(myperson_Markre);
                                            setState(() {
                                            });
                                          }


                                      }
                                    }else{
                                    print('TypeSwitch_Now'+ 'Is False');
                                     print('HI');
                                     if(resuilt!=null)
                                     {
                                       print('565656565655');
                                       print(resuilt.toString());
                                       // _Markers.clear();
                                       // _poly.clear();
                                       // _cordinate.clear();
                                       setState(() {

                                       });
                                       List<Latlng1> d=resuilt ;

                                       if(d!=null)
                                       {
                                         if(d.length>0)
                                           {
                                             var markerImage = await loadMarkerImage();
                                             Mcontrol.addImage('marker', markerImage);
                                             print('Size Is '+d.length.toString());
                                             Polygons.clear();
                                             _Markers.clear();
                                             Mcontrol.clearSymbols();
                                             Mcontrol.clearLines();

                                             d.forEach((element) {
                                              _Markers.add(LatLng(element.lat, element.lng));
                                             });


                                             Mcontrol.addLine(
                                               LineOptions(
                                                   geometry: _Markers,
                                                   lineColor: "#FF1818",
                                                   lineWidth: 2.0,
                                                   draggable: true),
                                             );
                                             d.forEach((element)
                                             {
                                               Mcontrol.addSymbol(SymbolOptions(
                                                 iconSize: 0.2,
                                                 iconImage: "marker",
                                                 textHaloColor: element.datetime,
                                                 // iconImage: "assets/locloc2.png",
                                                 geometry: LatLng(element.lat,element.lng),
                                               ));
                                             });

                                             // CameraUpdate update =CameraUpdate.newCameraPosition(newPosition);
                                             // controller2.moveCamera(update);
                                             setState(() {

                                             });

                                           }
                                       }
                                     }
                                  }
                                },
                                child: TextField(
                                  enabled: false,
                                  autofocus: false,
                                  textAlign: TextAlign.end,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffBEBEBE),
                                        fontSize:Sizewid<=409?10: 12,
                                      ),
                                      hintText: 'پرسنل خود را جستجو کنید'
                                  ),
                                ),
                              ),
                            )),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Icon(Icons.search,color: Color(0xffCACACA),size: 24,),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
          ],
        ),
      ),
    );
  }





















  Container buildContainer(double Siz) {
    return Container(
                  width: Siz>796?Siz/3:Siz/1.5,
                  margin: EdgeInsets.symmetric(horizontal: 32),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 3,
                            spreadRadius: 1
                        )
                      ],
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Row(
                    children: [
                      Expanded(child: InkWell(
                        onTap: (){
                          if(!TypeSwitch_After)
                          {
                            setState(() {
                              TypeSwitch_Now=false;
                              TypeSwitch_After=true;
                              _Markers.clear();
                              Mcontrol.clearLines();
                              Mcontrol.clearSymbols();
                              Polygons.clear();
                              myperson.visRdf=-9;
                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: BoxSwitch('تاریخچه موقعیت ها',TypeSwitch_After,Siz),
                        ),
                      )),
                      Expanded(child: InkWell(
                        onTap: (){
                            if(!TypeSwitch_Now)
                              {
                                setState(() {
                                  TypeSwitch_Now=true;
                                  TypeSwitch_After=false;
                                  _Markers.clear();
                                  Polygons.clear();
                                  Mcontrol.clearLines();
                                  Mcontrol.clearSymbols();
                                  // _poly.clear();
                                  // _cordinate.clear();
                                });
                              }

                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: BoxSwitch('موقعیت فعلی',TypeSwitch_Now,Siz),
                        ),
                      )),
                    ],
                  ),

                );
  }
}



 class TypingMap extends StatelessWidget {

  int i;
  int group;
  String Text1;


  TypingMap(this.i, this.Text1,this.group);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(Text1,
          textAlign: TextAlign.end,
          style: TextStyle(color:
          BaseColor,
              fontSize: 14,
              fontWeight: FontWeight.w100),),
        Radio(
          value: 1,
          groupValue:group ,
          onChanged: (T) {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
 class RowInfo extends StatelessWidget {
   IconData Icon2;

   String Title;


   RowInfo(this.Icon2, this.Title);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(Title,
              textAlign: TextAlign.end,
              style: TextStyle(color:
              BaseColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w100),),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icon2,color: BaseColor,),
        )
      ],
    );
  }
}
 class BoxSwitch extends StatelessWidget {
   String  Lable;
   bool Active;
   double wid;
   BoxSwitch(this.Lable,this.Active,this.wid);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:Active?  BoxDecoration(
          color: BaseColor,
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 3,
                spreadRadius: 1
            )
          ],
          borderRadius: BorderRadius.circular(8)
      ):BoxDecoration(),
      child: Padding(
        padding:  const EdgeInsets.only(bottom: 16.0,top: 16.0,right: 0,left: 0),
        child: Center(
          child: Text(Lable,
            style: TextStyle(color:Active?Colors.white:
            BaseColor,
                fontSize:wid<=409?10: 12,
                fontWeight: FontWeight.w100),),
        ),
      ),
    );
  }
}




 

 

class BtnSmall extends StatelessWidget {
  String Icon;

   double  Size;

   Color _colors;


  BtnSmall(this.Icon,this.Size,this._colors);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BaseColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child:
        Image.asset(Icon, color: _colors, width: Size, height: Size),
        // SvgPicture.asset(Icon, color:_colors,
        //   width: Size,height: Size,),
      ),
    );
  }
}


class BtnSmall2 extends StatelessWidget {
  String Icon;

  double  Size;

  Color _colors;


  final VoidCallback function;

  BtnSmall2(this.Icon,this.Size,this._colors,this.function);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: BaseColor,
      ),
       onPressed: function,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 12),
        child:
        Image.asset(Icon, color: _colors, width: Size, height: Size),
        // SvgPicture.asset(Icon, color:_colors,
        //   width: Size,height: Size,),
      ),
    );
  }
}


class BtnSmallText extends StatelessWidget {
  String Text1;


  BtnSmallText(this.Text1);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: (){},
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(BaseColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                )
            )
        ),
        child:Padding(
          padding: const EdgeInsets.only(bottom: 16.0,top: 16.0,right: 0,left: 0),
          child: Text(Text1,
            style: TextStyle(color:Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold),),
        ) );
  }
}
