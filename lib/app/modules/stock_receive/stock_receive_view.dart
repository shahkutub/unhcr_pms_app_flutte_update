

import 'package:brac_arna/app/modules/current_stock/current_stock_controller.dart';
import 'package:brac_arna/app/modules/stock_receive/stock_receive_controller.dart';
import 'package:brac_arna/common/AppConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:intl/intl.dart';


class StockReceiveView extends GetView<StockReceiveController>{
  final _size = Get.size;
  String date = "";
  DateTime selectedDate = DateTime.now();
  var txt = TextEditingController();
  var receiveQtyEditControler = TextEditingController();
  var rejectQtyEditControler = TextEditingController();
  var rejectReasonEditControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Get.find<StockReceiveController>();
    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    txt.text = "00-00-0000";
    // TextEditingController _controller = TextEditingController();
    // _controller.text = "0";
    // final List<String> _suggestions = [
    //   'Alligator',
    //   'Buffalo',
    //   'Chicken',
    //   'Dog',
    //   'Eagle',
    //   'Frog'
    // ];
    var now = DateTime.now();
    print(DateFormat().format(now));
    final time = DateTime(now.year, now.month, now.day,now.hour,now.minute+15);
    print('time+15 : '+DateFormat('HH:mm a').format(time));

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size(60,55),
          child:  AppBar(
              backgroundColor: Colors.blueAccent,
              elevation: 0,
              centerTitle: true,
              //title: Text('Item Dispatch')

            title: Stack(alignment: Alignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  //child: Text(AppConstant.pageName),),
                  child: Text('Stock Receive'),),

              ],
            ),

          ),
        ),
      //resizeToAvoidBottomInset: true,
        body:Container(
          height: Get.height,
          margin: EdgeInsets.all(10),
          // child: Container(
          //   //height: 200,
          //   //width: Get.width-24,
          //   padding: EdgeInsets.all(12),
          //   margin: EdgeInsets.all(12),
            // decoration: BoxDecoration(
            //     color: Color(0xffFFF4DE),
            //     borderRadius: BorderRadius.all(Radius.circular(10))
            // ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox( height:10),
                // Row(
                //   children: <Widget>[
                //     Expanded(child:  Text("SL",style: TextStyle(color: Colors.blueAccent,fontSize: 12),), flex: 1,),
                //     Expanded(child:  Text("ITEM",style: TextStyle(color: Colors.blueAccent,fontSize: 12),), flex: 5,),
                //     Expanded(child:  Text("QTY",style: TextStyle(color: Colors.blueAccent,fontSize: 12),), flex: 2,),
                //   ],
                // ),

            // ClipPath(
            //   clipper: CurveClipper(),
            //   child: Container(
            //     color: Colors.red,
            //     height: 200.0,
            //   ),
            // ),


                Obx(() =>
                    Container(
                        margin: EdgeInsets.only(left: 0,right: 0),
                        //alignment: Alignment.center,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //Flexible(child:
                            controller.CustomRadioButton("Pending", 1,context),
                            //flex: 1,),
                            SizedBox(width: 20,),
                            //Flexible(child:
                            controller.CustomRadioButton("Received", 2,context),
                            // flex: 1,),

                          ],
                        )
                    ),
                ),

          Obx(() =>

          controller.stockReceiveResponse.value.distribution_list != null ?
          controller.stockReceiveResponse.value.distribution_list!.length! > 0 ?
          Expanded(child: ListView.builder(
                    itemCount:  controller.stockReceiveResponse.value.distribution_list?.length,
                    //itemCount: 15,
                    //primary: false,
                    shrinkWrap: true,

                    itemBuilder: (BuildContext context, int index) {
                      var data =  controller.stockReceiveResponse.value.distribution_list?[index];
                      var sl = index+1;
                      return InkWell(
                        onTap: (){

                          controller.get_stock_Receive_medicine(data!.id.toString());
                          showCustomDialog(context,data!.id.toString());
                        },
                        child: Card(
                            elevation: 5,
                            margin: EdgeInsets.only(top: 20),
                            child: Container(
                              // padding: EdgeInsets.all(10),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(

                                      decoration: BoxDecoration(
                                          border: Border(right: BorderSide(color: Colors.grey.withOpacity(0.3)))
                                      ),
                                      child: Column(
                                        children: [
                                          Text(''+data!.dispensary_name.toString()),
                                          //Text('15-11-22'),
                                        ],
                                      ),
                                      padding:EdgeInsets.only(right: 5,left: 5,top: 10,bottom: 10) ,
                                    ),flex: 3,),

                                  Expanded(child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(right: BorderSide(color: Colors.grey.withOpacity(0.3)))
                                    ),
                                    child: Column(
                                      children: [
                                        Text('Date:'),
                                        Text(''+data!.supply_date.toString()),
                                      ],
                                    ),
                                    padding:EdgeInsets.only(right: 5,left: 5,top: 10,bottom: 10) ,
                                  ),flex: 2,),

                                  Expanded(child: Container(
                                    decoration: BoxDecoration(
                                      //  border: Border(right: BorderSide(color: Colors.grey.withOpacity(0.3)))
                                    ),
                                    child: Container(

                                      child: InkWell(
                                        child: Text('Receive',style: TextStyle(fontSize: 10,color: Colors.white),),
                                        onTap: (){
                                          controller.get_stock_Receive_medicine(data.id.toString());
                                          showCustomDialog(context,data.id.toString());
                                        },
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.all(Radius.circular(5))
                                      ),
                                      padding: EdgeInsets.all(3),
                                      alignment: Alignment.center,
                                    ),
                                    padding:EdgeInsets.only(right: 5,left: 5,top: 5,bottom: 5) ,
                                  ),flex: 1,),
                                ],
                              ),
                            )
                          // child: Container(
                          //   padding: EdgeInsets.all(10),
                          //   alignment: Alignment.centerLeft,
                          //   child: Row(
                          //     children: [
                          //       Text(''+sl.toString()),
                          //       SizedBox(width: 10,),
                          //       Column(
                          //         mainAxisAlignment: MainAxisAlignment.start,
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           SizedBox(
                          //             width: 300,
                          //             child: Text(''+data!.drug_name.toString()),
                          //           ),
                          //           SizedBox(height: 5,),
                          //           // Row(
                          //           //   children: [
                          //           Text('Available Stock: '+data!.available_stock.toString(),style: TextStyle(fontSize: 12),),
                          //           SizedBox(height: 5,),
                          //           Text('Stock Request: 0',style: TextStyle(fontSize: 12),),
                          //           //   ],
                          //           // )
                          //         ],
                          //       )
                          //
                          //     ],
                          //   ),
                          // )
                        ),
                      );
                    }),)
              :Container(height:300,alignment:Alignment.center,child: Text('No data found'),)
              :Container(height:300,alignment:Alignment.center,child: Text('No data found'),)
          )

                // Container(
                //   height: Get.height-150,
                //   ),


              ],
            ),

          //),

        ),

      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     // Add your onPressed code here!
      //     controller.approveStockReceive(context);
      //   },
      //   label: Text('Approve'),
      //   //icon: Icon(Icons.thumb_up),
      //   backgroundColor: Colors.blue,
      // )

    );
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();  //"6:00 AM"
    return format.format(dt);
  }

  void _showDialog(BuildContext context, String s) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Alert!!"),
          content: new Text(s),
          actions: <Widget>[
            new TextButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void _showToast(BuildContext context , String s) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content:  Text(''+s),
        action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate)
      //setState(() {
        selectedDate = selected;
   // var now = new DateTime.now();
    //var formatter = new DateFormat('yyyy-MM-dd');
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(selectedDate);
    print(formattedDate);
    txt.text = formattedDate.toString();
      //});
  }

  void showCustomDialog(BuildContext context, String stockout_master_id) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.white,
      transitionDuration: Duration(milliseconds: 100),
      pageBuilder: (_, __, ___) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size(60,55),
            child:  AppBar(
              backgroundColor: Colors.blueAccent,
              elevation: 0,
              centerTitle: true,
              //title: Text('Item Dispatch')

              title: Stack(alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    //child: Text(AppConstant.pageName),),
                    child: Text('Stock Receive'),),

                ],
              ),

            ),
          ),
          body: Container(

            height: context.height,
            width: context.width,
            child: Obx(() =>

            controller.stockReceiveMedicineResponse.value.medicine_list != null ?
            controller.stockReceiveMedicineResponse.value.medicine_list!.length! > 0 ?
            Expanded(child: ListView.builder(
                itemCount: controller.stockReceiveMedicineResponse.value.medicine_list?.length,
                primary: false,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  var data = controller.stockReceiveMedicineResponse.value.medicine_list?[index];
                  var sl = index+1;
                  return Container(
                   margin: EdgeInsets.only(top: 10),
                    child: Card(
                      elevation: 5,
                      child:Column(
                        children: [
                          Container(
                            color: Colors.grey,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(

                                    decoration: BoxDecoration(
                                        border: Border(right: BorderSide(color: Colors.grey.withOpacity(0.3)))
                                    ),
                                    child: Column(
                                      children: [
                                        Text(''+data!.drug_name!),
                                        //Text('15-11-22'),
                                      ],
                                    ),
                                    padding:EdgeInsets.only(right: 10,left: 10) ,
                                  ),flex: 2,),

                                Expanded(child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(right: BorderSide(color: Colors.grey.withOpacity(0.3)))
                                  ),
                                  child: Column(
                                    children: [
                                     //Text('Appr qty: '+data.approved_qty.toString()),

                                    ],
                                  ),
                                  padding:EdgeInsets.only(right: 10,left: 10) ,
                                ),flex: 1,),

                              ],
                            ),
                          ),
                          data.stockout_details!.length > 0?
                         ListView.builder(
                             itemCount: data.stockout_details!.length,
                             primary: false,
                             shrinkWrap: true,
                             physics: NeverScrollableScrollPhysics(),
                             itemBuilder: (BuildContext context, int index2) {

                               data.stockout_details![index2].receive_qty = data.stockout_details![index2].supplied_qty;
                               return Container(
                                 color: Colors.white,
                                 padding: EdgeInsets.all(5),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text('Batch no: '+data.stockout_details![index2].batch_no.toString()),

                                     SizedBox(height: 5,),

                                     Row(
                                       children: [
                                         Expanded(
                                           child: Container(

                                             // decoration: BoxDecoration(
                                             //   border: Border(right: BorderSide(color: Colors.grey,width: 1)),
                                             //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                             // ),
                                             child: TextField (
                                               keyboardType: TextInputType.number,
                                               controller: TextEditingController()..text = data.stockout_details![index2].supplied_qty.toString(),
                                               decoration: InputDecoration(
                                                   border: OutlineInputBorder(borderSide: BorderSide(width: 1,color: Colors.grey),
                                                       borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                   labelText: 'Receive qty',
                                                   hintText: 'Receive qty',
                                               ),
                                               onChanged: (content) {
                                                 //if(data.stockout_details!.length > 0){
                                                 if(content.isNotEmpty){
                                                   if(int.parse(content) > int.parse(data.approved_qty.toString())){
                                                     _showToast(context, 'Receive quantity must be less than or equal approve quantity');
                                                   }
                                                 }
                                                 data.stockout_details![index2].receive_qty = content;
                                                 print('receive_qty: '+data.stockout_details![index2].receive_qty.toString());
                                                 // }
                                               },

                                               style: TextStyle(fontSize: 12),

                                             ),
                                             alignment: Alignment.center,
                                             height: 40,
                                             padding:EdgeInsets.only(right: 2,left: 2) ,
                                           ),flex: 1,),

                                         Expanded(child: Container(
                                           // decoration: BoxDecoration(
                                           //   border: Border(right: BorderSide(color: Colors.grey.withOpacity(0.3))),
                                           //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                           // ),
                                           child: TextField (
                                             keyboardType: TextInputType.number,
                                             //controller: rejectQtyEditControler,
                                             onChanged: (content) {
                                               //if(data.stockout_details!.length > 0){
                                               data.stockout_details![index2].reject_qty = content;
                                               print('Reject qty: '+data.stockout_details![index2].reject_qty.toString());
                                               //}
                                             },

                                             decoration: InputDecoration(
                                                 border: OutlineInputBorder(borderSide: BorderSide(width: 1,color: Colors.grey),
                                                     borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                 labelText: 'Reject qty',
                                                 hintText: 'Reject qty'
                                             ),
                                             style: TextStyle(fontSize: 12),
                                           ),
                                           padding:EdgeInsets.only(right: 2,left: 2),
                                           height: 40,
                                         ),flex: 1,),

                                         Expanded(child: Container(

                                           child: TextField (
                                             onChanged: (content) {
                                               //if(data.stockout_details!.length > 0){
                                               data.stockout_details![index2].reject_reason = content;
                                               print('Reject Reason: '+data.stockout_details![index2].reject_reason.toString());
                                               //}
                                             },
                                             //controller: rejectReasonEditControler,
                                             decoration: InputDecoration(
                                                 border: OutlineInputBorder(borderSide: BorderSide(width: 1,color: Colors.grey),
                                                     borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                 labelText: 'Reject Reason',
                                                 hintText: 'Reject Reason'
                                             ),
                                             style: TextStyle(fontSize: 12),
                                           ),

                                           padding:EdgeInsets.only(right: 2,left: 2) ,
                                           height: 40,
                                         ),flex: 1,),

                                       ],
                                     ),

                                     SizedBox(height: 5,),
                                   ],
                                 )

                               );
                             }) :SizedBox(),
                        ],
                      )
                    )
                  );
                }),)
                :Container(height:300,alignment:Alignment.center,child: Text('No data found'),)
                :Container(height:300,alignment:Alignment.center,child: Text('No data found'),)
            )
          ),

            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                // Add your onPressed code here!
                controller.approveStockReceive(context,stockout_master_id);
              },
              label: Text('Approve'),
              //icon: Icon(Icons.thumb_up),
              backgroundColor: Colors.blue,
            )

        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

}


class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    int curveHeight = 40;
    Offset controlPoint = Offset(size.width / 2, size.height + curveHeight);
    Offset endPoint = Offset(size.width, size.height - curveHeight);

    Path path = Path()
      ..lineTo(0, size.height - curveHeight)
      ..quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

