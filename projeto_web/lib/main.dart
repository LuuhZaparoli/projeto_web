import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_web/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projeto_web/service/auth.dart';
import 'package:provider/provider.dart';
import 'package:projeto_web/models/user.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserUID>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: new ThemeData(
          brightness: Brightness.light,
          colorScheme: ColorScheme.light().copyWith(
            primary: Colors.blueGrey,
            background: Colors.grey[900],
            onPrimary: Colors.white,
            onBackground: Colors.red,
          ),
          primaryColor: Colors.blueGrey,
          splashColor: Colors.blueGrey[800],
        ),
        home: Wrapper(),
      ),
    );
  }
}