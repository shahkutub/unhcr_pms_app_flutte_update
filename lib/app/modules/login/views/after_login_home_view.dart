
import 'package:brac_arna/app/routes/app_pages.dart';
import 'package:brac_arna/common/AppConstant.dart';
import 'package:brac_arna/common/ui.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/after_login_controller.dart';

class AfterLoginHomeView extends GetView<after_login_controller> {

  @override
  Widget build(BuildContext context) {
    return Scaffold( //first scaffold
          appBar: AppBar(
            title: Container(
              height: 40,
              //padding: EdgeInsets.,
              child: Stack(
                children: <Widget>[
                  Align(alignment: Alignment.centerLeft,
                    child: Image(
                      //height: 40,
                      //width: 40,
                      image: AssetImage(
                        'assets/images/unhcr_logo_top.png',
                        //'assets/images/logounhcr.png',
                      ),
                    ),
                  ),
                  Align(alignment: Alignment.centerRight,
                      child: Icon(Icons.account_circle_sharp)
                  ),

                ],
              ),
              alignment: Alignment.center,
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start, //Center Row contents horizontally,
            //   crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
            //   children: [
            //     Container(
            //       //margin: EdgeInsets.only(left:20,top: 20),
            //       height: 50,
            //       width: 50,
            //       child:CircleAvatar(
            //         radius: 48, // Image radius
            //         backgroundImage: NetworkImage('imageUrl'),
            //       ) ,
            //     ),
            //
            //     SizedBox(
            //       width: 10,
            //     ),
            //     Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //
            //         Obx(
            //               () => Text(""+controller.userNAme.value,
            //                   style: TextStyle(color: Colors.white,fontSize: 12),
            //                   textAlign:TextAlign.center,
            //                 ),
            //         ),
            //
            //         Obx(
            //               () => Text(""+controller.userRole.value,
            //                 style: TextStyle(color: Colors.white,fontSize: 12),
            //                 textAlign:TextAlign.center,
            //               ),
            //         ),
            //
            //
            //       ],
            //     ),
            //
            //
            //
            //   ],
            // ),
            backgroundColor: Color(0xff03A1E0),

          ),

        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xff03A1E0),
          type: BottomNavigationBarType.fixed,
          //currentIndex: _currentIndex,
          currentIndex: 0,
          onTap: (int index) {
            if(index == 2){
              controller.get_dispatch_submit_list( context);
            }
            },
          selectedItemColor: Colors.white,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          iconSize: 25,
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home),

            ),
            BottomNavigationBarItem(
              label: "History",
              icon: Icon(Icons.history_edu),
            ),
            BottomNavigationBarItem(
              label: "Data Sync",
              icon: Icon(Icons.sync),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(Icons.account_circle_outlined),
            ),
          ],
        ),
          body:Scaffold(
            body:Center(
              child: SingleChildScrollView(
                reverse: true,
                child:Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Container(
                        //padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          //color: Colors.green,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.all(
                              Radius.circular(0.0) //                 <--- border radius here
                          ),
                        ),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Card(
                            //   elevation: 0,
                            //   child:
                              InkWell(
                                  onTap: () {

                                    Get.toNamed(Routes.STOCK_RECEIVE);

                                  },
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Color(0xffB4E3F6),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      width: 110,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.bar_chart_outlined,color: Color(0xff03A1E0),size: 50,),

                                          Text(
                                            'Stock Receive',
                                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                          ),

                                          SizedBox(
                                            height: 5,
                                          ),

                                        ],
                                      ),
                                    ),
                                  )

                              ),
                            //),

                            SizedBox(
                              width: 5,
                            ),
                            // Card(
                            //     elevation: 0,
                            //
                            //   child:
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.ITEM_DISPATCH);
                                  // if(controller.drugList.length == 0){
                                  //   //controller.get_drug_list(context);
                                  //   Ui.defaultSnackBar(message: 'Medicine data empty,please Sync');
                                  // }else{
                                  //   Get.toNamed(Routes.ITEM_DISPATCH);
                                  // }
                                },
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Color(0xffB4E3F6),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      width: 110,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.bar_chart_outlined,color: Color(0xff03A1E0),size: 50,),

                                          Text(
                                            'Dispatch',
                                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                          ),

                                          SizedBox(
                                            height: 5,
                                          ),

                                        ],
                                      ),
                                    ),
                                  )
                              ),

                            //),

                            SizedBox(
                              width: 5,
                            ),
                            // Card(
                            //     elevation: 0,
                              //child:
                              GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.CONSUMPTION_TALLY);
                                  },
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Color(0xffB4E3F6),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      width: 110,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.bar_chart_outlined,color: Color(0xff03A1E0),size: 50,),

                                          Text(
                                            'Tally',
                                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                          ),

                                          SizedBox(
                                            height: 5,
                                          ),

                                        ],
                                      ),
                                    ),
                                  )
                              ),

                          ],
                        ),
                      ),

                      SizedBox(
                        height: 0,
                      ),

                      Container(
                        //padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          //color: Colors.green,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.all(
                              Radius.circular(0.0) //                 <--- border radius here
                          ),
                        ),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Card(
                            //   elevation: 0,
                            //   child:
                            GestureDetector(
                                onTap: () {
                                  // if(controller.drugList.length == 0){
                                  //   //controller.get_drug_list(context);
                                  //   Ui.defaultSnackBar(message: 'Medicine data empty,please Sync');
                                  // }else{
                                  //   Get.toNamed(Routes.ITEM_DISPATCH);
                                  // }

                                },
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Color(0xffB4E3F6),
                                    ),
                                    borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    width: 110,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.bar_chart_outlined,color: Color(0xff03A1E0),size: 50,),

                                        Text(
                                          'Internal Request',
                                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                        ),

                                        SizedBox(
                                          height: 5,
                                        ),

                                      ],
                                    ),
                                  ),
                                )

                            ),
                            //),

                            SizedBox(
                              width: 5,
                            ),
                            // Card(
                            //     elevation: 0,
                            //
                            //   child:
                            GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.CONSUMPTION_TALLY);
                                },
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Color(0xffB4E3F6),
                                    ),
                                    borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    width: 110,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.bar_chart_outlined,color: Color(0xff03A1E0),size: 50,),

                                        Text(
                                          'Stock Return',
                                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                        ),

                                        SizedBox(
                                          height: 5,
                                        ),

                                      ],
                                    ),
                                  ),
                                )
                            ),

                            //),

                            SizedBox(
                              width: 5,
                            ),
                            // Card(
                            //     elevation: 0,
                            //child:
                            GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.INTERNAL_REQUEST);
                                },
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Color(0xffB4E3F6),
                                    ),
                                    borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    width: 110,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.bar_chart_outlined,color: Color(0xff03A1E0),size: 50,),

                                        Text(
                                          'Stock Loss',
                                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                        ),

                                        SizedBox(
                                          height: 5,
                                        ),

                                      ],
                                    ),
                                  ),
                                )
                            ),

                          ],
                        ),
                      ),

                      Container(
                        //padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          //color: Colors.green,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.all(
                              Radius.circular(0.0) //                 <--- border radius here
                          ),
                        ),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Card(
                            //   elevation: 0,
                            //   child:
                            GestureDetector(
                                onTap: () {
                                  AppConstant.pageName = "Opening Stock";
                                  Get.toNamed(Routes.Current_STOCK);
                                  //Get.toNamed(Routes.Current_STOCK);
                                  // if(controller.drugList.length == 0){
                                  //   //controller.get_drug_list(context);
                                  //   Ui.defaultSnackBar(message: 'Medicine data empty,please Sync');
                                  // }else{
                                  //   Get.toNamed(Routes.ITEM_DISPATCH);
                                  // }

                                },
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Color(0xffB4E3F6),
                                    ),
                                    borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    width: 110,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.bar_chart_outlined,color: Color(0xff03A1E0),size: 50,),

                                        Text(
                                          'Opening Stock',
                                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                        ),

                                        SizedBox(
                                          height: 5,
                                        ),

                                      ],
                                    ),
                                  ),
                                )

                            ),
                            //),

                            SizedBox(
                              width: 5,
                            ),
                            // Card(
                            //     elevation: 0,
                            //
                            //   child:
                            InkWell(
                                onTap: () {
                                  AppConstant.pageName = 'Closing Stock';
                                  Get.toNamed(Routes.Current_STOCK);
                                },
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Color(0xffB4E3F6),
                                    ),
                                    borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    width: 110,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.bar_chart_outlined,color: Color(0xff03A1E0),size: 50,),

                                        Text(
                                          'Closing Stock',
                                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                        ),

                                        SizedBox(
                                          height: 5,
                                        ),

                                      ],
                                    ),
                                  ),
                                )
                            ),

                            //),

                            SizedBox(
                              width: 5,
                            ),
                            // Card(
                            //     elevation: 0,
                            //child:
                            InkWell(
                                onTap: () {
                                  AppConstant.pageName = 'Current Stock';
                                  Get.toNamed(Routes.Current_STOCK);
                                  //Get.toNamed(Routes.INTERNAL_REQUEST);
                                },
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Color(0xffB4E3F6),
                                    ),
                                    borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    width: 110,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.bar_chart_outlined,color: Color(0xff03A1E0),size: 50,),

                                        Text(
                                          'Current Stock',
                                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                        ),

                                        SizedBox(
                                          height: 5,
                                        ),

                                      ],
                                    ),
                                  ),
                                )
                            ),

                          ],
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      Container(
                          decoration: BoxDecoration(
                              color: Color(0xffB4E3F6),
                              border: Border.all(
                                color: Color(0xffB4E3F6),
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),

                        margin: EdgeInsets.only(left: 12,right: 12),
                        padding: EdgeInsets.only(top: 20,bottom: 20),
                          child: Column(
                            children: [

                              // Container(
                              //
                              //   child: Icon(Icons.mail,color: Color(0xff3699FF),),
                              //   alignment: Alignment.topLeft,
                              // ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 20),
                                    // height: 100,
                                    // width: 180,
                                    //padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Color(0xffB4E3F6),
                                      border: Border.all(color: Color(0xffB4E3F6)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0) //                 <--- border radius here
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [


                                        Text("200",
                                          style: TextStyle(color: Colors.black,fontSize: 25),
                                          textAlign:TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text("No of Patient",
                                          style: TextStyle(color: Colors.white,fontSize: 12),
                                          textAlign:TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    color: Colors.white,
                                    width: 2,
                                    height: 60,
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    //padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Color(0xffB4E3F6),
                                      border: Border.all(color: Color(0xffB4E3F6)),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0) //                 <--- border radius here
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [

                                        Text("20",
                                          style: TextStyle(color: Colors.black,fontSize: 25),
                                          textAlign:TextAlign.center,
                                        ),

                                        SizedBox(
                                          height: 15,
                                        ),

                                        Text("Total Distributed Drug",
                                          style: TextStyle(color: Colors.white,fontSize: 12),
                                          textAlign:TextAlign.center,
                                        ),

                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                      ),



                      
                      //chart
                      // AspectRatio(
                      //   aspectRatio: 1.7,
                      //   child: Card(
                      //     elevation: 0,
                      //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      //     color: const Color(0xff2c4260),
                      //     child: const _BarChart(),
                      //   ),
                      // ),
                      //
                      // Text("Weekly Consumption",
                      //   style: TextStyle(color: Colors.black,fontSize: 12),
                      //   textAlign:TextAlign.center,
                      // ),

                      Container(
                        //height: 200,
                        width: Get.width-24,
                        padding: EdgeInsets.all(12),
                        margin: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xffFFF4DE),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Top 10 Consumed Medicine'),
                            SizedBox( height:10),
                            Row(
                              children: <Widget>[
                                Expanded(child:  Text("SL",style: TextStyle(color: Colors.grey,fontSize: 12),), flex: 1,),
                                Expanded(child:  Text("ITEM",style: TextStyle(color: Colors.grey,fontSize: 12),), flex: 5,),
                                Expanded(child:  Text("QTY",style: TextStyle(color: Colors.grey,fontSize: 12),), flex: 2,),
                              ],
                            ),
                            //
                            // SizedBox( height:10),
                            // Row(
                            //   children: <Widget>[
                            //     Expanded(child:  Text("1",style: TextStyle(color: Colors.grey,fontSize: 12),), flex: 1,),
                            //     Expanded(child:  Text("Montilucast 10mg ",style: TextStyle(color: Colors.grey,fontSize: 12),), flex: 5,),
                            //     Expanded(child:  Text("300",style: TextStyle(color: Colors.black,fontSize: 12),), flex: 2,),
                            //   ],
                            // ),
                            //
                            // SizedBox( height:10),
                            // Row(
                            //   children: <Widget>[
                            //     Expanded(child:  Text("1",style: TextStyle(color: Colors.grey,fontSize: 12),), flex: 1,),
                            //     Expanded(child:  Text("Montilucast 10mg ",style: TextStyle(color: Colors.grey,fontSize: 12),), flex: 5,),
                            //     Expanded(child:  Text("300",style: TextStyle(color: Colors.black,fontSize: 12),), flex: 2,),
                            //   ],
                            // ),
                            //
                            // SizedBox( height:10),
                            // Row(
                            //   children: <Widget>[
                            //     Expanded(child:  Text("1",style: TextStyle(color: Colors.grey,fontSize: 12),), flex: 1,),
                            //     Expanded(child:  Text("Montilucast 10mg ",style: TextStyle(color: Colors.grey,fontSize: 12),), flex: 5,),
                            //     Expanded(child:  Text("300",style: TextStyle(color: Colors.black,fontSize: 12),), flex: 2,),
                            //   ],
                            // ),
                            //
                            // SizedBox( height:10),
                            // Row(
                            //   children: <Widget>[
                            //     Expanded(child:  Text("1",style: TextStyle(color: Colors.grey,fontSize: 12),), flex: 1,),
                            //     Expanded(child:  Text("Montilucast 10mg ",style: TextStyle(color: Colors.grey,fontSize: 12),), flex: 5,),
                            //     Expanded(child:  Text("300",style: TextStyle(color: Colors.black,fontSize: 12),), flex: 2,),
                            //   ],
                            // ),


                            Container(
                              height: Get.height/7,
                              child: ListView.builder(
                                itemCount: 10,
                                //primary: false,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  var sl = index+1;
                                  return Column(
                                    children: [
                                      SizedBox( height:10),
                                      Row(
                                        children: <Widget>[
                                          Expanded(child:  Text(""+sl.toString(),style: TextStyle(color: Colors.grey,fontSize: 12),), flex: 1,),
                                          Expanded(child:  Text("Montilucast  ",style: TextStyle(color: Colors.grey,fontSize: 12),), flex: 5,),
                                          Expanded(child:  Text("300",style: TextStyle(color: Colors.black,fontSize: 12),), flex: 2,),
                                        ],
                                      ),
                                    ],

                                  );
                                }),),


                          ],
                        ),
                        
                      ),

                    ],

                  ),
                ) ,
              ),
            ),

          )

      );
    }
  }


