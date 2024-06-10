import 'package:flutter/material.dart';

Widget CustomButton({Color? backColor, Widget? child,Function? onPressed, bool loading=false}) {
  return ElevatedButton(
      onPressed: loading?null:() {
        if(onPressed!=null){
          onPressed();
        }
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: loading?Colors.grey:backColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 15,
      ),
      child: loading?CircularProgressIndicator():child);
}
