

import 'package:brac_arna/app/modules/consumption_tally/controllers/consumption_tally_controller.dart';
import 'package:brac_arna/app/modules/current_stock/current_stock_controller.dart';
import 'package:brac_arna/common/AppConstant.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:getwidget/components/search_bar/gf_search_bar.dart';
import 'package:intl/intl.dart';

import '../../services/auth_service.dart';


class CurrentStockView extends GetView<CurrentStockController>{
  final _size = Get.size;
  String date = "";
  DateTime selectedDate = DateTime.now();
  var txt = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Get.find<CurrentStockController>();
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
            backgroundColor: Color(0xff03A1E0),
              elevation: 0,
              centerTitle: true,
              //title: Text('Item Dispatch')

            title: Stack(alignment: Alignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(AppConstant.pageName),),
                // Container(
                //   alignment: Alignment.centerRight,
                //   child: Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             children: [
                //
                //               Obx(() => Text(""+controller.userNAme.value,
                //                   style: TextStyle(color: Colors.white,fontSize: 12),
                //                   textAlign:TextAlign.center,
                //                 ),
                //               ),
                //
                //               Obx(
                //                     () => Text(""+controller.userRole.value,
                //                   style: TextStyle(color: Colors.white,fontSize: 12),
                //                   textAlign:TextAlign.center,
                //                 ),
                //               ),
                //
                //
                //             ],
                //           ),
                // )
              ],
            ),

          ),
        ),
      //resizeToAvoidBottomInset: true,
        body:Container(
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
                Obx(() =>
                Expanded(child: ListView.builder(
                    itemCount: controller.drugList.length,
                    //itemCount: 15,
                    //primary: false,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      var data = controller.drugList[index];
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
                                    Text('Available Stock: '+data!.available_stock.toString(),style: TextStyle(fontSize: 12),),
                                    SizedBox(height: 5,),
                                    //Text('Stock Receive: '+data!.receive_stock.toString(),style: TextStyle(fontSize: 12),),
                                    SizedBox(height: 5,),
                                   // Text('Dispatch: '+data!.dispatch_stock.toString(),style: TextStyle(fontSize: 12),),

                                    // Stack(
                                    //   children: [
                                    //     Align(
                                    //       alignment: Alignment.centerRight,
                                    //       child:
                                    //
                                    //     ),
                                    //     Align(
                                    //       alignment: Alignment.centerLeft,
                                    //       child:Container(
                                    //         child: Row(
                                    //           children: [
                                    //             Text('Stock Receive: '+data!.receive_stock.toString(),style: TextStyle(fontSize: 12),),
                                    //             SizedBox(width: 10,),
                                    //             Text('Dispatch: '+data!.dispatch_stock.toString(),style: TextStyle(fontSize: 12),),
                                    //
                                    //           ],
                                    //         ),
                                    //       )
                                    //
                                    //     ),
                                    //   ],
                                    // )
                                  ],
                                )

                              ],
                            ),
                          )
                      );
                    }),))
              ],
            ),

          //),

        ),
      //   floatingActionButton: !controller.isStockSubmitted.value ?
      //   FloatingActionButton.extended(
      //   onPressed: () {
      //     Get.find<AuthService>().setIsCurrentStockSubmitted(true);
      //   },
      //   label: Text('Submit'),
      //   //icon: Icon(Icons.thumb_up),
      //   backgroundColor: Colors.blue,
      // ) : null,

        
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

  void _showYoutubeDialog(BuildContext context, String s) {
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


}

