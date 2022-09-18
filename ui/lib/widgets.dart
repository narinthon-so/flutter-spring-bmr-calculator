import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/main.dart';
import 'config.dart';
import 'package:http/http.dart' as http;

class SighIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SighIn();
  }
}

class _SighIn extends State<SighIn> {
  TextEditingController _userName = TextEditingController();
  TextEditingController _passWord = TextEditingController();

  String txt = "";

  void onSighIn() {
    print("onsighin...");
    Map params = Map();
    params['userName'] = _userName.text;
    params['passWord'] = _passWord.text;
    http.post('${Config.API_URL}/user/login', body: params).then((res) {
      print(res.body);
      Map resMap = jsonDecode(res.body);
      int status = resMap['status'];
      if (status == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
      } else {
        this.txt = "ชื่อผู้ใช้หรือหรัสผ่านไม่ถูกต้อง";
        setState(() {});
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('เข้าสู่ระบบ'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            child: Text(
              'Sigh In',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ),
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          ),
          Padding(
            child: TextField(
              controller: _userName,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          ),
          Padding(
            child: TextField(
              controller: _passWord,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          ),
          Padding(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    child: Text('Sigh In'),
                    onPressed: onSighIn,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                ),
                Expanded(
                  child: RaisedButton(
                    child: Text('Sigh Up'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SighUp()));
                    },
                  ),
                )
              ],
            ),
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          ),
          Padding(
            child: Text(
              txt,
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
          ),
        ],
      ),
    );
  }
}

class SighUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SighUp();
  }
}

class _SighUp extends State<SighUp> {
  TextEditingController _userName = TextEditingController();
  TextEditingController _passWord = TextEditingController();
  String txtAlert = "";

  void onSighUp() {
    print("onsighup...");
    Map params = Map();
    params['userName'] = _userName.text;
    params['passWord'] = _passWord.text;
    http.post('${Config.API_URL}/user/save', body: params).then((res) {
      print(res.body);
      Map resMap = jsonDecode(res.body);
      int status = resMap['status'];
      //print(status);
      if (status == 0) {
        this.txtAlert = "สมัครสมาชิกสำเร็จ กรุณาเข้าสู่ระบบ";
        setState(() {});
      } else {
        this.txtAlert = "มีผู้ใช้แล้ว";
        setState(() {});
      }
      print(txtAlert);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('สมัครสมาชิก'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            child: Text(
              'Sigh Up',
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          ),
          Padding(
            child: TextField(
              controller: _userName,
              decoration: InputDecoration(
                labelText: 'Enter your Username',
              ),
            ),
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          ),
          Padding(
            child: TextField(
              controller: _passWord,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Enter your Password',
              ),
            ),
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          ),
          Padding(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    child: Text('Sigh In'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SighIn()));
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                ),
                Expanded(
                  child: RaisedButton(
                    child: Text('Sigh Up'),
                    onPressed: onSighUp,
                  ),
                )
              ],
            ),
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          ),
          Padding(
            child: Text(
              txtAlert,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red),
            ),
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
          )
        ],
      ),
    );
  }
}
