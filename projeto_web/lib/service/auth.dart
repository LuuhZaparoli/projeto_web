import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_web/models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Criando user Objetct baseado no FirebaseUser
  UserUID _userFromFirebaseUser (User user){
    return user != null ? UserUID(uid: user.uid) : null;
  }

  //user stream
  Stream<UserUID> get user{
    return _auth.authStateChanges()
      .map(_userFromFirebaseUser);

  }

  //Sign in anon
  Future signInAnon() async{
  try{
    //AuthResult virou UserCredential
    UserCredential result = await _auth.signInAnonymously();
    //FirebaseUser virou User
    User user = result.user;
    return _userFromFirebaseUser(user);
  }catch(e){
    print(e.toString());
    return null;
  }
  }
  //Sign in e-mail and password

  //Register e-mail and password

  //Sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}