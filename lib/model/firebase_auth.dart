

import 'package:ecommerceapp/controller/userDB.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signup( String name,String email,String password )async{
    try{
      AuthResult result =await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user;
      await UserService(uid:user.uid).updataAndAddUser(name, email, password,user.uid ,[""]);

      return user.uid.toString();
    } catch(e){
      print(e);
      print('false');
        return 'false' ;
    }
  }


  Future  signInWithEmail(String email, String password) async{
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email,password: password);
      FirebaseUser user = result.user;
      if(user != null) {


        return user.uid;
      }
      else {

        return false;
      }

    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("error logging out");
    }
  }

}