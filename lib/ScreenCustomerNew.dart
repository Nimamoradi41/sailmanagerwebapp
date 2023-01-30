import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../Constants.dart';
import '../DataBseFile.dart';
import 'ApiService.dart';
import 'Models/ModelCustomerNew.dart';


class ScreenCustomerNew extends StatefulWidget {

  List<int> Data = [];
  List<int> DataSelected = [];







  ScreenCustomerNew(this.Data,this.DataSelected);



  @override
  State<ScreenCustomerNew> createState() => _ScreenCustomerNewState();
}

class _ScreenCustomerNewState extends State<ScreenCustomerNew> {




  List<ResultModelCustomerNew> Customer = <ResultModelCustomerNew>[];





  var Baseurl='';
  var UserName='';
  var Password='';
  // List<RePerson> Customer_temps3 = <RePerson>[];
  var pr;

  List<int> DataSelectedMain = [];
  Future GetDataCustomer()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Baseurl=  prefs.getString("Baseurl")!;
    UserName= prefs.getString("UserName")!;
    Password= prefs.getString("Password")!;
  }
  @override
  void initState() {
    super.initState();
    DataSelectedMain.addAll(widget.DataSelected);
    GetDataCustomer();
    pr = ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);


    Run();

  }

  void Run(){
    for (var element in Customer) {
      if(DataSelectedMain.contains(element.id))
        {
          element.IsCheck=true;
        }
    }

    setState(() {

    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF1F7FE),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.arrow_back,color: BaseColor,),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          margin: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                          child: TextField(
                            textAlign: TextAlign.end,
                            onChanged: (val) async{
                              if(val.isNotEmpty)
                              {
                                val=val.replaceAll('ی','ي');
                                val=val.replaceAll('ک','ك');
                                Customer.clear();
                             var   CustomerData = await ApiService.GetCustomerNew(pr, Baseurl, UserName, Password,widget.Data,val.toString());
                                Customer=CustomerData.result;
                                Customer.sort((a, b) => a.customerName.compareTo(b.customerName));
                                Run();




                                // Customer_temps2.sort((a, b) {
                                //   return a.name.toLowerCase().compareTo(b.name.toLowerCase());
                                // });
                                // setState(() {
                                //   if(Customer_temps3.length==0)
                                //   {
                                //     Customer_temps3.clear();
                                //   }
                                // });
                              }else{
                                // print(Customer.length.toString());
                                // setState(() {
                                //   Customer_temps3=widget.Customer_temps2;
                                // });

                              }
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8),
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Color(0xff1F3C84).withOpacity(0.80)
                                ),
                                hintText: '...مشتری خود را جستجو کنید'
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Customer.length==0?
                  Expanded(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('images/noting.svg',width: 150,height: 150,),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24.0),
                            child: Text('محتوایی برای نمایش وجود ندارد',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: SizeFirst,
                                  fontWeight: FontWeight.bold,
                                  color: BaseColor
                              ),),
                          ),
                        ],
                      ),
                    ),
                  ):Container(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              // itemCount: Customer_temps2.take(30).length,
                              itemCount:
                              Customer.length,
                              itemBuilder: (ctx,item){
                                return   InkWell(
                                  onTap: () async{
                                    for (int i=0;i<DataSelectedMain.length;i++) {
                                      if(DataSelectedMain[i]==Customer[item].id)
                                        {
                                           DataSelectedMain.removeAt(i);
                                        }
                                    }


                                    print('DataSelectedMain'+DataSelectedMain.length.toString());
                                    Customer[item].IsCheck=!Customer[item].IsCheck;
                                    Run();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                                Customer[item].customerName ),
                                            Checkbox(
                                              value:
                                              Customer[item].IsCheck,
                                              activeColor: BaseColor ,
                                              focusColor:BaseColor ,
                                              onChanged: (bool? value) {

                                                Customer[item].IsCheck=value!;
                                                setState(() {

                                                });

                                                  // Navigator.pop(context);






                                              },
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 1,
                                          color: Colors.grey.withOpacity(0.5),
                                          margin: EdgeInsets.symmetric(horizontal: 8),
                                        )
                                      ],
                                    ),
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
              )
            ],
          ),
        ),
      floatingActionButton: Customer.where((element) => element.IsCheck).isNotEmpty?
      Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: FloatingActionButton(
          backgroundColor: BaseColor,
          onPressed: (){
            List<ResultModelCustomerNew> TempCustomer=[];
            for (var element in Customer) {
              if(element.IsCheck==true)
              {
                TempCustomer.add(element);
              }
            }
            Navigator.pop(context,TempCustomer);
          },
          child: InkWell(
            onTap: (){
              List<ResultModelCustomerNew> TempCustomer=[];
              for (var element in Customer) {
                if(element.IsCheck==true)
                {
                  TempCustomer.add(element);
                }
              }
              Navigator.pop(context,TempCustomer);
            },
            child: SvgPicture.asset('images/tickk.svg',color: Colors.white,)
          ),
        ),
      ):Container(),
    );
  }




}


