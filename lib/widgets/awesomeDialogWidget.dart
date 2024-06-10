
import 'dart:async';
import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

showErrorDialog(BuildContext context, String title, String subtitle){
  double extraFontSize=0;

  AwesomeDialog(
    context: context,
    width: 500,
    dialogType: kIsWeb?DialogType.noHeader:DialogType.error,
    titleTextStyle: TextStyle(fontSize: 20+extraFontSize,fontWeight: FontWeight.w700,color: Colors.red),
    descTextStyle: TextStyle(fontSize: 17+extraFontSize,fontWeight: FontWeight.w300),
    headerAnimationLoop: false,
    animType: AnimType.scale,
    dismissOnBackKeyPress: true,
    dismissOnTouchOutside: true,
    showCloseIcon: false,
    title: title,
    desc: subtitle,
    btnOkText: "Ok",
    btnOkOnPress: () {},
  )..show();
}

showOkDialog(BuildContext context, String title, String subtitle,{Function? onOK, int? timehideSeconds}){
  double extraFontSize=0;

  AwesomeDialog(
    context: context,
    width: 500,
    dialogType: kIsWeb?DialogType.noHeader:DialogType.success,
    titleTextStyle: TextStyle(fontSize: 20+extraFontSize,fontWeight: FontWeight.w700,color: Colors.green),
    descTextStyle: TextStyle(fontSize: 17+extraFontSize,fontWeight: FontWeight.w300),
    headerAnimationLoop: false,
    animType: AnimType.scale,
    dismissOnBackKeyPress: true,
    dismissOnTouchOutside: true,
    showCloseIcon: false,
    autoHide: timehideSeconds!=null?Duration(seconds: timehideSeconds!):null,
    title: title,
    desc: subtitle,
    btnOkText: "Ok",
    btnOkOnPress: () {
      if(onOK!=null){
        onOK();
      }
    },
  )..show();
}


showCustomDialog(BuildContext context, String title, Widget content,{bool dismiss=true}){

  AwesomeDialog(
    context: context,
    width: 500,
    dialogType: DialogType.noHeader,
    titleTextStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),
    descTextStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.w300),
    headerAnimationLoop: false,
    animType: AnimType.scale,
    dismissOnBackKeyPress: dismiss,
    dismissOnTouchOutside: dismiss,
    showCloseIcon: dismiss,
    body: content,
    title: title,
  )..show();
}

Future<bool> showConfirmDialog(BuildContext context, String title, String subtitle,{bool dismiss=true, int? timehideSeconds, bool takeDissmis=false}) async {
  Completer<bool> completer = Completer<bool>();
  AwesomeDialog(
    context: context,
    width: 500,
    dialogType: kIsWeb ? DialogType.noHeader : DialogType.question,
    titleTextStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),
    descTextStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.w300),
    headerAnimationLoop: false,
    animType: AnimType.scale,
    dismissOnBackKeyPress: dismiss,
    dismissOnTouchOutside: dismiss,
    showCloseIcon: false,
    autoHide: timehideSeconds!=null?Duration(seconds: timehideSeconds!):null,
    title: title,
    desc: subtitle,
    btnOkText: "Sí",
      onDismissCallback:(DismissType value) {
      log("DismissType ${value.name}");
        if((value.name=="autoHide")&&takeDissmis){
          try {
            completer.complete(false);
          } catch (e) {

          }
        }
      },
    btnOkOnPress: () {
      try{
        completer.complete(true);
      }catch(e){

      }
    },
    btnCancelText: "No",
    btnCancelOnPress: () {
      try{
        completer.complete(false);
      }catch(e){

      }
    },
  )..show();

  return completer.future;
}