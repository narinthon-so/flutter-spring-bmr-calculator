import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'widgets.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SighIn(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyApp();
  }
}

class _MyApp extends State {
  TextEditingController _high = TextEditingController();
  TextEditingController _weight = TextEditingController();
  TextEditingController _age = TextEditingController();
  double bmr, tdee;
  String strBmr = "";
  String strTdee = "";
  String txtBmr = "";
  String txtTdee = "";

  var _sexAll = ['ชาย', 'หญิง'];
  var _currentSex = 'ชาย';

  var _activityAll = [
    'ไม่ได้ออกกำลังกายเลย',
    'ออกกำลังกายประมาณอาทิตย์ละ 1-3 วัน',
    'ออกกำลังกายประมาณอาทิตย์ละ 3-5 วัน',
    'ออกกำลังกายประมาณอาทิตย์ละ 6-7 วัน',
    'ออกกำลังกายอย่างหนักทุกวันเช้าเย็น'
  ];
  var _currentActivity = 'ไม่ได้ออกกำลังกายเลย';

  void onCalculate() {
    print('oncalculate...');
    int high, weight, age;
    high = int.parse(_high.text);
    weight = int.parse(_weight.text);
    age = int.parse(_age.text);
    if (_currentSex == 'ชาย') {
      bmr = (66 + (13.7 * weight) + (5 * high) - (6.8 * age));
    } else if (_currentSex == 'หญิง') {
      bmr = (665 + (9.6 * weight) + (1.8 * high) - (4.7 * age));
    }
    if (_currentActivity == 'ไม่ได้ออกกำลังกายเลย') {
      tdee = bmr * 1.2;
    }else if (_currentActivity == 'ออกกำลังกายประมาณอาทิตย์ละ 1-3 วัน') {
      tdee = bmr * 1.375;
    }else if (_currentActivity == 'ออกกำลังกายประมาณอาทิตย์ละ 3-5 วัน') {
      tdee = bmr * 1.55;
    }else if (_currentActivity == 'ออกกำลังกายประมาณอาทิตย์ละ 6-7 วัน') {
      tdee = bmr * 1.725;
    }
    else if (_currentActivity == 'ออกกำลังกายอย่างหนักทุกวันเช้าเย็น') {
      tdee = bmr * 1.9;
    }
    strBmr = bmr.toString();
    strTdee = tdee.toString();
    txtBmr = "BMR (Basal Metabolic Rate) พลังงานที่จำเป็นพื้นฐานในการมีชีวิต " +
        strBmr +
        " กิโลแคลอรี่";
    txtTdee = "TDEE (Total Daily Energy Expenditure) พลังงานที่คุณใช้ในแต่ละวัน " +strTdee+ " กิโลแคลอรี่";
    print(high);
    print(weight);
    print(age);
    print(bmr);
    print(tdee);
    print(_currentSex);
    print(_currentActivity);
//    Map params = Map();
//    params['name'] = _name.text;
//    params['description'] = _description.text;
//    params['price'] = _price.text;
//    http.post('${Config.API_URL}/product/save', body: params).then((res) {
//      print(res.body);
//    }).catchError((err) {
//      print(err);
//    });
    setState(() {});
  }

  void initState() {
    print('initstate...');
    http.post('${Config.API_URL}/user/list').then((res) {
      print(res.body); 
//      Map retMap = jsonDecode(res.body);
//      List lst = retMap['data'] as List;
//      for (Map mapData in lst) {
//        print(mapData['userName']);
//      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('คำนวณ bmr'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            child: DropdownButton<String>(
              items: _sexAll.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem),
                );
              }).toList(),
              onChanged: (String newValueSelected) {
                _onDropDownSexSelected(newValueSelected);
              },
              value: _currentSex,
            ),
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          ),
          Padding(
            child: DropdownButton<String>(
              items: _activityAll.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem),
                );
              }).toList(),
              onChanged: (String newValueSelected) {
                _onDropDownActivitySelected(newValueSelected);
              },
              value: _currentActivity,
            ),
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          ),
          Padding(
            child: TextField(
              controller: _high,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  //hintText: 'ส่วนสูง/เซ็นติเมตร',
                  labelText: 'ส่วนสูง/เซ็นติเมตร',
                  suffixIcon: IconButton(
                    onPressed: () => _high.clear(),
                    icon: Icon(Icons.clear),
                  )),
            ),
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          ),
          Padding(
            child: TextField(
              controller: _weight,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                 // hintText: 'น้ำหนัก/กิโลกรัม',
                  labelText: 'น้ำหนัก/กิโลกรัม',
                  suffixIcon: IconButton(
                    onPressed: () => _weight.clear(),
                    icon: Icon(Icons.clear),
                  )),
            ),
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          ),
          Padding(
            child: TextField(
              controller: _age,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  //hintText: 'อายุ/ปี',
                  labelText: 'อายุ/ปี',
                  suffixIcon: IconButton(
                    onPressed: () => _age.clear(),
                    icon: Icon(Icons.clear),
                  )),
            ),
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          ),
          Padding(
            child: RaisedButton(
              child: Text('คำนวณ'),
              onPressed: onCalculate,
            ),
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          ),
          Padding(
            child: Text(txtBmr),
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          ),
          Padding(
            child: Text(txtTdee),
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          ),

//          RaisedButton(
//            child: Text('productdetail'),
//            onPressed: () {
//              Navigator.push(context,
//                  MaterialPageRoute(builder: (context) => ProductDetail()));
//            },
//          )
        ],
      ),
    );
  }

  void _onDropDownSexSelected(String newValueSelected) {
    setState(() {
      this._currentSex = newValueSelected;
    });
  }

  void _onDropDownActivitySelected(String newValueSelected) {
    setState(() {
      this._currentActivity = newValueSelected;
    });
  }
}

//class ProductDetail extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return _ProductDetail();
//  }
//}
//
//class _ProductDetail extends State {
//  TextEditingController _id = TextEditingController();
//  String _name = "";
//  String _description = "";
//  String _price = "";
//
//  void onDetail() {
//    print('ondetail...');
//    Map params = Map();
//    params['productId'] = _id.text;
//    http.post('${Config.API_URL}/product/detail', body: params).then((res) {
//      print(res.body);
//      Map retMap = jsonDecode(res.body);
//      Map lst = retMap['data'] as Map;
//      int status = retMap['status'];
//      if (status == 1) {
//        _name = lst['name'];
//        _description = lst['description'];
//        _price = lst['price'].toString();
//        print(_name);
//        print(_description);
//        print(_price);
//        setState(() {});
//      } else {
//        _name = "";
//        _description = "Data not found";
//        _price = "";
//        setState(() {});
//      }
//    }).catchError((err) {
//      print('Data not found');
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('productdetail'),
//      ),
//      body: ListView(
//        children: <Widget>[
//          TextField(
//            controller: _id,
//            keyboardType: TextInputType.number,
//            decoration: InputDecoration(hintText: 'product ID'),
//          ),
//          Text(_name),
//          Text(_description),
//          Text(_price),
//          RaisedButton(
//            child: Text('ok'),
//            onPressed: onDetail,
//          )
//        ],
//      ),
//    );
//  }
//}
