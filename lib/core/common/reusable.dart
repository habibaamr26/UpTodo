

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// navigate
void navigate({required context,required Widget screen})=>
    Navigator.push(context,MaterialPageRoute(builder: (_){
return screen;
}));



// Text button

Widget customButton({
  double width=double.infinity,
  double height=50,
  context,
  required String text,
  int color= 0xFF8875FF,
  required void Function()? onPressed
})=> Container(

width:width ,
height: height,
decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(4),
  color: Color(color),
),

child: TextButton(
onPressed: onPressed,
child: Text(
  text,
style: Theme.of(context).textTheme.displayMedium,
)),
);




void showToast({
  required String message,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: getState(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { error, success, warining }

Color getState(ToastStates state) {
  switch (state) {
    case ToastStates.error:
      return Colors.red;
    case ToastStates.success:
      return Color(0xFF8875FF);
    case ToastStates.warining:
      return Colors.orange;
  }
}