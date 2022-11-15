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
  }


  Future<Null> _refresh() {
    mainItems.clear();
    return GetData().then((_user) {
    });
  }
  Future<bool> _onWillPop2() async {
    if(FlagFilter==false)
    {
      Navigator.pop(context);
      return false;
    }else{
      if(mainItems.length==0)
      {
        Navigator.pop(context);
        return false;
      }else{
        setState(() {
          FlagFilter=false;
        });
      }



    }

    return false;


  }

  TextEditingController txtsearch=TextEditingController();

  @override
  Widget build(BuildContext context) {
    var Sizewid=MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        width: Sizewid>600?600:Sizewid,
        child: WillPopScope(
          onWillPop:_onWillPop2,
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

            child: ListView.builder(
                  itemCount: mainItems.length,
                  itemBuilder: (ctx,item){
                    return  InkWell(
                        child: Container(
                            margin: item==mainItems.length-1?EdgeInsets.only(bottom: 80):null,
                            child: BoxSumPath(mainItems[item])));
                  }
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
        TextApp(Tti,12,Colors.grey,false),
        TextApp(Tex,12,Colors.black54,false),
      ],
    );
  }
}


