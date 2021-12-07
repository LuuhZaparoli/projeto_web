import 'package:flutter/material.dart';
import 'package:projeto_web/screens/authenticate/register_page.dart';
import 'package:projeto_web/service/auth.dart';
import 'package:projeto_web/shared/constants.dart';
import 'package:projeto_web/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

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
        title: Text('Acesse sua conta'),
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: TextButton.icon(
                icon: Icon(Icons.person_add ,color: Colors.black),
                label: Text('Cadastrar',
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
                  decoration: textInputDecoration.copyWith(hintText: 'E-mail'),
                  validator: (val) => val.isEmpty ? 'Digite um e-mail' : null,
                onChanged: (val){
                  setState(() => email = val);

                }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Senha'),
                  validator: (val) => val.length < 6 ? 'Digite uma senha com pelo menos 6 caracteres' : null,
                  obscureText: true,
                onChanged: (val){
                  setState(() => password = val);

                }
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.blueGrey,
                child: Text(
                 'Entrar',
                 style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() => loading = true);
                    dynamic result = await _auth.signInWithEmailAndPassword(
                        email, password);
                    if (result == null) {
                      setState(() =>
                      error = 'Não foi possível se conectar com essas credenciais');
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
