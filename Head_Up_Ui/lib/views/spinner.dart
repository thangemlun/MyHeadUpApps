import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Spinner {

  static void trigger(BuildContext context) {
    showAdaptiveDialog(
      context: context,
      // Prevents closing the dialog by tapping outside
      builder: (BuildContext context) {
        return Dialog(
            backgroundColor: Colors.transparent, // Make the dialog background transparent
            child: SpinKitChasingDots(
            size: MediaQuery.of(context).size.width * 0.05,
        		color: Color(0xff9fd5d7),)
        	);
        },
    );
  }

  static void off(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

}