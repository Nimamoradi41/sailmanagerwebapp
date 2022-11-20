

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';


import 'dart:ui'as ui;

import '../Constants.dart';
import '../Models/ModelVisitorsReport.dart';
import '../TextApp.dart';
class PopulationData {
  int year;
  int population;
  charts.Color barColor;
  PopulationData({
    required this.year,
    required this.population,
    required this.barColor
  });
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
class ScreenChartLine extends StatefulWidget {

  List<TotalVisitorSale> datachart = [];




  List<PopulationData> data_2 = [];


  ScreenChartLine(this.datachart);

  bool Ori=false;



  @override
  _ScreenChartLineState createState() => _ScreenChartLineState();
}

class _ScreenChartLineState extends State<ScreenChartLine> {
  List<LinearSales> data = [];
  void Update() {

    setState(() {
      widget.datachart.forEach((element) {
        widget.data_2.add(PopulationData(
            year: element.visID,
            population: element.Nprice.toInt(),
            barColor: charts.ColorUtil.fromDartColor(element.Nprice.toString().contains('-')?Color_Manfi:Color_Mosbat)
        ));
      });

    });
  }
  List<charts.Series<LinearSales, int>> _createSampleData() {
    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
  _getSeriesData() {
    List<charts.Series<PopulationData, String>> series = [
      charts.Series(
          id: "Grades",
          data: widget.data_2,
          domainFn: (PopulationData series, _) => series.year.toString(),
          measureFn: (PopulationData series, _) => series.population,
          colorFn: (PopulationData series, _) => series.barColor
      )
    ];
    return series;
  }
   bool FlAG=false;
  static ShowSnackbar(String Msg){
    Fluttertoast.showToast(
        msg: Msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.black,
        backgroundColor: Colors.white,
        fontSize: 16.0
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Update();
  }




  Future  SaveANShare(Uint8List byts) async{
  final Direc=await getApplicationDocumentsDirectory();
  final image=File(Direc.path+'/'+'flutter.png');
  image.writeAsBytesSync(byts);
  final text='Share';
  await Share.shareFiles([image.path],text: text);

  }

  Future GetCap()async{


    if (await Permission.storage.request().isGranted)   {

      final res=  await Cont.capture();
      await SaveANShare(res!);
      // Share.shareFiles([res.path]);

      if(res==null)
        {


        return;

        }else{
    // await SaveANShare(res);

      // if(ss.isNotEmpty)
      // {
      //   ShowSnackbar('عکس از نمودار با موفقیت انجام شد');
      // }


      // print(ss.toString());
      }


    }else{


      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();


    }



  }



  Future<String> SaveImage(Uint8List byts)async{
    if (await Permission.storage.request().isGranted) {
      print('A');
      final time=DateTime.now()
      .toIso8601String()
      .replaceAll('.','-')
      .replaceAll(':','-');

      final name='ScreenShote%$time';
      final ress= await ImageGallerySaver.saveImage(byts,name: name);
      setState(() {
        FlAG=false;
      });
      ShowSnackbar('عکس از نمودار با موفقیت انجام شد');
      return  ress['filePath'];
    }else{
      setState(() {
        FlAG=false;
      });
      print('B');
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
    }

// You can request multiple permissions at once.



  return '';


  }

  final Cont=ScreenshotController();


  GlobalKey cont_key=GlobalKey();

  void ConvertwidgetToImage()async{
    setState(() {
      FlAG=true;
    });
    try{
      RenderRepaintBoundary? renderRepaintBoundary=cont_key.currentContext!.findRenderObject() as RenderRepaintBoundary?;
      ui.Image boxImge=await renderRepaintBoundary!.toImage(pixelRatio: 1);
      ByteData? data=await boxImge.toByteData(format: ui.ImageByteFormat.png);
      Uint8List uint8list=data!.buffer.asUint8List();
      SaveImage(uint8list);
    }catch(E)
    {
      setState(() {
        FlAG=false;
      });
    }

  }
  bool Flagcolor=false;
  ShowInfoCustomer()
  {
    showDialog(context: context, builder: (CTX){
      return
        Container(
            width: double.infinity,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4,vertical: 32),
              child:   Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: [
                                  Expanded(flex: 3, child: TextApp('شناسه ویزیتور',12,Colors.grey,false)),
                                  Expanded(flex: 3,child: TextApp('نام ویزیتور',12,Colors.grey,false)),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8,right: 4,left: 4),
                              width: double.infinity,
                              height: 1,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: widget.datachart.length,
                                itemBuilder: (ctx,item){
                                  if(item==0)
                                  {
                                    Flagcolor=true;
                                  }

                                  Flagcolor=!Flagcolor;

                                  return   Container(
                                    decoration: BoxDecoration(
                                        color:  Flagcolor==false?Color(0xffEFF5F5):Color(0xffD6E4E5)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 2.0,vertical: 4),
                                      child: Row(
                                        children: [
                                          Expanded(flex: 3, child: TextApp(widget.datachart[item].visID.toString(),12,Colors.grey,false)),
                                          Expanded(flex: 3,child: TextApp(widget.datachart[item].visName.toString(),12,Colors.grey,false)),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )


                          ],
                        )
                    ),
                  ),

                ],
              ),

            ));

    });
  }

  @override
  Widget build(BuildContext context) {
    widget.Ori=MediaQuery.of(context).orientation==Orientation.portrait?false:true;
    return
      SafeArea(
      child: Screenshot(
        controller: Cont,
        child: RepaintBoundary(
          key: cont_key,
          child: Scaffold(
            appBar: AppBar(centerTitle: true,
                backgroundColor: BaseColor,
                actions: [
                  InkWell(
                    onTap: (){
                      ShowInfoCustomer();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.info_outline,color: Colors.white,),
                    ),
                  )
                ],
              title:Column(
                children: [
                  Text('آتیران ', textAlign: TextAlign.center),
                  Text(' نمودار ',style: TextStyle(fontSize: 10),textAlign: TextAlign.center,)
                ],
              )),
            body:
            FlAG==false?
            Column(
              children: [
                Expanded(
                  flex: 19,
                  child: buildContainer(),
                ),
                Expanded(
                    flex:widget.Ori==true?2:1 ,
                    child: Container(
                  width: double.infinity,
                    decoration: BoxDecoration(
                      color: BaseColor,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: ElevatedButton(

                              style: ElevatedButton.styleFrom(


                                  primary: Colors.white),
                              onPressed: (){}, child: GestureDetector(
                            onTap: (){
                              GetCap();
                            },
                                child: Text('اشتراک گذاری',
                          style: TextStyle(
                            fontSize: 10,
                            color: BaseColor
                          ),),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: ElevatedButton(

                              style: ElevatedButton.styleFrom(


                                  primary: Colors.white),
                              onPressed: (){}, child: GestureDetector(
                            onTap: (){
                              ConvertwidgetToImage();
                            },
                            child: Text('ذخیره',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: BaseColor
                              ),),
                          )),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Switch(value: widget.Ori,
                                  hoverColor: Colors.white,
                                  activeColor: Colors.white,
                                  focusColor: Colors.white,
                                  onChanged: (B){
                                   if(B)
                                     {
                                       SystemChrome.setPreferredOrientations([
                                         DeviceOrientation.landscapeLeft,
                                         DeviceOrientation.landscapeRight
                                       ]);
                                     }else{
                                     SystemChrome.setPreferredOrientations([
                                       DeviceOrientation.portraitUp,
                                       DeviceOrientation.portraitDown
                                     ]);
                                   }

                                    // setState(() {
                                    //   widget.Ori=B;
                                    // });

                                  }),
                              Expanded(child: Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Text('نمایش به صورت افقی',
                                  textAlign: TextAlign.end,
                                  style:TextStyle(color: Colors.white,fontSize: 12),),
                              )),
                            ],
                          ),
                        ),
                      ],
                    )))
              ],
            ):
            Container(
                color: Colors.white,
                child: Center(child: CircularProgressIndicator())),
          ),
        ),
      ),
    );

  }

  Container buildContainer() {
    return Container(
                color: Colors.white,
                margin: EdgeInsets.all(4),
                child: charts.BarChart(
                  _getSeriesData(),
                  animate: true,
                  domainAxis: charts.OrdinalAxisSpec(
                      showAxisLine: true,
                      renderSpec: charts.SmallTickRendererSpec(
                          labelRotation: 0, tickLengthPx: 0,
                          labelStyle:
                          charts.TextStyleSpec(fontSize: 8))
                  ),
                ),
              );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
  }
}
