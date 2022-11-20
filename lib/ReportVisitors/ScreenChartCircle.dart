import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

import 'package:syncfusion_flutter_charts/charts.dart';



import 'dart:ui'as ui;

import '../Constants.dart';
import '../Models/ModelVisitorsReport.dart';
import '../TextApp.dart';


class ScreenChartCircle extends StatefulWidget {

  List<TotalVisitorSale> datachart = [];




  ScreenChartCircle(this.datachart);


  @override
  ScreenChartCircleState createState() => ScreenChartCircleState();
}

class ScreenChartCircleState extends State<ScreenChartCircle> {


  late TooltipBehavior tooltipBehavior;



  int Sum=0;

  GlobalKey cont_key=GlobalKey();


  void Update() {
    setState(() {
      widget.datachart.forEach((element) {
        Sum=Sum+element.Nprice.toInt();
      });


    });

  }
  @override
  void initState() {
    tooltipBehavior=TooltipBehavior(enable: true);
    super.initState();
    Update();

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


  void ConvertwidgetToImage()async{
    setState(() {
      FlAG=true;
    });
    try{

      RenderRepaintBoundary renderRepaintBoundary=cont_key.currentContext?.findRenderObject() as RenderRepaintBoundary;

      ui.Image boxImge=await renderRepaintBoundary.toImage(pixelRatio: 1);

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
  final Cont=ScreenshotController();

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





   @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: Cont,
      child: RepaintBoundary(
        key: cont_key,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
                centerTitle: true,
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
                    Text(' نمودار ' ,style: TextStyle(fontSize: 10),textAlign: TextAlign.center,)
                  ],
                )),
            body:
            FlAG==false?
            Container(
              margin: EdgeInsets.all(4),
              child: Column(
                children: [
                  Expanded(
                    flex: 20,
                    child:Container(child: buildSfCircularChart()),
                  ),
                  // Expanded(
                  //     child: Container(
                  //         width: double.infinity,
                  //         decoration: BoxDecoration(
                  //
                  //         ),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //
                  //             Padding(
                  //               padding: const EdgeInsets.all(4),
                  //               child: ElevatedButton(
                  //
                  //                   style: ElevatedButton.styleFrom(
                  //
                  //
                  //                       primary: Colors.white),
                  //                   onPressed: (){}, child: GestureDetector(
                  //                 onTap: (){
                  //
                  //                   GetCap();
                  //                 },
                  //                 child: Text('اشتراک گذاری',
                  //                   style: TextStyle(
                  //                       fontSize: 10,
                  //                       color: BaseColor
                  //                   ),),
                  //               )),
                  //             ),
                  //             Padding(
                  //               padding: const EdgeInsets.all(4),
                  //               child: ElevatedButton(
                  //
                  //                   style: ElevatedButton.styleFrom(
                  //
                  //
                  //                       primary: Colors.white),
                  //                   onPressed: (){}, child: GestureDetector(
                  //                 onTap: (){
                  //
                  //                   ConvertwidgetToImage();
                  //                 },
                  //                 child: Text('ذخیره',
                  //                   style: TextStyle(
                  //                       fontSize: 12,
                  //                       color: BaseColor
                  //                   ),),
                  //               )),
                  //             ),
                  //
                  //
                  //           ],
                  //         )))

                ],
              ),
            )
                : Container(
                color: Colors.white,
                child: Center(child: CircularProgressIndicator())),
          ),
        ),
      ),
    );
  }

   Widget buildSfCircularChart() {
     return MediaQuery(
       data: new MediaQueryData(),
       child: MaterialApp(
         debugShowCheckedModeBanner: false,
         home: SfCircularChart(
              legend: Legend(isVisible: true,overflowMode: LegendItemOverflowMode.wrap),
              backgroundColor: Colors.white,
              series:<CircularSeries> [
                DoughnutSeries<TotalVisitorSale,String>(
                    enableSmartLabels: true,
                    dataSource: widget.datachart,
                    xValueMapper: (TotalVisitorSale S,_)=>S.visName.toString(),
                    yValueMapper: (TotalVisitorSale S2,_)=>S2.Nprice,
                    dataLabelMapper: (TotalVisitorSale S,_)=>
                        SplitPrice2(((S.Nprice/Sum)*100))+'%'

                        ,
              explode: true,
              explodeAll: true,
                    dataLabelSettings: DataLabelSettings(isVisible: true,
                        labelPosition: ChartDataLabelPosition.inside,
                        useSeriesColor: true,
                        textStyle:
                    TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ))
                )
              ],
            ),
       ),
     );
   }


}


 class MyDATA
{
  final String continet;
  final int gdp;

  MyDATA(this.continet, this.gdp);
}
