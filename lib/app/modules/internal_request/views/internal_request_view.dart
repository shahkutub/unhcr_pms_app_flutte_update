

import 'dart:math';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
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
                  //child: Text(AppConstant.pageName),),
                  child: Text('Internal Request'),),

              ],
            ),

          ),
        ),
      //resizeToAvoidBottomInset: true,
      body: Container(
        height: context.height,
        width: context.width,
        child: Obx(() =>

        controller.internalReqListDistinck != null ?
        controller.internalReqListDistinck!.length! > 0 ?


        Expanded(child: ListView.builder(
            itemCount:  controller.internalReqListDistinck?.length,
            //itemCount: 15,
            //primary: false,
            shrinkWrap: true,

            itemBuilder: (BuildContext context, int index) {
              var data =  controller.internalReqListDistinck?[index];
              var sl = index+1;
              return InkWell(
                onTap: (){
                  // controller.get_stock_Receive_medicine(data!.id.toString());
                  // showCustomDialog(context);
                },
                child: Card(
                    elevation: 5,
                    margin: EdgeInsets.only(top: 20),
                    child: Container(
                      // padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(

                              decoration: BoxDecoration(
                                  //border: Border(right: BorderSide(color: Colors.grey.withOpacity(0.3)))
                              ),
                              child: Column(
                                children: [
                                  Text('Serial:\n'+data!.serial.toString()),
                                  //Text('15-11-22'),
                                ],
                              ),
                              padding:EdgeInsets.only(right: 5,left: 5,top: 10,bottom: 10) ,
                            ),flex: 1,),

                          Expanded(child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                //border: Border(right: BorderSide(color: Colors.grey.withOpacity(0.3)))
                            ),
                            child: Column(
                              children: [
                                Text('Date:'),
                                Text(''+data!.date.toString()),
                              ],
                            ),
                            padding:EdgeInsets.only(right: 5,left: 5,top: 10,bottom: 10) ,
                          ),flex: 2,),

                          Expanded(child: Container(
                            decoration: BoxDecoration(
                              //  border: Border(right: BorderSide(color: Colors.grey.withOpacity(0.3)))
                            ),
                            child: Column(
                              children: [
                                Container(

                                  child: InkWell(
                                    child: Text('View',style: TextStyle(fontSize: 10,color: Colors.white),),
                                    onTap: (){
                                      // controller.get_stock_Receive_medicine(data.id.toString());

                                    },
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.all(Radius.circular(5))
                                  ),
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                ),
                                SizedBox(height: 10,),
                                Container(

                                  child: InkWell(
                                    child: Text('Receive',style: TextStyle(fontSize: 10,color: Colors.white),),
                                    onTap: (){
                                      controller.get_internal_request_list_by_serial(data.serial);
                                      showCustomDialogInternalApprove(context,'');
                                    },
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.all(Radius.circular(5))
                                  ),
                                  padding: EdgeInsets.only(top: 10,bottom: 10),
                                  alignment: Alignment.center,
                                ),
                              ],
                            ),

                            padding:EdgeInsets.only(right: 5,left: 5,top: 10,bottom: 10) ,
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
        ),
      ),

        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showCustomDialog( context);
          },
          label: Text('Add'),
          //icon: Icon(Icons.thumb_up),
          backgroundColor: Colors.blue,
        )



    );
  }

  void showCustomDialog(BuildContext context) {
    var rng = new Random();
    var code = rng.nextInt(900000) + 100000;
    print('random: '+code.toString());
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
                      child: Text('Internal Request'),),

                  ],
                ),

              ),
            ),
            body:
          Container(
            margin: EdgeInsets.all(10),
            child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "Request No: ${controller.internalRequestNumber.toString()}",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal,fontSize: 15),),
                  ),

                  SizedBox(
                    height: 10,
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
                              _showDialogInternalRequest(context,controller.internalRequestNumber.toString());
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



  void _showDialogInternalRequest(BuildContext context,String serial) {
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
                  controller.insert_internal_request(element,serial);

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

  void showCustomDialogInternalApprove(BuildContext context, String stockout_master_id) {
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
                      child: Text('Internal request Receive'),),

                  ],
                ),

              ),
            ),
            body: Container(
              margin: EdgeInsets.all(10),

                height: context.height,
                width: context.width,
                child: Obx(() =>

                controller.internal_receive_medicine_list != null ?
                controller.internal_receive_medicine_list!.length! > 0 ?
                Expanded(child:
                controller.internal_receive_medicine_list!.length > 0?
                ListView.builder(
                    itemCount: controller.internal_receive_medicine_list!.length,
                    primary: false,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index2) {
                      var data = controller.internal_receive_medicine_list[index2];
                      print('receqty: '+data.receive_qty.toString());

                      //data.receive_qty = data.supplied_qty;
                      return Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(''+data.drug_name.toString()),

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
                                        controller: TextEditingController()..text = data.receive_qty.toString(),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(borderSide: BorderSide(width: 1,color: Colors.grey),
                                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                          labelText: 'Receive qty',
                                          hintText: 'Receive qty',
                                        ),
                                        onChanged: (content) {
                                          //if(data.stockout_details!.length > 0){

                                          data.receive_qty = content;
                                          print('receive_qty: '+data.receive_qty.toString());
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
                                        data.reject_qty = content;
                                        print('Reject qty: '+data.reject_qty.toString());
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
                                        data.reject_reason = content;
                                        print('Reject Reason: '+data.reject_reason.toString());
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
                    }) :SizedBox(),)
                    :Container(height:300,alignment:Alignment.center,child: Text('No data found'),)
                    :Container(height:300,alignment:Alignment.center,child: Text('No data found'),)
                )
            ),

            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                // Add your onPressed code here!
                controller.approveStockReceive(context,stockout_master_id);
              },
              label: Text('Receive'),
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

