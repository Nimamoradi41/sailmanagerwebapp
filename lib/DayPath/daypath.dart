import 'package:flutter/material.dart';


import '../Calender/TextApp.dart';
import '../Constants.dart';
import 'Adddaypath.dart';
import 'Allinfodaypath.dart';
import 'Copydaypath.dart';

class daypath extends StatefulWidget {

  String DataConst;


  daypath(this.DataConst);

  @override
  State<daypath> createState() => _daypathState();
}

class _daypathState extends State<daypath> with SingleTickerProviderStateMixin{

  late TabController tabController;
  int page = 0;
  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: _tabs.length, vsync: this);
    tabController.addListener((){
      if (tabController.indexIsChanging) {
        setState(() {
          page = tabController.index;
        });
      }

    });


  }

  List<Tab> _tabs = <Tab>[
    Tab(icon: Icon(Icons.new_label),child: TextApp('روز مسیر جدید',10,Colors.white,true)),
    Tab(icon: Icon(Icons.info_outline_rounded),child: TextApp('اطلاعات روز مسیر',10,Colors.white,true)),
    Tab(icon: Icon(Icons.copy),child: TextApp('کپی از روز خاص',10,Colors.white,true)),

  ];







  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: BaseColor,
            centerTitle: true, title: Column(
            children: [
              Text('آتیران ', textAlign: TextAlign.center),
              Text(
                widget.DataConst,
                style: TextStyle(fontSize: 10), textAlign: TextAlign.center,)
            ],
          ),
            leading: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back,color: Colors.white,)),
            bottom: TabBar(
                controller: tabController,
                onTap: (index){
                  setState(() {
                    tabController.index=index;
                  });
                },
                tabs: _tabs),
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Expanded( child: TabBarView(
                  controller: tabController,
                  children: [
                    Adddaypath(widget.DataConst),
                    Allinfodaypath(widget.DataConst),
                    Copydaypath(widget.DataConst),

                  ])),
            ],

          ),
        ));
  }
}