class _BarChart extends StatelessWidget {
  const _BarChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: 20,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      tooltipBgColor: Colors.transparent,
      tooltipPadding: const EdgeInsets.all(0),
      tooltipMargin: 8,
      getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
          ) {
        return BarTooltipItem(
          rod.toY.round().toString(),
          const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Sun';
        break;
      case 1:
        text = 'Mon';
        break;
      case 2:
        text = 'Twe';
        break;
      case 3:
        text = 'Wed';
        break;
      case 4:
        text = 'Thu';
        break;
      case 5:
        text = 'Fri';
        break;
      case 6:
        text = 'Sat';
        break;
      default:
        text = '';
        break;
    }
    return Center(child: Text(text, style: style));
  }

  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: getTitles,
      ),
    ),
    leftTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    rightTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );

  FlBorderData get borderData => FlBorderData(
    show: false,
  );

  final _barsGradient = const LinearGradient(
    colors: [
      Colors.lightBlueAccent,
      Colors.greenAccent,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  List<BarChartGroupData> get barGroups => [
    BarChartGroupData(
      x: 0,
      barRods: [
        BarChartRodData(
          toY: 8,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 1,
      barRods: [
        BarChartRodData(
          toY: 10,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 2,
      barRods: [
        BarChartRodData(
          toY: 14,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 3,
      barRods: [
        BarChartRodData(
          toY: 15,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 4,
      barRods: [
        BarChartRodData(
          toY: 13,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 5,
      barRods: [
        BarChartRodData(
          toY: 10,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),

    BarChartGroupData(
      x: 6,
      barRods: [
        BarChartRodData(
          toY: 8,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
  ];


}