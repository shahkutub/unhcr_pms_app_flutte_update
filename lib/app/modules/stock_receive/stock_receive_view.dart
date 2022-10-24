

import 'package:brac_arna/app/modules/current_stock/current_stock_controller.dart';
import 'package:brac_arna/app/modules/stock_receive/stock_receive_controller.dart';
import 'package:brac_arna/common/AppConstant.dart';
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

          controller.druglistResonse.value.dispatch_items != null ?
          controller.druglistResonse.value.dispatch_items!.length! > 0 ?
          Expanded(child: ListView.builder(
                    itemCount: controller.druglistResonse.value.dispatch_items?.length,
                    //itemCount: 15,
                    //primary: false,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      var data = controller.druglistResonse.value.dispatch_items?[index];
                      var sl = index+1;
                      return Card(
                        
                        child: Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text(''+sl.toString()),
                              SizedBox(width: 10,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 300,
                                    child: Text(''+data!.drug_name.toString()),
                                  ),
                                  SizedBox(height: 5,),
                                  // Row(
                                  //   children: [
                                  Text('Available Stock: '+data!.available_stock.toString(),style: TextStyle(fontSize: 12),),
                                  SizedBox(height: 5,),
                                  Text('Stock Request: 0',style: TextStyle(fontSize: 12),),
                                  //   ],
                                  // )
                                ],
                              )

                            ],
                          ),
                        )
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

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: Text('Approve'),
        //icon: Icon(Icons.thumb_up),
        backgroundColor: Colors.blue,
      )

    );
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

