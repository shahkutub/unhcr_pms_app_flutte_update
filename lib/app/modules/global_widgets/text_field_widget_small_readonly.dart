/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/ui.dart';

class text_field_widget_small_readonly extends StatelessWidget {
  const text_field_widget_small_readonly(
      {Key? key,
      this.onSaved,
      this.onChanged,
      this.onTapped,
      this.validator,
      this.keyboardType,
      this.initialValue,
      this.hintText,
      this.errorText,
      this.iconData,
      this.labelText,
      this.obscureText,
      this.suffixIcon,
      this.isFirst,
      this.isLast,
      this.style,
      this.textAlign,
      this.suffix,
      this.limit})
      : super(key: key);

  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTapped;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final String? initialValue;
  final String? hintText;
  final String? errorText;
  final TextAlign? textAlign;
  final String? labelText;
  final TextStyle? style;
  final IconData? iconData;
  final bool? obscureText;
  final bool? isFirst;
  final bool? isLast;
  final Widget? suffixIcon;
  final Widget? suffix;
  final int? limit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
      margin: EdgeInsets.only(left: 10, right: 10, top: topMargin, bottom: bottomMargin),
      decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Get.theme.focusColor.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 5)),
          ],
          border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            labelText ?? "",
            style: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold),
            textAlign: textAlign ?? TextAlign.start,
          ),
          TextFormField(
            onTap: onTapped,
            keyboardType: keyboardType ?? TextInputType.multiline,
            onSaved: onSaved,
            //maxLength: limit,
            maxLines: null,
            onChanged: onChanged,
            validator: validator,
            initialValue: initialValue ?? '',
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal, fontSize: 10),
            obscureText: obscureText ?? false,
            textAlign: textAlign ?? TextAlign.start,
            readOnly: true,
            // decoration: Ui.getInputDecoration(
            //   hintText: hintText ?? '',
            //   iconData: iconData,
            //   suffixIcon: suffixIcon,
            //   suffix: suffix,
            //   errorText: errorText,
            // ),

              decoration:InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  // labelStyle: TextStyle(
                  //   color: Colors.black,
                  // )

              ),



          ),
        ],
      ),
    );
  }

  BorderRadius get buildBorderRadius {
    if (isFirst != null && isFirst!) {
      return BorderRadius.vertical(top: Radius.circular(10));
    }
    if (isLast != null && isLast!) {
      return BorderRadius.vertical(bottom: Radius.circular(10));
    }
    if (isFirst != null && !isFirst! && isLast != null && !isLast!) {
      return BorderRadius.all(Radius.circular(0));
    }
    return BorderRadius.all(Radius.circular(10));
  }

  double get topMargin {
    if ((isFirst != null && isFirst!)) {
      return 10;
    } else if (isFirst == null) {
      return 10;
    } else {
      return 0;
    }
  }

  double get bottomMargin {
    if ((isLast != null && isLast!)) {
      return 10;
    } else if (isLast == null) {
      return 10;
    } else {
      return 0;
    }
  }
}
