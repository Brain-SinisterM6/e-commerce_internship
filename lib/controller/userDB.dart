import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class UserService{

  final String uid;
  UserService ({this.uid});

  final CollectionReference userCollection=Firestore.instance.collection('users');


  Future updataAndAddUser(String name,String email,String pass ,String id, List orders) async
  {
    return await userCollection.document(uid).setData({
      'username':name,
      'email':email,
      'password':pass,
      'userId':id,
      'orders':orders
    });

  }

  //get user streem
  Stream<QuerySnapshot> get users{
    return userCollection.snapshots();
  }

}