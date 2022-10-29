import 'package:flutter/material.dart';

import '../Constants.dart';
import '../Models/Visitors.dart';
import '../TextApp.dart';
import '../VisitorComponent/MainItemFilterVisitor.dart';




class ScreenMassageToVisitor extends StatefulWidget {

  @override
  State<ScreenMassageToVisitor> createState() => _ScreenMassageToVisitorState();
}

class _ScreenMassageToVisitorState extends State<ScreenMassageToVisitor> {
  bool IsAllVisitors=false;


  List<Visitors> main=[];
  @override
  void initState() {
    super.initState();
    var sd=Visitors();
    sd.Name="Nima";
    var sd2=Visitors();
    sd2.Name="Faraz";

    var sd3=Visitors();
    sd3.Name="Ali";


    var sd4=Visitors();
    sd4.Name="Ahmad";


    main.add(sd);
    main.add(sd2);
    main.add(sd3);
    main.add(sd4);

  }

  TextEditingController txtsearch=TextEditingController();
  Future ShowModall_() async
  {
    bool b=await   showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx){

          return Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: StatefulBuilder(
                builder: (context,state){
                  return  SafeArea(
                    child:
                    Stack(
                        children:[
                          Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'جستجو کنید',
                                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                                          hintStyle: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey
                                          )
                                      ),

                                      textAlign: TextAlign.right,
                                      controller: txtsearch,
                                      onChanged: (val){
                                        state(() {
                                          var  s=val.replaceAll('ی','ي');
                                          s=s.replaceAll('ک','ك');
                                          txtsearch.text=s;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    state(() {


                                      IsAllVisitors=!IsAllVisitors;




                                    });


                                    if(IsAllVisitors==true)
                                    {
                                      state(() {
                                        main.forEach((element) {
                                          element.IsCheck=true;
                                        });
                                      });

                                    }else{
                                      state(() {
                                        main.forEach((element) {
                                          element.IsCheck=false;
                                        });
                                      });
                                    }










                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('انتخاب همه'),
                                      Checkbox(
                                        value:

                                        IsAllVisitors,
                                        activeColor: BaseColor ,
                                        focusColor:BaseColor ,
                                        onChanged: (bool? value) {
                                          state(() {


                                            IsAllVisitors=!IsAllVisitors;




                                          });


                                          if(IsAllVisitors==true)
                                          {


                                            state(() {
                                              main.forEach((element) {
                                                element.IsCheck=true;
                                              });
                                            });

                                          }else{
                                            state(() {
                                              main.forEach((element) {
                                                element.IsCheck=false;
                                              });
                                            });
                                          }





                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    // itemCount: Departments.length,
                                    itemCount:  main.length,
                                    itemBuilder: (ctx,item){
                                      return
                                        txtsearch.text.isEmpty?
                                        Container(
                                          child: InkWell(
                                            highlightColor: Colors.transparent,
                                            onTap: ()
                                            {


                                              if(IsAllVisitors==false)
                                              {
                                                state(() {
                                                  main[item].IsCheck= !main[item].IsCheck;
                                                });
                                              }
                                              // Navigator.pop(context);






                                              FocusScope.of(context).unfocus();

                                              // Navigator.pop(context,Departments[item].toString());
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                    main[item].Name ),
                                                // Text(sa),
                                                Checkbox(
                                                  value:

                                                  main[item].IsCheck,
                                                  activeColor: BaseColor ,
                                                  focusColor:BaseColor ,
                                                  onChanged: (bool? value) {

                                                    if(IsAllVisitors==false)
                                                    {
                                                      state(() {
                                                        main[item].IsCheck=value!;
                                                      });
                                                    }
                                                    // Navigator.pop(context);




                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ) :
                                        txtsearch.text.isNotEmpty &&  main[item].Name.contains(txtsearch.text.toString())?
                                        Container(
                                          child: InkWell(
                                            highlightColor: Colors.transparent,
                                            onTap: ()
                                            {


                                              if(IsAllVisitors==false)
                                              {
                                                state(() {
                                                  main[item].IsCheck= !main[item].IsCheck;
                                                });
                                              }
                                              // Navigator.pop(context);

                                              FocusScope.of(context).unfocus();

                                              // Navigator.pop(context,Departments[item].toString());
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                    main[item].Name ),
                                                // Text(sa),
                                                Checkbox(
                                                  value:
                                                  main[item].IsCheck,
                                                  activeColor: BaseColor ,
                                                  focusColor:BaseColor ,
                                                  onChanged: (bool? value) {


                                                    if(IsAllVisitors==false)
                                                    {
                                                      state(() {
                                                        main[item].IsCheck=value!;
                                                      });
                                                    }
                                                    // Navigator.pop(context);




                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ):Container();



                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                              left: 0,
                              bottom: 0,
                              child: InkWell(
                                onTap: (){
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  Navigator.pop(context);



                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  margin: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                                    child: Row(
                                      children: [
                                        Text('بستن',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16
                                          ),),
                                        Icon(Icons.close,color: Colors.white,)
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                        ]
                    ),
                  );
                }),
          );
        });


    setState(() {

    });


    // if(Flag=='1')
    //   {
    //     if(IsAllProvice)
    //       {
    //        ProviceSelected.addAll(Provice);
    //       }else{
    //       Provice.forEach((element) {
    //         if(element.)
    //       });
    //     }
    //   }



  }



  var Controler_Title=TextEditingController();
  var Controler_Text=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: BaseColor,
        title:Column(
          children: [
            Text('پیام به ویزیتور',style: TextStyle(fontSize: 10),textAlign: TextAlign.center,)
          ],
        ),
        leading: InkWell
          (
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      body:Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  MainItemFilterVistor(IsAllVisitors,
                      main.where((element) => element.IsCheck==true).toList()
                      // .sort((a, b) => a.someProperty.compareTo(b.someProperty))
                      ,(){
                        // if(main.length==0)
                        // {
                        //   Run('2');
                        // }else{
                        //   ShowModall_("2");
                        // }

                        ShowModall_();
                      },() {







                        setState(() {

                        });




                      }),

                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextApp('عنوان پیام', 14 , Colors.black54, true),
                      )),
                  Container(
                    width: double.infinity,
                    height: 100,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 2
                        )
                      ]
                    ),
                    child: TextField(
                      textAlign: TextAlign.end,
                      controller: Controler_Title,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          border: InputBorder.none,
                          hintText:'عنوان خود را وارد کنید',
                          hintStyle: TextStyle(
                              color: Color(0xffAEAEAE)
                          )
                      ),
                    ),
                  ),

                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextApp('متن پیام', 14 , Colors.black54, true),
                      )),
                  Container(
                    width: double.infinity,
                    height: 100,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 2
                          )
                        ]
                    ),
                    child: TextField(
                      textAlign: TextAlign.end,
                      controller: Controler_Text,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          border: InputBorder.none,
                          hintText:'متن خود را وارد کنید',
                          hintStyle: TextStyle(
                              color: Color(0xffAEAEAE)
                          )
                      ),
                    ),
                  ),


                ],
              ),
            ),
            Expanded(child:   Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: Container(
                  margin: EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                  width: double.maxFinite,
                  child: ElevatedButton(onPressed: (){
                      Navigator.pop(context);
                  },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red),
                      child:
                      Text('بستن',style: TextStyle(
                          color: Colors.white
                      ),)),
                )),
                Expanded(child: Container(
                  margin: EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                  width: double.maxFinite,
                  child: ElevatedButton(
                      onPressed: (){
                        // setState(() {
                        //   FlagFilter=false;
                        // });
                        // Navigator.pop(context);
                        // PageCounter=1;
                        // PageCounterMain=2;
                        // Customers.clear();
                        // PageCounterCheck=false;
                        // GetCustomers('',false);
                      },
                      style: ElevatedButton.styleFrom(primary: BaseColor),
                      child:
                      Text('ارسال پیام',style: TextStyle(
                          color: Colors.white
                      ),)),
                )),
              ],))
          ],
        ),
      ),
    );
  }
}
