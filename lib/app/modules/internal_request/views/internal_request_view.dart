

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:getwidget/components/search_bar/gf_search_bar.dart';
import 'package:intl/intl.dart';

import '../controllers/internal_request_controller.dart';


class InternalRequestView extends GetView<InternalRequestController>{
  final _size = Get.size;
  String date = "";
  DateTime selectedDate = DateTime.now();
  var txt = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Get.find<InternalRequestController>();
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


                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          color: Colors.white
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Flexible(
                                  child:DropdownSearch<String>(
                                    //mode of dropdown
                                    mode: Mode.MENU,
                                    //to show search box
                                    showSearchBox: true,
                                    //showSelectedItem: true,
                                    //list of dropdown items
                                    items: [
                                      "India",
                                      "USA",
                                      "Brazil",
                                      "Canada",
                                      "Australia",
                                      "Singapore"
                                    ],
                                    label: "Partner",
                                    onChanged: print,
                                    //show selected item
                                    selectedItem: "Select..",
                                  ),flex: 1,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Flexible(
                                  child:DropdownSearch<String>(
                                    //mode of dropdown
                                    mode: Mode.MENU,
                                    //to show search box
                                    showSearchBox: true,
                                    //showSelectedItem: true,
                                    //list of dropdown items
                                    items: [
                                      "India",
                                      "USA",
                                      "Brazil",
                                      "Canada",
                                      "Australia",
                                      "Singapore"
                                    ],
                                    label: "Facility",
                                    onChanged: print,
                                    //show selected item
                                    selectedItem: "Select..",
                                  ),flex: 1,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child:DropdownSearch<String>(
                                    //mode of dropdown
                                    mode: Mode.MENU,
                                    //to show search box
                                    showSearchBox: true,
                                    //showSelectedItem: true,
                                    //list of dropdown items
                                    items: [
                                      "India",
                                      "USA",
                                      "Brazil",
                                      "Canada",
                                      "Australia",
                                      "Singapore"
                                    ],
                                    label: "Dispensary",
                                    onChanged: print,
                                    //show selected item
                                    selectedItem: "Select..",
                                  ),flex: 1,
                                ),

                                SizedBox(
                                  width: 2,
                                ),

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
                                      controller: txt,
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
                          Text(
                            "Medicine",
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.normal,fontSize: 12),
                          ),
                          Container(
                            //margin: EdgeInsets.only(top: 0,bottom: 0,right: 10,left: 10),
                            padding: EdgeInsets.only(top: 0,bottom: 0,right: 10,left: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.blueAccent,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                            child:Stack(alignment: Alignment.center,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Autocomplete<String>(
                                    optionsBuilder: (TextEditingValue value) {
                                      // When the field is empty
                                      if (value.text.isEmpty) {
                                        return [];
                                      }

                                      // The logic to find out which ones should appear
                                      return controller.names.where((suggestion) =>
                                          suggestion.toLowerCase().contains(value.text.toLowerCase()));

                                    },
                                    onSelected: (value) {
                                      controller.itemName.value = value;
                                      // setState(() {
                                      //   _selectedAnimal = value;
                                      // });
                                    },


                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.search),

                                  // Column(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   crossAxisAlignment: CrossAxisAlignment.center,
                                  //   children: [
                                  //
                                  //     Obx(() => Text(""+controller.userNAme.value,
                                  //       style: TextStyle(color: Colors.white,fontSize: 12),
                                  //       textAlign:TextAlign.center,
                                  //     ),
                                  //     ),
                                  //
                                  //     Obx(
                                  //           () => Text(""+controller.userRole.value,
                                  //         style: TextStyle(color: Colors.white,fontSize: 12),
                                  //         textAlign:TextAlign.center,
                                  //       ),
                                  //     ),
                                  //
                                  //
                                  //   ],
                                  // ),
                                )
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                            crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
                            children: <Widget>[
                              new Flexible(child: Container(
                                //height: 50,
                                //width: 140,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Enter Date Here',
                                    hintText: '00-00-0000',
                                  ),
                                  autofocus: false,
                                  enabled: true,
                                  controller: txt,
                                ),
                              ), flex: 2,),
                              SizedBox(
                                width: 5,
                              ),
                              new Flexible(
                                child: Container(
                                  //width: 140,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Center(
                                      child: Container(
                                        //width: 60.0,
                                        foregroundDecoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),
                                          border: Border.all(
                                            color: Colors.blueAccent,
                                            //width: 2.0,
                                          ),
                                        ),
                                        child: Row(
                                          children: <Widget>[

                                            Expanded(
                                              flex: 1,
                                              child: TextFormField(
                                                textAlign: TextAlign.center,
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.all(8.0),
                                                  border:InputBorder.none,
                                                  // OutlineInputBorder(
                                                  //   borderRadius: BorderRadius.circular(5.0),
                                                  // ),
                                                ),
                                                controller: controller.controllerQty.value,
                                                keyboardType: TextInputType.numberWithOptions(
                                                  decimal: false,
                                                  signed: true,
                                                ),
                                                //onChanged: ,
                                                style: TextStyle(color: Colors.black,fontSize: 20),
                                              ),
                                            ),
                                            Container(
                                              //height: 58.0,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                          width: 0.5,
                                                        ),
                                                      ),
                                                    ),
                                                    child: InkWell(
                                                      child: Icon(
                                                        Icons.arrow_drop_up,
                                                        size: 28.0,
                                                      ),
                                                      onTap: () {
                                                        int currentValue = int.parse(controller.controllerQty.value.text);
                                                        controller.itemQty.value = currentValue.toString();
                                                        //setState(() {
                                                        currentValue++;
                                                        controller.controllerQty.value.text = (currentValue)
                                                            .toString(); // incrementing value
                                                        //});
                                                      },
                                                    ),
                                                  ),
                                                  InkWell(
                                                    child: Icon(
                                                      Icons.arrow_drop_down,
                                                      size: 28.0,
                                                    ),
                                                    onTap: () {
                                                      int currentValue = int.parse(controller.controllerQty.value.text);
                                                      controller.itemQty.value = currentValue.toString();
                                                      //setState(() {
                                                      print("Setting state");
                                                      currentValue--;
                                                      controller.controllerQty.value.text =
                                                          (currentValue > 0 ? currentValue : 0)
                                                              .toString(); // decrementing value
                                                      //});
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ), flex: 2,),
                              SizedBox(
                                width: 5,
                              ),
                              new Flexible(child:
                              Column(
                                children: [
                                  // SizedBox(
                                  //   height: 20,
                                  // ),
                                  Container(
                                    //height: 45,
                                    child:  TextButton(
                                      //color: Colors.blueAccent,
                                      child: Text('Add',style: TextStyle(color: Colors.white),),
                                      onPressed: () {
                                        controller.itemQty.value = controller.controllerQty.value.text;

                                        if (controller.itemName.value.isEmpty) {
                                          //_showDialog(context,"Enter medicine name!");
                                          _showToast(context,'Enter medicine name!');

                                        }else if(controller.itemQty.value == "0"){
                                          //_showDialog(context,"Enter medicine quantity!");
                                          _showToast(context,'Enter medicine quantity!');
                                        }else{
                                          controller.addItemToList();
                                          controller.controllerQty.value.text = "0";
                                        }

                                      },

                                    ),
                                  ),

                                ],
                              ),
                                flex: 1,),
                            ],
                          ),
                        ],
                      ),
                    ),

                  ),
                ),



                SizedBox(
                  height:10,
                ),
                Obx(() {
                  if(controller.itemList.length==0){
                    return
                      GestureDetector(
                        onTap: () {
                          controller.insert_patient_serialToLocalDB();
                          controller.itemList.clear();
                          _showToast(context,'Added Successfully');
                          // Get.offAllNamed(Routes.INFORMATION_FORM);
                          //Get.offAllNamed(Routes.PROVIDED_DATA_LIST);

                          //Get.offAllNamed(Routes.AFTER_LOGIN);

                          // if (controller.loginFormKey.currentState!.validate()) {
                          //   controller.login();
                          // }
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 140,right: 140),
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                //Color(0xffec008c),
                                Color(0xff1A62AE),
                                //Colors.pinkAccent.shade100
                                Color(0xff1A62AE)
                                // Color.fromRGBO(143, 148, 251, 1),
                                // Color.fromRGBO(143, 148, 251, .6),
                              ])),
                          child: Center(
                            child: Text(
                              "Submit",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                  }else{
                    return SizedBox(
                      height: 0.0,
                    );
                  }

                }),
                SizedBox(
                  height: 10,
                ),


                //  Container(
                //    margin: EdgeInsets.only(
                //        left: width * 0.05, right: width * 0.05, top: 10),
                //
                //    child: Card(
                //      elevation: 5,
                //      color: Colors.white,
                //      shape: RoundedRectangleBorder(
                //        borderRadius: BorderRadius.circular(5),
                //      ),
                //      child: Container(
                //        width: width * 1,
                //        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                //        decoration: BoxDecoration(
                //            border: Border.all(color: Colors.blueAccent)
                //        ),
                //        child: Autocomplete<String>(
                //          optionsBuilder: (TextEditingValue value) {
                //            // When the field is empty
                //            if (value.text.isEmpty) {
                //              return [];
                //            }
                //
                //            // The logic to find out which ones should appear
                //            return controller.names.where((suggestion) =>
                //                suggestion.toLowerCase().contains(value.text.toLowerCase()));
                //          },
                //          onSelected: (value) {
                //            // setState(() {
                //            //   _selectedAnimal = value;
                //            // });
                //          },
                //
                //        ),
                //
                //        // TextField(
                //        //   textCapitalization: TextCapitalization.words,
                //        //   //onChanged: onSearchTextChanged,
                //        //   decoration: InputDecoration(
                //        //     hintText: 'Search Medicine', //getTranslated(context, searchMedicine_hint).toString(),
                //        //     hintStyle: TextStyle(
                //        //       fontSize: width * 0.04,
                //        //       color: Colors.blueAccent,
                //        //     ),
                //        //     suffixIcon: Padding(
                //        //       padding: const EdgeInsets.all(12),
                //        //       child: Icon(Icons.search_sharp, color: Colors.grey)
                //        //     ),
                //        //     border: InputBorder.none,
                //        //   ),
                //        // ),
                //      ),
                //    ),
                //  ),
                //
                // GFSearchBar(
                //     searchList: controller.names,
                //     searchQueryBuilder: (query, list) => list
                //         .where((item) {
                //       return item!.toString().toLowerCase().contains(query.toLowerCase());
                //     })
                //         .toList(),
                //     overlaySearchListItemBuilder: (dynamic item) => Container(
                //       padding: const EdgeInsets.all(8),
                //       child: Text(
                //         item,
                //         style: const TextStyle(fontSize: 18,color: Colors.black),
                //       ),
                //     ),
                //     onItemSelected: (dynamic item) {
                //       // setState(() {
                //       //   print('$item');
                //       // });
                //     }),

                SizedBox(
                  height: 10,
                ),


                Obx(() {
                  if(controller.itemList.length>0){
                    return
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child:Container(
                                padding:  EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.teal,
                                    border: Border.all(
                                      color: Colors.blueAccent,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(2))
                                ),
                                // height: 50,
                                //width: 160,
                                // color: controller.msgCount[index]>=10? Colors.blue[400]:
                                // controller.msgCount[index]>3? Colors.blue[100]: Colors.grey,
                                child: Center(
                                    child: Text('Medicine Name',
                                      style: TextStyle(fontSize: 15,color: Colors.white),

                                    )
                                ),
                              ),flex: 4,
                            ),

                            // Flexible(
                            //   child:Container(
                            //     // height: 50,
                            //     //width: 160,
                            //     margin: EdgeInsets.all(2),
                            //     // color: controller.msgCount[index]>=10? Colors.blue[400]:
                            //     // controller.msgCount[index]>3? Colors.blue[100]: Colors.grey,
                            //     child: Center(
                            //         child: Text('A.Qty',
                            //           style: TextStyle(fontSize: 18),
                            //         )
                            //     ),
                            //   ),flex: 1,
                            // ),

                            Flexible(
                              child:Container(
                                padding:  EdgeInsets.all(5),
                                margin: EdgeInsets.only(left: 1),
                                decoration: BoxDecoration(
                                    color: Colors.teal,
                                    border: Border.all(
                                      color: Colors.blueAccent,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(2))
                                ),
                                child: Center(
                                    child: Text('Qty',
                                      style: TextStyle(fontSize: 15,color: Colors.white),
                                    )
                                ),
                              ),flex: 2,
                            ),


                            Flexible(
                              child:Container(
                                padding:  EdgeInsets.all(5),
                                margin: EdgeInsets.only(left: 1),
                                decoration: BoxDecoration(
                                    color: Colors.teal,
                                    border: Border.all(
                                      color: Colors.blueAccent,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(2))
                                ),
                                child: Center(
                                    child: Text('Del',
                                      style: TextStyle(fontSize: 15,color: Colors.white),
                                    )
                                ),
                              ),flex: 1,
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


                // RaisedButton(
                //   child: Text('Add'),
                //   onPressed: () {
                //     controller.addItemToList();
                //   },
                // ),
                Expanded(
                    child: Obx(() => ListView.builder(
                        padding: const EdgeInsets.all(0),
                        //itemCount: controller.itemList.length,
                        itemCount: controller.itemList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Flexible(
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
                                  // height: 50,
                                  //width: 160,
                                  margin: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.blueAccent,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(2))
                                  ),
                                  child: Center(
                                      child: Text('${controller.itemList[index].name}',
                                        style: TextStyle(fontSize: 15),
                                        //textAlign: TextAlign.left,
                                      )
                                  ),
                                ), flex: 4,),

                              // Flexible(
                              //   child: Container(
                              //     padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              //     // height: 50,
                              //    // width: 100,
                              //     margin: EdgeInsets.all(5),
                              //     // color: controller.msgCount[index]>=10? Colors.blue[400]:
                              //     // controller.msgCount[index]>3? Colors.blue[100]: Colors.grey,
                              //     child: Center(
                              //         child: Text('${controller.itemList[index].availqty}',
                              //           style: TextStyle(fontSize: 18),
                              //         )
                              //     ),
                              //   ), flex: 1,),

                              Flexible(
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(0, 7, 0,7),
                                  margin: EdgeInsets.only(left: 1),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.blueAccent,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(2))
                                  ),
                                  child: Center(
                                      child: Text('${controller.itemList[index].qty}',
                                        style: TextStyle(fontSize: 15,),
                                        //textAlign: TextAlign.left,

                                      )
                                  ),
                                ),flex: 2,),

                              Flexible(
                                child: GestureDetector(
                                    onTap: () {
                                      controller.itemList.removeAt(index);
                                    },
                                    child:Container(
                                      padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                                      margin: EdgeInsets.only(left: 1),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors.blueAccent,
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(2))
                                      ),

                                      child: Center(
                                        child: Icon(Icons.cancel,color: Colors.red,
                                          size: 20,),
                                      ),)

                                ),flex: 1,
                              ),

                            ],
                          );
                        }
                    )
                    )
                ),

                SizedBox(
                  height: 10,
                ),

                Obx(() {
                  if(controller.itemList.length>0){
                    return
                      GestureDetector(
                        onTap: () {
                          controller.insert_patient_serialToLocalDB();
                          controller.itemList.clear();
                          _showToast(context,'Added Successfully');
                          // Get.offAllNamed(Routes.INFORMATION_FORM);
                          //Get.offAllNamed(Routes.PROVIDED_DATA_LIST);

                          //Get.offAllNamed(Routes.AFTER_LOGIN);

                          // if (controller.loginFormKey.currentState!.validate()) {
                          //   controller.login();
                          // }
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 140,right: 140),
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                //Color(0xffec008c),
                                Color(0xff1A62AE),
                                //Colors.pinkAccent.shade100
                                Color(0xff1A62AE)
                                // Color.fromRGBO(143, 148, 251, 1),
                                // Color.fromRGBO(143, 148, 251, .6),
                              ])),
                          child: Center(
                            child: Text(
                              "Submit",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                  }else{
                    return SizedBox(
                      height: 0.0,
                    );
                  }

                }),


                SizedBox(
                  height: 10,
                ),

              ]
          ),
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

