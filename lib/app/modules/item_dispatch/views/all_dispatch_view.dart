

import 'package:brac_arna/common/AppConstant.dart';
import 'package:brac_arna/common/ElementData.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:intl/intl.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

import '../controllers/all_dispatch_controller.dart';


class AllDispatchView extends GetView<AllDispatchController>{

  @override
  Widget build(BuildContext context) {
    Get.find<AllDispatchController>();

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;



    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size(60,60),
          child:  AppBar(
            backgroundColor: Color(0xff03A1E0),
            elevation: 0,
            centerTitle: true,
            //title: Text('Item Dispatch')

            title: Stack(alignment: Alignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Dispatch List',style: TextStyle(fontSize: 15)),),
                GestureDetector(
                  onTap: (){
                    controller.postRequestDispatch(context);
                  },
                  child:Container(
                      alignment: Alignment.centerRight,
                    // width: 100,
                      
                    child: Card(
                      color: Colors.teal,
                      elevation: 5,
                      child: Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: Colors.teal,
                            borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                          child: Text('Submit',style: TextStyle(fontSize: 12,color: Colors.white),)),
                    )
                  ) ,
                )

              ],
            ),

          ),
        ),
      //resizeToAvoidBottomInset: true,
        body:Container(
          margin: EdgeInsets.all(10),

            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               // Text('Top 10 Consumed Medicine'),
                SizedBox( height:10),
                Row(
                  children: <Widget>[
                    Expanded(child:  Center(child: Text("P.SL",style: TextStyle(color: Colors.blueAccent,fontSize: 12)),), flex: 1,),
                    Expanded(child:  Center(child: Text("DATE",style: TextStyle(color: Colors.blueAccent,fontSize: 12),)), flex: 2,),
                    Expanded(child:  Center(child: Text("ITEM",style: TextStyle(color: Colors.blueAccent,fontSize: 12),)), flex: 5,),
                    Expanded(child:  Center(child: Text("QTY",style: TextStyle(color: Colors.blueAccent,fontSize: 12),)), flex: 1,),
                  ],
                ),

          Obx(() =>
                Expanded(
                  child:
                  ListView.builder(
                    //itemCount: controller.drugList.length,
                    itemCount: controller.dispatchList.length,
                    //primary: false,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      var sl = index+1;
                      return Column(
                        children: [
                          SizedBox( height:25),
                      //Obx(() =>
                          Row(
                            children: <Widget>[
                              Expanded(child:  Center(child: Text(""+controller.dispatchList[index].serial_no.toString(),style: TextStyle(color: Colors.black,fontSize: 12),)), flex: 1,),
                              Expanded(child:  Center(child: Text(""+controller.dispatchList[index].date.toString(),style: TextStyle(color: Colors.black,fontSize: 12),)), flex: 2,),
                              Expanded(child:  Center(child: Text(""+controller.dispatchList[index].medicine_name.toString(),style: TextStyle(color: Colors.black,fontSize: 12),)), flex: 5,),
                              Expanded(child:  Center(child: Text(""+controller.dispatchList[index].medicine_qty.toString(),style: TextStyle(color: Colors.black,fontSize: 12),)), flex: 1,),
                            ],
                          ),
                      //)
                        ],

                      );
                    }),
                  // Obx(() =>
                  // StickyGroupedListView<ElementData, DateTime>(
                  //   elements: controller.elements,
                  //   order: StickyGroupedListOrder.ASC,
                  //   groupBy: (ElementData element) => DateTime(
                  //     element.date.year,
                  //     element.date.month,
                  //     element.date.day,
                  //   ),
                  //   groupComparator: (DateTime value1, DateTime value2) =>
                  //       value2.compareTo(value1),
                  //   itemComparator: (ElementData element1, ElementData element2) =>
                  //       element1.date.compareTo(element2.date),
                  //   floatingHeader: true,
                  //   groupSeparatorBuilder: _getGroupSeparator1,
                  //   itemBuilder: _getItem1,
                  // ),
                  // )

                  //Obx(() =>
                  // StickyGroupedListView<ItemDispatchModel, String>(
                  //   elements: controller.dispatchList,
                  //   order: StickyGroupedListOrder.ASC,
                  //   groupBy: (ItemDispatchModel element) => element.date!,
                  //   groupComparator: (String value1, String value2) =>
                  //       value2.compareTo(value1),
                  //   itemComparator: (ItemDispatchModel element1, ItemDispatchModel element2) =>
                  //       element1.date!.compareTo(element2.date!),
                  //   floatingHeader: true,
                  //   groupSeparatorBuilder: _getGroupSeparator,
                  //   itemBuilder: _getItem,
                  // ),
                   // ),

                )
        )

              ],
            ),

          ),




    );
  }

  Widget _getGroupSeparator(ItemDispatchModel element) {
    return Obx(() =>
      SizedBox(
      height: 50,
      child:
      //Obx(() =>
        Align(
        alignment: Alignment.center,
        child: Container(
          width: 120,
          decoration: BoxDecoration(
            color: Colors.blue[300],
            border: Border.all(
              color: Colors.blue[300]!,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
          child:
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${element.date}'),
          ),
        ),
      ),
      //)
    ) );
  }

  Widget _getItem(BuildContext ctx, ItemDispatchModel element) {
    return  Obx(() => Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child:
    //Obx(() =>
      SizedBox(
        child: ListTile(
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          // leading: Icon(element.icon),
          // title: Text(element.name),
          trailing:
                          Row(
                            children: <Widget>[
                              Expanded(child:  Center(child: Text(""+element.serial_no.toString(),style: TextStyle(color: Colors.black,fontSize: 12),)), flex: 1,),
                              Expanded(child:  Center(child: Text(""+element.date.toString(),style: TextStyle(color: Colors.black,fontSize: 12),)), flex: 2,),
                              Expanded(child:  Center(child: Text(""+element.medicine_name.toString(),style: TextStyle(color: Colors.black,fontSize: 12),)), flex: 5,),
                              Expanded(child:  Center(child: Text(""+element.medicine_qty.toString(),style: TextStyle(color: Colors.black,fontSize: 12),)), flex: 1,),
                            ],
                          ),
        ),
      )
   // )

    ));
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
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),

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

  Widget _getGroupSeparator1(ElementData element) {
    return SizedBox(
      height: 50,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 120,
          decoration: BoxDecoration(
            color: Colors.blue[300],
            border: Border.all(
              color: Colors.blue[300]!,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${element.date.day}. ${element.date.month}, ${element.date.year}',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getItem1(BuildContext ctx, ElementData element) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: SizedBox(
        child: ListTile(
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Icon(element.icon),
          title: Text(element.name),
          trailing: Text('${element.date.hour}:00'),
        ),
      ),
    );
  }

}


