import 'package:flutter/material.dart';

import '../utils/sign.dart';

import '../utils/style.dart';

class MyLogoWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // var assetImage = new AssetImage('assets/logo_fibo.png');
    // var image = new Image(image: assetImage, height: 94.0, width: 145.0);
    var image = new Image.asset('assets/2.0x/logo_fibo.png', height: 94.0, width: 145.0);
    return Container(child: image);
  }
}

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  String _registrationToken;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.lightBlueAccent,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new MyLogoWidget(),
          SizedBox(height: 70.0),
          Container(
            width: 350.0,
            child: //[Name]
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Email',
              ),
            ),
          ),
          //Space
          SizedBox(height: 12.0),
          Container(
            width: 350.0,
            child:
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Password',
              ),
              obscureText: true,
            ),
          ),
          SizedBox(height: 16.0),
          new FlatButton(
            onPressed: () => new Sign()
                .signIn(context, _usernameController.value.text, _passwordController.value.text, _registrationToken),
            child: new Text("Sign In",
                style: myStyle().getTextStyle(22.0, Colors.lightBlueAccent)),
            color: Colors.white,
            padding: const EdgeInsets.all(15.0),
          ),
          new Padding(
            padding: const EdgeInsets.all(20.0),
          ),
        ],
      ),
    );
  }
}
