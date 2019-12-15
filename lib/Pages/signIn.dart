
import '../userScreens/myHomePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../userScreens/list_items.dart';
import '../userScreens/listItems.dart';
//import '../userScreens/listItems.dart';
class loginPage extends StatefulWidget {

  
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
var userID;
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser;
   initUser() async{
    firebaseUser = await _firebaseAuth.currentUser();
    userID = firebaseUser.uid;
    setState(() {});
  }
  @override
  void initState(){
    super.initState();
    initUser();
  }
  String _email , _password ;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text('Sign in'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator:(input){
                if(input.isEmpty){
                  return 'Please type email';
                }
              } ,
              onSaved:(input)=>_email = input,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),

             TextFormField(
              validator:(input){
                if(input.length < 6){
                  return 'Your password need to be at least 6 characters';
                }
              } ,
              onSaved:(input)=>_password = input,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            RaisedButton(
              onPressed: signIn,
              child: Text('Sign in'),
            )
          ],
        ),
      ),
    );

   
  }
   Future<void> signIn()async{
      final FormState = _formKey.currentState;

      if (FormState.validate()){
        FormState.save();
        try{
          AuthResult user =  await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _email,
         password:_password ) ;
         Navigator.push(context, MaterialPageRoute(builder: (context)=> AllProudct(currentId: userID,)));
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage()));
        }
        catch(e){
          print(e.message);
        }
      }
    }
}