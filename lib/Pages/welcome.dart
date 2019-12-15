
import '../Pages/signIn.dart';
import '../Pages/signUp.dart';
import 'package:flutter/material.dart';

class welcomePage extends StatefulWidget {
  @override
  _welcomePageState createState() => _welcomePageState();
}

class _welcomePageState extends State<welcomePage>{
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My first firebase app'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
           RaisedButton(
              onPressed:navigateToSignIn,
              child: Text('Sign in'),
            ),

            RaisedButton(
              onPressed: navigateToSignUp,
              child: Text('Sign up'),
            ),

        ],
      ),
    );
  }

  void navigateToSignIn()
  {
     Navigator.push(context, MaterialPageRoute(builder: (context)=> loginPage(), fullscreenDialog: true));
        
  }

  void navigateToSignUp()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> signUp(), fullscreenDialog: true));
  }
}