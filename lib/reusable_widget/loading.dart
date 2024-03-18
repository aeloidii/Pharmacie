import 'package:adminsignin/utils/colorutils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/cupertino.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(


          child: SpinKitFadingCircle(
            color: Colors.black,
            size: 30,
          )
      ),
    );
  }
}

class Loadingpas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors:[hexSrtingToColor("20B2AA"),hexSrtingToColor("00816D"),hexSrtingToColor("BCF0AC")],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),

          child: SpinKitFadingCircle(
            color: Colors.black,
            size: 30,
          )
      ),
    );
  }
}