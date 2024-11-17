import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClipBoardUtil {
  static void saveToClipBoard(BuildContext context, String data) {
    Clipboard.setData(ClipboardData(text: data));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied to Clipboard!',style: TextStyle(
          color: Colors.teal,
          fontSize: 20,
          fontWeight: FontWeight.w800
      ),),
        backgroundColor: Color(0xffcfe7e8),
        duration: Duration(milliseconds: 800),),
    );
  }

}
