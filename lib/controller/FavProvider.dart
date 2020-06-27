import 'package:flutter/material.dart';

class favCart extends ChangeNotifier
{
  var attributeMap = <Map>[];


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
  GetData(){
    print(attributeMap);
    return attributeMap;
  }

  deleteData(String input){
    for(int i=0;i<attributeMap.length;i++)
    {
      if(attributeMap[i]['id']==input)
      {
        attributeMap.removeAt(i);

      }
    }

    notifyListeners();
  }

}