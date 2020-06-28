import 'dart:convert';

import 'package:flutter/services.dart';

class MyData{

  List produc_list;
  Future<String> loadAStudentAsset() async {
    return await rootBundle.loadString('android/productData.json');
  }
  Future loadCrossword() async {
    produc_list = json.decode(await loadAStudentAsset());

  }




  myData() async{
    await loadCrossword();
     return produc_list;
  }



}