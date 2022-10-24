import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class IconModel {
  String? title;
  String? subTitle;
  String? image;
  String? value;
  VoidCallback? press;

  IconModel({this.title, this.subTitle, this.image, this.value, this.press});
}

List<IconModel> homeImage = [
  IconModel(title: 'Type of violence', subTitle: 'বাল্যবিবাহ', value: '10', image: "assets/images/background.jpeg", press: () {}),
  IconModel(title: 'Cause of the violence', subTitle: 'যৌতুক', value: '12', image: "assets/images/pvawg-2.jpeg", press: () {}),
  IconModel(title: 'Age-based violence', subTitle: 'বাল্যবিবাহ', value: '6', image: "assets/images/pvawg-3.jpeg", press: () {}),
  IconModel(title: 'Types of criminals', subTitle: 'ড্রাইভার', value: '15', image: "assets/images/pvawg-4.jpeg", press: () {}),
];

List<IconModel> population = [
  IconModel(title: 'Population', value: '143932513', image: "assets/images/background.jpeg", press: () {}),
  IconModel(title: 'Rural population', value: '76.66%', image: "assets/images/pvawg-2.jpeg", press: () {}),
  IconModel(title: 'Total family', value: '32133507', image: "assets/images/pvawg-3.jpeg", press: () {}),
  IconModel(title: 'Number of events', value: '286', image: "assets/images/pvawg-4.jpeg", press: () {}),
];
