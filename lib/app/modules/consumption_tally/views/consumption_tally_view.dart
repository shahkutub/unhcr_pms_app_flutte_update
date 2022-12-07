

import 'package:brac_arna/app/modules/consumption_tally/controllers/consumption_tally_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:getwidget/components/search_bar/gf_search_bar.dart';
import 'package:intl/intl.dart';


class ConsumptionTallyView extends GetView<ConsumptionTallyController>{
  final _size = Get.size;
  String date = "";

  @override
  Widget build(BuildContext context) {
    Get.find<ConsumptionTallyController>();
    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
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
                child: Text('Tally'),),
              Container(
                alignment: Alignment.centerRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Obx(() => Text(""+controller.userNAme.value,
                      style: TextStyle(color: Colors.white,fontSize: 12),
                      textAlign:TextAlign.center,
                    ),
                    ),

                    Obx(
                          () => Text(""+controller.userRole.value,
                        style: TextStyle(color: Colors.white,fontSize: 12),
                        textAlign:TextAlign.center,
                      ),
                    ),


                  ],
                ),
              )
            ],
          ),
          //   Row(
          //   // mainAxisAlignment: MainAxisAlignment.end, //Center Row contents horizontally,
          //   // crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
          //   children: [
          //     // Container(
          //     //   //margin: EdgeInsets.only(left:20,top: 20),
          //     //   height: 50,
          //     //   width: 50,
          //     //   child:CircleAvatar(
          //     //     radius: 48, // Image radius
          //     //     backgroundImage: NetworkImage('imageUrl'),
          //     //   ) ,
          //     // ),
          //
          //     // SizedBox(
          //     //   width: 10,
          //     // ),
          //
          //
          //     Align(
          //       alignment: Alignment.centerRight,
          //       child:Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //
          //           Obx(
          //                 () => Text(""+controller.userNAme.value,
          //               style: TextStyle(color: Colors.white,fontSize: 12),
          //               textAlign:TextAlign.center,
          //             ),
          //           ),
          //
          //           Obx(
          //                 () => Text(""+controller.userRole.value,
          //               style: TextStyle(color: Colors.white,fontSize: 12),
          //               textAlign:TextAlign.center,
          //             ),
          //           ),
          //
          //
          //         ],
          //       ),
          //     ),
          //
          //
          //   ],
          // ),
        ),
      ),
      //resizeToAvoidBottomInset: true,
      body:Container(
        margin: EdgeInsets.all(10),
        child:Obx(() =>
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[



                  SizedBox(
                    height: 10,
                  ),

                  GestureDetector(
                    onTap: () { _selectDate(context);},
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Date Here',
                        hintText: '00-00-0000',
                      ),
                      autofocus: false,
                      enabled: false,
                      controller: controller.txt.value,
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),


                  Obx(() =>
                  controller.tallyitemListDistincByMedName.length > 0 ?
                  Expanded(child: ListView.builder(
                      itemCount: controller.tallyitemListDistincByMedName.length,
                      //itemCount: 15,
                      //primary: false,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        var data = controller.tallyitemListDistincByMedName[index];

                        final List<ItemDispatchModel> listPD = <ItemDispatchModel>[];

                        controller.tallyitemListDateBased.forEach((element) {
                          if(data.medicine_name == element.medicine_name){
                            listPD.add(element);
                          }
                        });


                        var sl = index+1;
                        var total = 0;
                        listPD.forEach((element) {
                          total = total+element.item_dispatch_quantity;
                        });
                        return Card(

                            child: Container(
                              padding: EdgeInsets.all(10),
                              //alignment: Alignment.centerLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(''+sl.toString()),
                                  SizedBox(height: 5,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(''+data.medicine_name,
                                        //style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),
                                      ),
                                      SizedBox(height: 10,),
                                      // Row(
                                      //   children: [
                                      //SizedBox(height: 5,),
                                      //   ],
                                      // )
                                    ],
                                  ),
                                  SizedBox(width: 10,),

                                  SizedBox(
                                    height: 100,
                                    child:GridView.builder(
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            childAspectRatio: 3
                                        ),
                                        itemCount: listPD.length,
                                        itemBuilder: (BuildContext context, int index2) {
                                          var data2 = listPD[index2];
                                          var sl = index2+1;

                                          return Container(
                                            child: Row(
                                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                //Text(''+sl.toString()),
                                                Text('P '+data2.patient_serial.toString()+" : "+data2.item_dispatch_quantity.toString()),
                                              ],
                                            ),

                                          );
                                        }),


                                    // ListView.builder(
                                    //   itemCount: listPD.length,
                                    //   //itemCount: 15,
                                    //   //primary: false,
                                    //   shrinkWrap: true,
                                    //   itemBuilder: (BuildContext context, int index2) {
                                    //     var data2 = listPD[index2];
                                    //     var sl = index2+1;
                                    //
                                    //   return Container(
                                    //           padding: EdgeInsets.all(10),
                                    //           alignment: Alignment.centerLeft,
                                    //           child: Row(
                                    //             children: [
                                    //               //Text(''+sl.toString()),
                                    //               Text('P '+data2.patient_serial.toString()+" : "+data2.item_dispatch_quantity.toString()),
                                    //             ],
                                    //           ),
                                    //
                                    //     );
                                    //   }),
                                    //
                                  ),

                                  SizedBox(width: 5,),
                                  Text('Total : '+total.toString()),
                                  SizedBox(width: 10,),


                                ],
                              ),
                            )
                        );
                      }),)
                      :Container(height:300,alignment:Alignment.center,child: Text('No data found'),)
                  )

                ]
            )),
      ),


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
      initialDate: controller.selectedDate.value,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != controller.selectedDate.value)
      //setState(() {
      controller.selectedDate.value = selected;
    // var now = new DateTime.now();
    //var formatter = new DateFormat('yyyy-MM-dd');
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(controller.selectedDate.value);
    print(formattedDate);
    controller.txt.value.text = formattedDate.toString();
    //controller.tallyDate.value = formattedDate.toString();
    //print('controller.tallyDate: '+controller.tallyDate.value.toString());
    controller.getItemDispatch(formattedDate.toString());

    //});
  }
}

