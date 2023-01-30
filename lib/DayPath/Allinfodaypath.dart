import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../ApiService.dart';
import '../Calender/TextApp.dart';
import '../Constants.dart';

import '../Models/ModelReportVisitordaypath.dart';
import 'BoxInfoDayPath.dart';

class Allinfodaypath extends StatefulWidget {

  String DataConst;


  Allinfodaypath(this.DataConst);
  @override
  State<Allinfodaypath> createState() => _AllinfodaypathState();
}






class _AllinfodaypathState extends State<Allinfodaypath> {



  List<ResultDaypath> listmain=[];


  Future GetData()async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var base =prefs.getString('Baseurl');
    var UserName =prefs.getString('UserName');
    var Password =prefs.getString('Password');






    var  pr = ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);

    pr.style(
      textAlign: TextAlign.center,
      message: ' درحال ارتباط با سرور',
      messageTextStyle: TextStyle(
          fontFamily:  'iransans',
          fontSize: 14,
          color: Colors.black87),
    );
    await  pr.show();

    var Data=await ApiService.VisitorDayPath( base!, UserName!, Password!,'1400/08/08'
    );



    pr.hide();
    if(Data!=null)
    {
      if(Data.code=='200')
      {
            if(Data.result.isNotEmpty)
            {
              setState(() {
                listmain=Data.result;
              });
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

  @override
  void initState() {
    super.initState();
    GetData();
  }





  Future<Null> _refresh() {

    return GetData().then((_user) {
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      listmain.length>0?
      RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 150),
                child: ListView.builder(
                    itemCount: listmain.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx,item){
                      return
                        Container(
                            margin: EdgeInsets.only(bottom: item==listmain.length-1?80:0),
                            child: BoxInfoDayPath(listmain[item]));
                    }
                ),
              ),
            ],
          ),
        ),
      ):Center(
        child: TextApp('محتوایی برای نمایش وجود ندارد',12,BaseColor,true),
      ) ,
      floatingActionButton:
      Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: FloatingActionButton(
          backgroundColor: BaseColor,
          onPressed: (){
            GetData();
          },
          child: InkWell(
              onTap: (){
                GetData();
              },
              child: const Icon(Icons.refresh,color: Colors.white,size: 30,)
          ),
        ),
      ),
    );
  }
}


