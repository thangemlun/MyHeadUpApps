import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoaderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
          children: [
            const Spacer(),
            Center(child: Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Image.asset('assets/images/note-logo.png',
                  height: 250,
                  width: MediaQuery.of(context).size.width * 0.5
              	),
            	),
            ),
            const Spacer(),
            Container(
              margin: EdgeInsets.only(bottom: 80),
              child: SpinKitCircle(
                  size: MediaQuery.of(context).size.width * 0.2,
                  color: Color(0xff9fd5d7),
                ),
            ),
          ],
        ),
      );
  }
  
}