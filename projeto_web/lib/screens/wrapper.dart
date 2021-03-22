import 'package:projeto_web/models/user.dart';
import 'package:projeto_web/screens/authenticate/authenticate.dart';
import 'package:projeto_web/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserUID>(context);

    if(user == null){
      return Authenticate();
    }else{
      return Home();
    }

  }
}