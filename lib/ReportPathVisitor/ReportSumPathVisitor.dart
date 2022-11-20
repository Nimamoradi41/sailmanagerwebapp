import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiService.dart';
import '../Constants.dart';
import '../Models/ModelPathSumVis.dart';
import '../Models/ModelVisitorsAll.dart';

import '../Models/Modelpathvisitor.dart';
import '../ReportVisitors/ItemColumn.dart';
import '../TextApp.dart';
import '../VisitorComponent/MainItemFilterVisitor.dart';
import 'BoxSumPath.dart';
import 'ItemReportPath.dart';

class ReportSumPathVisitor extends StatefulWidget {



  String visid;
  String Ta_Data;
  String Az_Data;


  ReportSumPathVisitor(this.visid,this.Az_Data,this.Ta_Data);

  @override
  State<ReportSumPathVisitor> createState() => _ReportPathVisitorState();
}

class _ReportPathVisitorState extends State<ReportSumPathVisitor> {








  bool FlagFilter=true;
  bool IsAllVisitors=false;
  bool FlagCheckOneDay=false;
  bool One=false;
  @override
  void initState() {
    super.initState();
    GetData();
  }

  List<Res_ModelPathSumVis>  mainItems=[];
  List<Res_ModelPathSumVis>  mainItemsSearch=[];

  double Vahed=0;
  int Joz=0;
  double Kol=0;
  Future GetData()async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var base =prefs.getString('Baseurl');
    var UserName =prefs.getString('UserName');
    var Password =prefs.getString('Password');






    var  pr = ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);


    var Data=await ApiService.GetVisitorsPathSum(pr, base!, UserName!, Password!,
       // widget. Ta_Data,widget.Az_Data,widget.visid
       widget. Ta_Data,widget.Az_Data,'4'
        );
    pr.hide();
    if(Data!=null)
    {
      if(Data.code==200)
      {
        if(Data.res!=null)
        {
          setState(() {
            if(Data.res.length>0)
              {
                mainItems=Data.res;
                mainItemsSearch.addAll(mainItems);
                mainItems.forEach((element) {
                  Vahed=element.tedVah+Vahed;
                  Joz=element.tedJoz+Joz;
                  Kol=((element.tedVah*element.mohvah)+element.tedJoz)+Kol;
                });
              }else{
              Navigator.pop(context);
              ApiService.ShowSnackbar(Data.msg.toString());
            }
          });
        }else{
          Navigator.pop(context);
          ApiService.ShowSnackbar(Data.msg.toString());
        }
      }else{
        Navigator.pop(context);
        ApiService.ShowSnackbar(Data.msg);
      }
    }else{
      Navigator.pop(context);
      ApiService.ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده');
    }


    FocusManager.instance.primaryFocus?.unfocus();

  }






  Future<Null> _refresh() {
    mainItems.clear();
    mainItemsSearch.clear();
    Vahed=0;
    Joz=0;
    Kol=0;
    return GetData().then((_user) {
    });
  }
  Future<bool> _onWillPop2() async {
    Navigator.pop(context);
    // if(FlagFilter==false)
    // {
    //
    //   Navigator.pop(context);
    //   debugPrint('A');
    // }else{
    //   if(mainItems.length==0)
    //   {
    //     Navigator.pop(context);
    //     debugPrint('B');
    //
    //   }else{
    //     debugPrint('C');
    //     setState(() {
    //       FlagFilter=false;
    //     });
    //   }



    // }

    return false;


  }

  TextEditingController txtsearch=TextEditingController();
  TextEditingController ControlserSerach=TextEditingController();
  @override
  Widget build(BuildContext context) {
    double Widdd=MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop:_onWillPop2,
      child: Center(
        child: Container(
          width: Widdd>600?600:Widdd,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: BaseColor,
              title:Column(
                children: [
                  Text(
                    'سرجمع اقلام ویزیت شده',
                    style: TextStyle(fontSize: 10),textAlign: TextAlign.center,)
                ],
              ),
              leading: InkWell
                (
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back,color: Colors.white,)),
            ),
            body:
            RefreshIndicator(
              onRefresh: _refresh,
               child: Container(
            width: double.infinity,

            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 2,
                              spreadRadius: 2
                          )
                        ],
                        borderRadius: BorderRadius.circular(16)
                    ),
                    child: TextField(
                      controller: ControlserSerach,
                      onTap: (){
                        if(ControlserSerach.selection == TextSelection.fromPosition(TextPosition(offset: ControlserSerach.text.length -1))){
                          setState(() {
                            ControlserSerach.selection = TextSelection.fromPosition(TextPosition(offset: ControlserSerach.text.length));
                          });
                        }
                      },
                      textAlign: TextAlign.right,
                      onChanged: (val){
                        String s="";
                        if(val.isNotEmpty)
                        {
                          mainItemsSearch.clear();




                          s=val.replaceAll('ی','ي');
                          s=s.replaceAll('ک','ك');
                          mainItemsSearch=mainItems.where((element) => element.nameKala.contains(s)).toList();
                          setState(() {
                          });
                        }else{
                          mainItemsSearch.clear();
                          mainItemsSearch.addAll(mainItems);
                          setState(() {

                          });
                        }
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'جستجو کنید',
                          contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          )
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                        color: BaseColor,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                      child: TextApp(
                          ' سرجمع اقلام ',12,Colors.white,false
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 8,left: 8,bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            color: BaseColor.withOpacity(0.25),
                            spreadRadius: 2,
                            blurRadius: 8
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child:Row(
                        children: [
                          Expanded(child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextApp(Kol.round()==Kol?Kol.round().toString():Kol.toString(), 12, Colors.black87, false),
                              TextApp('کل', 12, Colors.black87, false),
                            ],
                          )),
                          Container(
                            width: 1,
                            height: 25,
                            color: Colors.black54,
                          ),
                          Expanded(child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextApp(Joz.round()==Joz?Joz.round().toString():Joz.toString(), 12, Colors.black87, false),
                              TextApp('جز', 12, Colors.black87, false),
                            ],
                          )),
                          Container(
                            width: 1,
                            height: 25,
                            color: Colors.black54,
                          ),
                          Expanded(child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextApp(Vahed.round()==Vahed?Vahed.round().toString():Vahed.toString(), 12, Colors.black87, false),
                              TextApp('واحد', 12, Colors.black87, false),
                            ],
                          ))

                        ],
                      ),
                    ),
                  ),
                  ListView.builder(
                        itemCount: mainItemsSearch.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (ctx,item){
                          return  InkWell(
                              child: Container(
                                  margin: item==mainItemsSearch.length-1?EdgeInsets.only(bottom: 80):null,
                                  child: BoxSumPath(mainItemsSearch[item])));
                        }
                        ),
                ],
              ),
            ),
          ),
             ),

          ),
        ),
      ),
    );
  }
}



class BoxInfo89 extends StatelessWidget {

  String Tti;
  String Tex;


  BoxInfo89(this.Tti, this.Tex);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextApp(Tti,12,Colors.black54,false),
        TextApp(Tex,12,Colors.black87,false),
      ],
    );
  }
}


