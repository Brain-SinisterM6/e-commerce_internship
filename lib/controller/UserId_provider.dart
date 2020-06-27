import 'package:flutter/material.dart';

class getuserid extends ChangeNotifier
{

  String data ;

  void addData(input){
    data=input;
    notifyListeners();
  }
  GetData(){
    return data;
  }

}