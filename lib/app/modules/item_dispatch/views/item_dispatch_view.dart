

import 'package:brac_arna/app/modules/item_dispatch/controllers/item_dispatch_controller.dart';
import 'package:brac_arna/app/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../../models/drug_list_response.dart';
import '../../../routes/app_pages.dart';


class ItemDispatchView extends GetView<ItemDispatchController>{
  final _size = Get.size;

  @override
  Widget build(BuildContext context) {
    Get.find<ItemDispatchController>();
    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    TextEditingController fieldTextEditingController;
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

    // Initial Selected Value
    String dropdownvalue = 'Item 1';

    // List of items in our dropdown menu
    var items = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
    ];


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
                  child: Text('Dispatch'),),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(Routes.All_DISPATCH);
                  },
                  child:Container(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.account_circle_sharp),
                  ) ,
                )

              ],
            ),

          ),
        ),
        body:Container(
          margin: EdgeInsets.all(20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                SizedBox(
                  height: 5,
                ),

                Stack(
                  children: <Widget>[
                    Align(alignment: Alignment.centerRight,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(0),
                        // decoration: BoxDecoration(
                        //   border:Border.all(color: Colors.blueAccent) ,
                        //   borderRadius: BorderRadius.all(Radius.circular(20)),
                        // ),

                        child: Stack(
                          children: <Widget>[
                            Align(alignment: Alignment.centerLeft,
                              child:  Obx(() =>
                                  Text(
                                    "PATIENT SL NO: "+controller.pSerialN0.value,
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal,fontSize: 12),
                                  ),
                              ),

                            ),
                            Align(alignment: Alignment.centerRight,
                                child:
                                //Obx(() =>
                                    Text(
                                      "DATE: "+Utils.getCurrentDate(),
                                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal,fontSize: 12),
                                    ),
                                //),

                            ),

                          ],
                        ),


                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: 15,
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
                                  controller.controllerAvailableQty.value.text = element.available_stock!;
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
                            readOnly: true,
                            controller: controller.controllerAvailableQty.value,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Available qty',
                              hintText: controller.controllerAvailableQtyLabelText.value,
                            ),
                          ), flex: 1,),

                          SizedBox(
                            width: 20,
                          ),

                          Expanded(child: TextField(
                            keyboardType: TextInputType.number,
                            controller: controller.dispatchQtyController.value,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Dispatch qty',
                              hintText: '',
                            ),
                            onChanged: (value){

                            },
                          ), flex: 1,)

                        ],
                      ),


                      Container(
                        margin: EdgeInsets.only(top: 20),
                        alignment: Alignment.topRight,
                        child: TextButton(

                          //padding: EdgeInsets.only(top: 13,bottom: 13,left: 35,right: 35),
                          //color: Color(0xff03A1E0),
                          child: Text('Add',style: TextStyle(color: Colors.white),),
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                          onPressed: () {
                            //FocusScope.of(context).unfocus();
                            //controller.etSkillScore1Key.value.currentState!.reset();
                            //FocusManager.instance.primaryFocus?.unfocus();
                            controller.itemQty.value = int.parse(controller.dispatchQtyController.value.text);
                            if (controller.itemName.value.isEmpty) {
                              Utils.showToast('Enter medicine item name!');
                            }else if(controller.itemQty.value == 0){
                              Utils.showToast('Enter dispatch quantity!');
                            }else{
                              controller.selected_spinner_item.value = "Select item";
                              controller.controllerAvailableQty.value.text = "0";
                              controller.addItemToList();
                              controller.dispatchQtyController.value.text = "0";
                              controller.itemName.value = "";

                            }
                            FocusScope.of(context).unfocus();
                            //controller.etSkillScore1Key.value.currentState!.dispose();
                          },

                        ),

                      ),
                    ],
                  ),
                ),
             //Obx(() =>

            // ),



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
                              Expanded(child:  Text("ITEM DESCRIPTION",style: TextStyle(color: Color(0xff03A1E0),fontSize: 12),), flex: 10,),
                              Expanded(child:  Center(child: Text("QTY",style: TextStyle(color: Color(0xff03A1E0),fontSize: 12),),), flex: 2,),
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
                                  Expanded(child:  Text(""+controller.itemList[index].medicine_name,style: TextStyle(color: Colors.grey,fontSize: 12),), flex: 10,),
                                  Expanded(child:  Center(child: Text(""+controller.itemList[index].medicine_qty.toString(),style: TextStyle(color: Colors.black,fontSize: 12),),), flex: 2,),
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
                      GestureDetector(
                        onTap: () {

                          // controller.submit_dispatch(context);
                          //
                          // controller.itemList.forEach((element) {
                          //   controller.insert_item_dispatch_ToLocalDB(element);
                          // });
                          // controller.insert_patient_serialToLocalDB();
                          // controller.itemList.clear();
                          // _showToast(context,'Item dispatch stored Successfully');
                          _showDialog(context);
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
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Submit Medicine",style: TextStyle(color: Color(0xff03A1E0)),),
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
                Text("Are you sure you want to dispatch your medicine?"),
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

               // controller.submit_dispatch(context);

                controller.itemList.forEach((deductData) {
                  controller.insert_item_dispatch_ToLocalDB(deductData);
                  controller.drugList.forEach((element2) {
                    if(element2.drug_id == deductData.medicine_id.toString()){
                      print('drug_id'+element2.drug_id.toString());
                      print('medicine_id'+deductData.medicine_id.toString());
                      int deductQty = int.parse(element2.available_stock!) - deductData.medicine_qty;

                      controller.updateDrugAvailableQty(deductData.medicine_id,deductQty);
                    }

                  });

                });



                controller.insert_patient_serialToLocalDB();
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
  // void _showToast(BuildContext context , String s) {
  //   final scaffold = ScaffoldMessenger.of(context);
  //   scaffold.showSnackBar(
  //     SnackBar(
  //       content:  Text(''+s),
  //       action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
  //     ),
  //   );
  // }

  void showSubmitDialoge(BuildContext context){
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(context)
            .modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext,
            Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 10,
              height: MediaQuery.of(context).size.height -  80,
              padding: EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                children: [
                  TextButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),

                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                    //color: const Color(0xFF1BC0C5),
                  )
                ],
              ),
            ),
          );
        });
  }


}

