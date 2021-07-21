import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.grey[900],
      child: Center(
        child: SpinKitFadingCircle(
          color: Colors.blueGrey,
          size: 50.0,
        ),
      ),
    );
  }
}