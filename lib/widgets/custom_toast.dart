import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

customErrorToast(BuildContext context,String text, int duration){
  double extraFontSize=0;

  return showToastWidget(
      Padding(
        padding: const EdgeInsets.symmetric(vertical:10,horizontal: 40),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 0,
            color: Colors.red.withOpacity(0.87),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  SizedBox(width: 15,),
                  Expanded(
                    child: Text(
                      text,style: TextStyle(fontSize: 16+extraFontSize,color:Colors.white),),
                  )
                ],
              ),
            )),
      ),
      context: context,
      duration: Duration(
        milliseconds: duration,
      ),
      alignment: Alignment.center,
      position: StyledToastPosition.center
  );
}


customOkToast(BuildContext context,String text, int duration){
  double extraFontSize=0;

  return showToastWidget(
      Padding(
        padding: const EdgeInsets.symmetric(vertical:10,horizontal: 40),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 0,
            color: Colors.green.withOpacity(0.9),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  SizedBox(width: 15,),
                  Expanded(
                    child: Text(
                      text,style: TextStyle(fontSize: 16+extraFontSize,color:Colors.white),),
                  )
                ],
              ),
            )),
      ),
      context: context,
      duration: Duration(
        milliseconds: duration,
      ),
      alignment: Alignment.center,
      position: StyledToastPosition.bottom
  );
}