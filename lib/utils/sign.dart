import 'package:flutter/material.dart';
import 'dart:async';
import '../pages/homePage.dart';
import '../pages/loginPage.dart';
import '../utils/session.dart' as userInfo;
import 'dart:convert';


class Sign {

  Future signIn(context, user, password, registrationToken) async {
    var jsontoken;

    print(user+':'+password);
    jsontoken = await main(user, password, registrationToken);

    if(jsontoken["status"] == "success"){

      userInfo.token = jsontoken["data"]["token"];
      userInfo.user = user;

      Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(
          builder: (BuildContext context) => new HomePage()),
          (Route route) => route == null
      );  
    }
    else{
      _showDialog(context, jsontoken);
    }
  }

  void _showDialog(context, jsontoken) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Login"),
          content: Text(jsontoken['msg']),//Text("Usuário ou senha incorretos"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void signOut(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Fazer Logout?"),
          content: new Text("Deseja mesmo fazer logout?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cancelar",style: TextStyle(color: Colors.black),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new RaisedButton(
              child: new Text("Confirmar",style: TextStyle(color: Colors.black),),
              color: Colors.grey,
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(
                  builder: (BuildContext context) => new LandingPage()), (
                  Route route) => route == null);
              },
            ),
          ],
        );
      },
    );  
  }

  Future<Map> main(user, password, registrationToken) async {
    var returnPacket;

    String url = userInfo.mainUrl+'/auth';
    Map map = {
      // 'username':user, 'password':password
      'email':user, 'password':password, 'registrationToken':registrationToken
    };

    json.encode(map);
    
    returnPacket = await userInfo.Session().post(url, map);

    return returnPacket;
  }
}