import 'package:flutter/material.dart';
import 'package:projeto_web/service/auth.dart';
import 'package:projeto_web/shared/constants.dart';
import 'package:projeto_web/shared/loading.dart';

class RegisterPage extends StatefulWidget {

  final Function toggleView;
  RegisterPage({this.toggleView});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String name = '';
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          elevation: 0.0,
          title: Text('Cadastre uma nova conta'),
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 10.0),
              child: TextButton.icon(
                  icon: Icon(Icons.login_outlined ,color: Colors.black),
                  label: Text('Entrar',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: (){
                    widget.toggleView();
                  }
              ),
            ),
          ],
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Nome'),
                        validator: (val) => val.isEmpty ? 'Digite seu nome' : null,
                        onChanged: (val){
                          setState(() => name = val);

                        }
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'E-mail'),
                      validator: (val) => val.isEmpty ? 'Digite seu e-mail' : null,
                        onChanged: (val){
                          setState(() => email = val);

                        }
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Password'),
                        obscureText: true,
                        validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                        onChanged: (val){
                          setState(() => password = val);

                        }
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        color: Colors.blueGrey,
                        child: Text(
                          'Cadastrar',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async{
                          if(_formKey.currentState.validate()){
                            setState(() => loading = true);
                            dynamic result = await _auth.registerWithEmailAndPassword(name, email, password);
                            if(result == null){
                              setState(() =>
                              error = 'please supply a valid e-mail');
                              loading = false;
                            }
                          }

                        }
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    )
                  ],
                )
            )
        )
    );
  }
}
