import 'package:flutter/material.dart';

class addCart extends ChangeNotifier
{
  var attributeMap = <Map>[];

  int total=0;

  void addData(Map input){
    int check=0;
    for(int i=0;i<attributeMap.length;i++)
    {
      if(attributeMap[i]['id']==input['id'])
      {
        attributeMap[i]['quantity']=(int.parse(attributeMap[i]['quantity'])+1).toString();
        check++;
      }
    }
    if(check==0)
    {
      attributeMap.add(input);
    }
    notifyListeners();
  }

  void deleteData(String input){
    for(int i=0;i<attributeMap.length;i++)
    {
      if(attributeMap[i]['id']==input)
      {
        attributeMap[i]['quantity']=(int.parse(attributeMap[i]['quantity'])-1).toString();

      }
    }

    notifyListeners();
  }


   calcTotal(){
    total=0;
    for(int i=0;i<attributeMap.length;i++)
    {

      total+=int.parse(attributeMap[i]['price'])*int.parse(attributeMap[i]['quantity']);

    }
    return total;
    notifyListeners();
  }

  void destoryAll(){
    attributeMap = <Map>[];
  }

  GetData(){
    print(attributeMap);
    return attributeMap;
  }

}