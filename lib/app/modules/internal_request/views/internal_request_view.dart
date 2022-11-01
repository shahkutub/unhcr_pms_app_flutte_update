

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:getwidget/components/search_bar/gf_search_bar.dart';
import 'package:intl/intl.dart';

import '../../../utils.dart';
import '../controllers/internal_request_controller.dart';


class InternalRequestView extends GetView<InternalRequestController>{
  final _size = Get.size;
  String date = "";
  // DateTime selectedDate = DateTime.now();
  // var txtDate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Get.find<InternalRequestController>();
    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    //txtDate.text = "00-00-0000";
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
                  child: Text('N-PMS'),),
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
        body: Container(
          margin: EdgeInsets.all(10),
          child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    "Internal Request",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 15),),
                ),

                SizedBox(
                  height: 30,
                ),

                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Flexible(
                        child:GestureDetector(
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

                        flex: 1,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: controller.etSkillScore1Key.value,
                  child: Column(
                    children: <Widget>[
                      Obx(() =>
                          DropdownSearch<String>(
                            // key: controller.etSkillScore1Key.value,
                            //mode of dropdown
                            mode: Mode.DIALOG,
                            //to show search box
                            showSearchBox: true,
                            //selectedItem: true,
                            //list of dropdown items
                            //items: controller.itemlist,
                            items: controller.drugList?.map((item) => item.drug_name!).toList(),
                            label: "Item name",
                            onChanged: (value) {
                              controller.selected_spinner_item.value = value.toString();
                              controller.itemName.value = value.toString();

                              print('medname : '+controller.itemName.value);

                              controller.drugList.forEach((element) {
                                if(element.drug_name == value){
                                  controller.itemId.value = element.drug_id.toString();
                                  controller.remarkEditController.value.text = '';
                                }
                              });

                            },
                            //show selected item
                            selectedItem:  controller.selected_spinner_item.value,

                          ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      Row(
                        children: [
                          Expanded(child: TextField(
                            keyboardType: TextInputType.number,
                            // readOnly: true,
                            controller: controller.requestEditQtyController.value,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Request Qty',
                              hintText: controller.requestQtyLabelText.value,
                            ),
                            onChanged: (value){
                              controller.itemQty.value = int.parse(controller.requestEditQtyController.value.text);
                            },
                          ), flex: 1,),

                          SizedBox(
                            width: 20,
                          ),

                          Expanded(child: TextField(
                            keyboardType: TextInputType.text,
                            controller: controller.remarkEditController.value,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Remark',
                              hintText: '',
                            ),
                            onChanged: (value){
                              controller.remark.value = controller.remarkEditController.value.text;
                            },
                          ), flex: 1,)

                        ],
                      ),


                      Container(
                        margin: EdgeInsets.only(top: 20),
                        alignment: Alignment.topRight,
                        child: TextButton(
                          child: Text('Add',style: TextStyle(color: Colors.white),),
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                          onPressed: () {
                            controller.addItemToList();
                          },

                        ),

                      ),
                    ],
                  ),
                ),




                SizedBox(
                  height: 20,
                ),
                // Container(
                //   color: Colors.grey,
                //   height: 1,
                //   width: Get.width,
                // ),
                SizedBox(
                  height: 10,
                ),



                Obx(() {
                  if(controller.itemList.length>0){
                    return Container(


                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text('Top 10 Consumed Medicine'),
                          SizedBox( height:10),
                          Row(
                            children: <Widget>[
                              Expanded(child:  Text("SL",style: TextStyle(color: Color(0xff03A1E0),fontSize: 12),), flex: 1,),
                              Expanded(child:  Text("ITEM DESCRIPTION",style: TextStyle(color: Color(0xff03A1E0),fontSize: 12),), flex: 6,),
                              Expanded(child:  Center(child: Text("QTY",style: TextStyle(color: Color(0xff03A1E0),fontSize: 12),),), flex: 2,),
                              Expanded(child:  Center(child: Text("Remark",style: TextStyle(color: Color(0xff03A1E0),fontSize: 12),),), flex: 2,),
                              Expanded(child:  GestureDetector(

                                  child:Container(
                                    padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                                    margin: EdgeInsets.only(left: 1,top: 7),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      // border: Border.all(
                                      //   color: Colors.blueAccent,
                                      // ),
                                      //borderRadius: BorderRadius.all(Radius.circular(2))
                                    ),

                                    child: Center(
                                      child: Icon(Icons.remove_circle_outline,color: Colors.white,
                                        size: 15,),
                                    )
                                    ,)

                              ), flex: 1,),
                            ],
                          ),

                        ],
                      ),

                    );


                  }else{
                    return SizedBox(
                      height: 0.0,
                    );
                  }

                }),

                SizedBox(
                  height: 0,
                ),



                // list
                Expanded(
                    child: Obx(() => ListView.builder(
                        padding: const EdgeInsets.all(5),
                        //itemCount: controller.itemList.length,
                        itemCount: controller.itemList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var sl = index+1;
                          return Column(
                            children: [
                              SizedBox( height:10),
                              Row(
                                children: <Widget>[
                                  Expanded(child:  Text(""+sl.toString(),style: TextStyle(color: Colors.grey,fontSize: 12),), flex: 1,),
                                  Expanded(child:  Text(""+controller.itemList[index].medicine_name,style: TextStyle(color: Colors.grey,fontSize: 12),), flex: 6,),
                                  Expanded(child:  Center(child: Text(""+controller.itemList[index].medicine_qty.toString(),style: TextStyle(color: Colors.black,fontSize: 12),),), flex: 2,),
                                  Expanded(child:  Center(child: Text(""+controller.itemList[index].remark.toString(),style: TextStyle(color: Colors.black,fontSize: 12),),), flex: 2,),
                                  Expanded(child:  GestureDetector(
                                      onTap: () {
                                        controller.itemList.removeAt(index);
                                      },
                                      child:Container(
                                        padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                                        margin: EdgeInsets.only(left: 1,top: 7),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          // border: Border.all(
                                          //   color: Colors.blueAccent,
                                          // ),
                                          //borderRadius: BorderRadius.all(Radius.circular(2))
                                        ),

                                        child: Center(
                                          child: Icon(Icons.remove_circle_outline,color: Colors.red,
                                            size: 15,),
                                        ),)

                                  ), flex: 1,),
                                ],
                              ),
                            ],

                          );
                        }
                    )
                    )
                ),

                SizedBox(
                  height: 0,
                ),

                Obx(() {
                  if(controller.itemList.length>0){
                    return
                      InkWell(
                          onTap: () {
                             _showDialogInternalRequest(context);
                          },
                          child: Stack(
                            children: <Widget>[
                              Align(alignment: Alignment.center,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: Get.width,
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Color(0xff03A1E0),
                                    //border:Border.all(color: Colors.blueAccent) ,
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Text("Submit", style: TextStyle(color: Colors.white),),
                                ),
                              ),

                            ],
                          )

                      );
                  }else{
                    return SizedBox(
                      height: 0.0,
                    );
                  }

                }),


              ]
          ),
        ),
        
        
    );
  }

  void _showDialogInternalRequest(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Internal Request",style: TextStyle(color: Color(0xff03A1E0)),),
          content: Container(
            alignment: Alignment.center,
            height: Get.width/2.5,
            child: Column(

              children: [
                Container(
                  color: Colors.grey,
                  height: 1.0,
                ),
                SizedBox(height: 50,),
                Text("Are you sure you want to save internal request?"),
              ],
            ),
          ),

          actions: <Widget>[
            new TextButton(
              child: new Text("Cancel",style: TextStyle(color: Color(0xff03A1E0)),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new TextButton(
              // color: Color(0xff03A1E0),
              child: new Text("Yes,Submit",style: TextStyle(color: Colors.blue),),
              onPressed: () {

                controller.itemList.forEach((element) {
                  controller.insert_internal_request(element);

                });

                controller.itemList.clear();
                Navigator.pop(context);
                // _showToast(context,'Item dispatch stored Successfully');
              },
            ),
          ],
        );
      },
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

  }
}

